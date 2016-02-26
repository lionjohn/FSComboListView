//
//  IQComboPickerView.m
//  iQuestionnaire
//
//  Created by PwC on 1/24/14.
//  Copyright (c) 2013 Eli Lilly. All rights reserved.
//


#import "FSComboListView.h"
#import "UIImage+FSAdditions.h"

#define BORDER_WIDTH 1.5f
#define BORDER_OFFSET (BORDER_WIDTH / 2)
#define ARROW_BOX_WIDTH 32.0f
#define ARROW_WIDTH 14.0f
#define ARROW_HEIGHT 11.0f

#define FONT_NAME @"helvetica Neue"
#define TEXT_LEFT 15.0f
#define COMBOBOX_HEIGHT 34.0f
#define COMBOBOX_MARGIN 0.0f

#define PICKER_VIEW_HEIGHT 180.0f

#define COMBOX_VIEW_MIN_WIDTH (280.0f-270)
#define COMBOX_VIEW_MAX_WIDTH 600.0f

 

@implementation FSComboListView


- (void)initialize
{
    _isActive = NO;
    
    self.backgroundColor = [UIColor clearColor];
    
 
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(COMBOBOX_MARGIN, COMBOBOX_HEIGHT + 1, CGRectGetWidth(self.frame) - COMBOBOX_MARGIN * 2, PICKER_VIEW_HEIGHT)];
    [_pickerView setShowsSelectionIndicator:YES];
    [_pickerView setDataSource:self];
    [_pickerView setDelegate:self];
    
    [_pickerView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]];
    _pickerView.layer.cornerRadius = 5;
//    [self.pickerView selectRow:[self.values indexOfObject:[self currentValue]] inComponent:0 animated:NO];
    [_pickerView setHidden:YES];
    
    [self addSubview:_pickerView];
    
    UIControl *dropButton =  [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, COMBOBOX_HEIGHT)];
    [dropButton addTarget:self action:@selector(comboxBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dropButton];
    
    //label
    CGRect frame = dropButton.frame;
    UILabel *the_label = [[UILabel alloc] init];
    the_label.frame = frame;
    the_label.text = [_values objectAtIndex:0];
    the_label.font = [UIFont systemFontOfSize:14];
    the_label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:the_label];
    [the_label.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [the_label.layer setBorderWidth:1];
    [the_label.layer setCornerRadius:10];
    the_label.backgroundColor = [UIColor clearColor];
    _valueLabel = the_label;
    
    // arrow
    UIImage *icon = [UIImage imageNamed:@"FSComboListView.bundle/comboDownArrow.png"];
    icon = [icon imageWithTintColor:[UIColor whiteColor]];
    _arrowImgV = [[UIImageView alloc] initWithImage:icon];
    _arrowImgV.frame = CGRectMake(frame.size.width-COMBOBOX_HEIGHT, 0, COMBOBOX_HEIGHT, COMBOBOX_HEIGHT);
    _arrowImgV.contentMode = UIViewContentModeCenter;
    [the_label addSubview:_arrowImgV];
    
}


- (id)initWithValues:(NSArray *)values frame:(CGRect)frameRect
{
    
    self = [self init];
    if (self) {
        
        
        _values = values;

        
        CGFloat frameWidth = frameRect.size.width;
        
        for (NSString* option in _values) {
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
            CGRect rect = [option boundingRectWithSize:CGSizeMake(MAXFLOAT, 40)
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:@{NSParagraphStyleAttributeName: paragraphStyle,NSFontAttributeName: [UIFont systemFontOfSize:19]}
                                                                context:nil];
            CGSize detailSize = rect.size;
            
            if (detailSize.width > frameWidth) {
                frameWidth = detailSize.width + 100;
            }
        }
        
        if (frameWidth > COMBOX_VIEW_MAX_WIDTH) {
            frameWidth = COMBOX_VIEW_MAX_WIDTH;
        }
        
        [self setFrame:CGRectMake(frameRect.origin.x, frameRect.origin.y, frameWidth, COMBOBOX_HEIGHT)];

        
        [self initialize];
        
        
        [_pickerView reloadAllComponents];
        if ([_values indexOfObject:_currentValue] != NSNotFound)
        {
            [_pickerView selectRow:[_values indexOfObject:_currentValue] inComponent:0 animated:NO];
            _valueLabel.text = _currentValue;
        }
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        //[self initialize];
        self.clipsToBounds = YES;

    }
    return self;
}


- (void)createMaskView
{
    if (!_maskView) {
        _maskView = [[UIControl alloc] initWithFrame:self.superview.bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.3;
        [_maskView addTarget:self action:@selector(maskViewTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.superview insertSubview:_maskView belowSubview:self];
    }

}


- (void)setTintColor:(UIColor*)tintColor
{
    UIImage *image = _arrowImgV.image;
    image = [image imageWithTintColor:tintColor];
    _arrowImgV.image = image;
    
    [_valueLabel.layer setBorderColor:tintColor.CGColor];
    
    [_pickerView setBackgroundColor:tintColor];
}

- (void)setTextColor:(UIColor*)textColor
{
    _valueLabel.textColor = textColor;
}

- (void)selectRowAtIndex:(NSUInteger)rowIndex
{
    [_pickerView selectRow:rowIndex inComponent:0 animated:NO];
    _currentValue = [_values objectAtIndex:rowIndex];
    _valueLabel.text = _currentValue;
    _selectedRow = rowIndex;
}

- (void)maskViewTapped:(id)sender
{
    [self dismiss];
}

- (void)setValues:(NSArray *)newValues
{
    _values = newValues;
    [_pickerView reloadAllComponents];
    if ([_values indexOfObject:_currentValue] != NSNotFound)
    {
        [_pickerView selectRow:[_values indexOfObject:_currentValue] inComponent:0 animated:NO];
    }
}

- (void)setCurrentValue:(NSString *)currentValue
{
    _currentValue = currentValue;
    _valueLabel.text = currentValue;
    if ([_values indexOfObject:currentValue] != NSNotFound)
    {
        _selectedRow = [_values indexOfObject:currentValue];
        [_pickerView selectRow:_selectedRow inComponent:0 animated:NO];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_values count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_values objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return COMBOBOX_HEIGHT;
}
/***********************************************************
 **  UIPICKERVIEW DELEGATE COMMANDS
 **********************************************************/
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self setCurrentValue:[_values objectAtIndex:row]];
    
    if ([self.delegate respondsToSelector:@selector(comboboxChanged:toValue:)])
    {
        [self.delegate comboboxChanged:self toValue:[_values objectAtIndex:row]];
    }
    [self dismiss];
}


 

- (void)comboxBtnPressed
{
 
    _isActive = !_isActive;
    
 
    
    [_pickerView setHidden:NO];
    
    CGRect tempRect = self.frame;
    
    if (!_isActive) {
        _pickerView.alpha = 1.0f;
        tempRect.size.height = COMBOBOX_HEIGHT;

    }
    else{
        _pickerView.alpha = 0.0f;
        tempRect.size.height = COMBOBOX_HEIGHT + PICKER_VIEW_HEIGHT;
        
        
        if ([[self delegate] respondsToSelector:@selector(comboboxOpened:)])
        {
            [[self delegate] comboboxOpened:self];
        }
        
        [self createMaskView];
    }
    
    self.frame = tempRect;
    
    [UIView animateWithDuration:0.3 animations:^{
        if (_isActive) {
            _pickerView.alpha = 1.0f;
        }
        else{
            _pickerView.alpha = 0.0f;
            _maskView.alpha = 0.0f;
        }

        
    } completion:^(BOOL finished) {
        
        [_pickerView setHidden:!_isActive];

        
        if (!_isActive)
        {
            [_maskView removeFromSuperview];
            _maskView = nil;
            if ([[self delegate] respondsToSelector:@selector(comboboxClosed:)])
            {
                [[self delegate] comboboxClosed:self];
            }
        }
        
    }];
    
    
    
}

- (void)dismiss
{
    if (_isActive) {
        [self comboxBtnPressed];
    }
}

@end