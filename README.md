# FSComboListView

This library provides a comboList view with support of customized styles.

[![CI Status](http://img.shields.io/travis/Azuritul/AZDropdownMenu.svg?style=flat)](https://travis-ci.org/lionjohn/AZDropdownMenu)
[![License](https://img.shields.io/cocoapods/l/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)
[![Platform](https://img.shields.io/cocoapods/p/AZDropdownMenu.svg?style=flat)](http://cocoapods.org/pods/AZDropdownMenu)


## Screenshots
Code used in the screencast are included in the bundled sample project.

![screencast](https://raw.githubusercontent.com/lionjohn/FSComboListView/master/Example/FSComboListView%20Demo/screenshot.gif)



How To Use
----------


```objective-c
#import "FSComboListView.h"

...

    FSComboListView *comboListView = [[FSComboListView alloc] initWithValues:@[@"Value 1",
                                                                               @"Value 2",
                                                                               @"Value 3",
                                                                               @"Value 4",
                                                                               @"Value 5"]
                                                                       frame:CGRectMake(0, 0, 300, 40)];
    comboListView.delegate = self;
    comboListView.tintColor = [UIColor darkGrayColor];
    comboListView.textColor = [UIColor darkGrayColor];
    
    comboListView.center = self.view.center;
    
    [self.view addSubview:comboListView];
```

## Demo Project

To run the demo project, download and unzip the code.  `https://github.com/lionjohn/FSComboListView/tree/master/Example`


## Requirements
- iOS 7 or above


Future Enhancements
-------------------

- Enalbe blocks;
- Swift support;

## Author
Lion John, lion.john@icloud.com

## Licenses

All source code is licensed under the [MIT License](https://github.com/lionjohn/FSComboListView/blob/master/LICENSE).

	
