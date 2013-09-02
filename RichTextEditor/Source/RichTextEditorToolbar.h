//
//  RichTextEditorToolbar.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
// https://github.com/aryaxt/iOS-Rich-Text-Editor
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

typedef enum{
	RichTextEditorToolbarPresentationStyleModal,
	RichTextEditorToolbarPresentationStylePopover
}RichTextEditorToolbarPresentationStyle;

typedef enum{
	ParagraphIndentationIncrease,
	ParagraphIndentationDecrease
}ParagraphIndentation;

typedef enum{
	RichTextEditorFeatureNone							= 0,
	RichTextEditorFeatureFont							= 1 << 0,
	RichTextEditorFeatureFontSize						= 1 << 1,
	RichTextEditorFeatureBold							= 1 << 2,
	RichTextEditorFeatureItalic							= 1 << 3,
	RichTextEditorFeatureUnderline						= 1 << 4,
	RichTextEditorFeatureStrikeThrough					= 1 << 5,
	RichTextEditorFeatureTextAlignmentLeft				= 1 << 6,
	RichTextEditorFeatureTextAlignmentCenter			= 1 << 7,
	RichTextEditorFeatureTextAlignmentRight				= 1 << 8,
	RichTextEditorFeatureTextAlignmentJustified			= 1 << 9,
	RichTextEditorFeatureTextBackgroundColor			= 1 << 10,
	RichTextEditorFeatureTextForegroundColor			= 1 << 11,
	RichTextEditorFeatureParagraphIndentation			= 1 << 12,
	RichTextEditorFeatureParagraphFirstLineIndentation	= 1 << 13,
	RichTextEditorFeatureAll							= 1 << 14
}RichTextEditorFeature;

@protocol RichTextEditorToolbarDelegate <UIScrollViewDelegate>
- (void)richTextEditorToolbarDidSelectBold;
- (void)richTextEditorToolbarDidSelectItalic;
- (void)richTextEditorToolbarDidSelectUnderline;
- (void)richTextEditorToolbarDidSelectStrikeThrough;
- (void)richTextEditorToolbarDidSelectBulletPoint;
- (void)richTextEditorToolbarDidSelectParagraphFirstLineHeadIndent;
- (void)richTextEditorToolbarDidSelectParagraphIndentation:(ParagraphIndentation)paragraphIndentation;
- (void)richTextEditorToolbarDidSelectFontSize:(NSNumber *)fontSize;
- (void)richTextEditorToolbarDidSelectFontWithName:(NSString *)fontName;
- (void)richTextEditorToolbarDidSelectTextBackgroundColor:(UIColor *)color;
- (void)richTextEditorToolbarDidSelectTextForegroundColor:(UIColor *)color;
- (void)richTextEditorToolbarDidSelectTextAlignment:(NSTextAlignment)textAlignment;
@end

@protocol RichTextEditorToolbarDataSource <NSObject>
- (NSArray *)fontSizeSelectionForRichTextEditorToolbar;
- (NSArray *)fontFamilySelectionForRichTextEditorToolbar;
- (RichTextEditorToolbarPresentationStyle)presentationStyleForRichTextEditorToolbar;
- (UIModalPresentationStyle)modalPresentationStyleForRichTextEditorToolbar;
- (UIModalTransitionStyle)modalTransitionStyleForRichTextEditorToolbar;
- (UIViewController *)firsAvailableViewControllerForRichTextEditorToolbar;
- (RichTextEditorFeature)featuresEnabledForRichTextEditorToolbar;
@end

@interface RichTextEditorToolbar : UIScrollView

@property (nonatomic, weak) id <RichTextEditorToolbarDelegate> delegate;
@property (nonatomic, weak) id <RichTextEditorToolbarDataSource> dataSource;

- (id)initWithFrame:(CGRect)frame delegate:(id <RichTextEditorToolbarDelegate>)delegate dataSource:(id <RichTextEditorToolbarDataSource>)dataSource;
- (void)updateStateWithAttributes:(NSDictionary *)attributes;
- (void)redraw;

@end
