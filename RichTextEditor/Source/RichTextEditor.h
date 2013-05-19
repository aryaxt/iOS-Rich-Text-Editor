//
//  RichTextEditor.h
//  RichTextEditor
//
//  Created by Aryan Gh on 5/4/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "UIFont+Additions.h"
#import "ColorPickerView.h"
#import "FontPickerView.h"
#import "FontSizePickerView.h"
#import "RichTextToolbar.h"

typedef enum {
	ColorPickerViewActionTextColor,
	ColorPickerViewActionTextBackgroundColor
}ColorPickerViewAction;

@interface RichTextEditor : UIView <ColorPickerViewDelegate, FontPickerViewDelegate, FontSizePickerViewDelegate, RichTextToolbarDelegate, UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) UIFont *defaultFont;
@property (nonatomic, strong) ColorPickerView *colorPickerView;
@property (nonatomic, strong) FontPickerView *fontPickerView;
@property (nonatomic, strong) FontSizePickerView *fontSizePickerView;
@property (nonatomic, strong) RichTextToolbar *toolbar;
@property (nonatomic, assign) BOOL shouldAttachToolbarToKeyboard;

@end
