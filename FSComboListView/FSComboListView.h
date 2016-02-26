//
//  IQComboPickerView.h
//  iQuestionnaire
//
//  Created by PwC on 1/24/14.
//  Copyright (c) 2013 Eli Lilly. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <UIKit/UIResponder.h>

typedef NS_ENUM(NSUInteger, FSComboListType) {
    comboListTypePicker,
    comboListTypeTable,
};

@protocol FSComboPickerViewDelegate;

@interface FSComboListView : UIControl <UIPickerViewDataSource, UIPickerViewDelegate>
{
    BOOL           _isActive;
    UILabel        *_valueLabel;
    UIPickerView   *_pickerView;
    NSArray        *_values;
    UIImageView    *_arrowImgV;
    
    UIControl      *_maskView;
}


@property (nonatomic, strong) NSString *currentValue;
@property (nonatomic, assign) NSUInteger selectedRow;
@property (nonatomic, strong) id<FSComboPickerViewDelegate> delegate;
@property (nonatomic) FSComboListType Combotype;

- (void)setTintColor:(UIColor*)tintColor;
- (void)setTextColor:(UIColor*)textColor;

- (id)initWithValues:(NSArray *)values
               frame:(CGRect)frameRect;
- (void)setValues:(NSArray *)newValues;

- (void)selectRowAtIndex:(NSUInteger)rowIndex;
- (void)dismiss;



@end

@protocol FSComboPickerViewDelegate <NSObject>
@optional
- (void) comboboxOpened:(FSComboListView *)combobox;
- (void) comboboxClosed:(FSComboListView *)combobox;
- (void) comboboxChanged:(FSComboListView *)combobox toValue:(NSString *)toValue;
@end