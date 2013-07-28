//
//  RichTextEditorToolbar.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
	RichTextEditorToolbarPresentationStyleModal,
	RichTextEditorToolbarPresentationStylePopover
}RichTextEditorToolbarPresentationStyle;

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
- (NSArray *)fontFamilySelectionForRichTextEditorToolbar;
- (RichTextEditorToolbarPresentationStyle)presentarionStyleForRichTextEditorToolbar;
- (UIModalPresentationStyle)modalPresentationStyleForRichTextEditorToolbar;
- (UIModalTransitionStyle)modalTransitionStyleForRichTextEditorToolbar;
- (UIViewController *)firsAvailableViewControllerForRichTextEditorToolbar;
@end

@interface RichTextEditorToolbar : UIScrollView

@property (nonatomic, weak) id <RichTextEditorToolbarDelegate> delegate;
@property (nonatomic, weak) id <RichTextEditorToolbarDataSource> dataSource;

- (void)updateStateWithAttributes:(NSDictionary *)attributes;

@end
