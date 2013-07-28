//
//  RichTextEditorToolbar.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "RichTextEditorPopover.h"
#import "RichTextEditorFontSizePickerViewController.h"
#import "RichTextEditorFontPickerViewController.h"
#import "RichTextEditorColorPickerViewController.h"
#import "WEPopoverController.h"
#import "RichTextEditorToggleButton.h"
#import "UIFont+RichTextEditor.h"

@protocol RichTextEditorToolbarDelegate <UIScrollViewDelegate>
- (void)richTextEditorToolbarDidSelectBold;
- (void)richTextEditorToolbarDidSelectItalic;
- (void)richTextEditorToolbarDidSelectUnderline;
- (void)richTextEditorToolbarDidSelectFontSize:(NSNumber *)fontSize;
- (void)richTextEditorToolbarDidSelectFontWithName:(NSString *)fontName;
- (void)richTextEditorToolbarDidSelectTextBackgroundColor:(UIColor *)color;
- (void)richTextEditorToolbarDidSelectTextForegroundColor:(UIColor *)color;
- (void)richTextEditorToolbarDidSelectTextAlignment:(NSTextAlignment)textAlignment;
@end

@protocol RichTextEditorToolbarDataSource
- (NSArray *)fontSizeSelectionForRichTextEditorToolbar;
- (NSArray *)fontFamilySelectionForichTextEditorToolbar;
@end

@interface RichTextEditorToolbar : UIScrollView <RichTextEditorFontSizePickerViewControllerDelegate, RichTextEditorFontPickerViewControllerDelegate, RichTextEditorColorPickerViewControllerDelegate>

@property (nonatomic, weak) id <RichTextEditorToolbarDelegate> delegate;
@property (nonatomic, weak) id <RichTextEditorToolbarDataSource> dataSource;

- (void)updateStateWithAttributes:(NSDictionary *)attributes;

@end
