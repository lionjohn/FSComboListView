# FSComboListView

This library provides a comboList view with support of customized styles.

[![Pod License](http://img.shields.io/cocoapods/l/SDWebImage.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)



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


### Add the FSComboListView to your project

- Download and unzip the last version of the framework from the [download page](https://github.com/lionjohn/FSComboListView/releases)
- Right-click on the project navigator and select "Add Files to "Your Project":
- In the dialog, select FSComboListView folder:
- Check the "Copy items into destination group's folder (if needed)" checkbox


### Import headers in your source files

In the source files where you need to use the library, import the header file:

```objective-c
#import "FSComboListView.h"
```

### Build Project

At this point your workspace should build without error. If you are having problem, post to the Issue and the
community can help you solve it.

Future Enhancements
-------------------

- Enalbe blocks;
- Swift support;

## Licenses

All source code is licensed under the [MIT License](https://github.com/lionjohn/FSComboListView/blob/master/LICENSE).

	
