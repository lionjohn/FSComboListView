/*
 * This file is part of the FSComboListView package.
 * (c) John <lion.john@icloud.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */


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

@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *popupBackgroudColor;

@property (nonatomic, readonly, strong) NSString *currentValue;
@property (nonatomic, readonly, assign) NSUInteger selectedRow;
@property (nonatomic, strong) id<FSComboPickerViewDelegate> delegate;
@property (nonatomic) FSComboListType Combotype;


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