//
//  RichTextEditorToolbar.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RichTextEditorPopover.h"
#import "RichTextEditorFontSizePickerViewController.h"
#import "RichTextEditorFontPickerViewController.h"
#import "RichTextEditorColorPickerViewController.h"
#import "WEPopoverController.h"

@protocol RichTextEditorToolbarDelegate <NSObject>
- (void)richTextEditorToolbarDidSelectBold;
- (void)richTextEditorToolbarDidSelectItalic;
- (void)richTextEditorToolbarDidSelectUnderline;
- (void)richTextEditorToolbarDidSelectBulletPoint;
- (void)richTextEditorToolbarDidSelectFontSize:(NSNumber *)fontSize;
- (void)richTextEditorToolbarDidSelectFontWithName:(NSString *)fontName;
- (void)richTextEditorToolbarDidSelectTextBackgroundColor:(UIColor *)color;
- (void)richTextEditorToolbarDidSelectTextForegroundColor:(UIColor *)color;
- (void)richTextEditorToolbarDidSelectTextAlignment:(NSTextAlignment)textAlignment;
@end

@interface RichTextEditorToolbar : UIToolbar <RichTextEditorFontSizePickerViewControllerDelegate, RichTextEditorFontPickerViewControllerDelegate, RichTextEditorColorPickerViewControllerDelegate>

@property (nonatomic, weak) id <RichTextEditorToolbarDelegate> delegate;
@property (nonatomic, strong) id <RichTextEditorPopover> popover;

@end
