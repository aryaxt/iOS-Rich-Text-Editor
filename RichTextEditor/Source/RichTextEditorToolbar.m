//
//  RichTextEditorToolbar.m
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

#import "RichTextEditorToolbar.h"
#import <CoreText/CoreText.h>
#import "RichTextEditorPopover.h"
#import "RichTextEditorFontSizePickerViewController.h"
#import "RichTextEditorFontPickerViewController.h"
#import "RichTextEditorColorPickerViewController.h"
#import "WEPopoverController.h"
#import "RichTextEditorToggleButton.h"
#import "UIFont+RichTextEditor.h"

#define ITEM_SEPARATOR_SPACE 5
#define ITEM_TOP_AND_BOTTOM_BORDER 5
#define ITEM_WITH 40

@interface RichTextEditorToolbar() <RichTextEditorFontSizePickerViewControllerDelegate, RichTextEditorFontSizePickerViewControllerDataSource, RichTextEditorFontPickerViewControllerDelegate, RichTextEditorFontPickerViewControllerDataSource, RichTextEditorColorPickerViewControllerDataSource, RichTextEditorColorPickerViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) id <RichTextEditorPopover> popover;
@property (nonatomic, strong) RichTextEditorToggleButton *btnBold;
@property (nonatomic, strong) RichTextEditorToggleButton *btnItalic;
@property (nonatomic, strong) RichTextEditorToggleButton *btnUnderline;
@property (nonatomic, strong) RichTextEditorToggleButton *btnStrikeThrough;
@property (nonatomic, strong) RichTextEditorToggleButton *btnFontSize;
@property (nonatomic, strong) RichTextEditorToggleButton *btnFont;
@property (nonatomic, strong) RichTextEditorToggleButton *btnBackgroundColor;
@property (nonatomic, strong) RichTextEditorToggleButton *btnForegroundColor;
@property (nonatomic, strong) RichTextEditorToggleButton *btnTextAlignmentLeft;
@property (nonatomic, strong) RichTextEditorToggleButton *btnTextAlignmentCenter;
@property (nonatomic, strong) RichTextEditorToggleButton *btnTextAlignmentRight;
@property (nonatomic, strong) RichTextEditorToggleButton *btnTextAlignmentJustified;
@property (nonatomic, strong) RichTextEditorToggleButton *btnParagraphIndent;
@property (nonatomic, strong) RichTextEditorToggleButton *btnParagraphOutdent;
@property (nonatomic, strong) RichTextEditorToggleButton *btnParagraphFirstLineHeadIndent;
@property (nonatomic, strong) RichTextEditorToggleButton *btnBulletList;
@property (nonatomic, strong) RichTextEditorToggleButton *btnTextAttachment;
@end

@implementation RichTextEditorToolbar

#pragma mark - Initialization -

- (id)initWithFrame:(CGRect)frame delegate:(id <RichTextEditorToolbarDelegate>)delegate dataSource:(id <RichTextEditorToolbarDataSource>)dataSource
{
	if (self = [super initWithFrame:frame])
	{
		self.delegate = delegate;
		self.dataSource = dataSource;
		
		self.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
		self.layer.borderWidth = .7;
		self.layer.borderColor = [UIColor lightGrayColor].CGColor;
		
		[self initializeButtons];
        [self populateToolbar];
	}
	
	return self;
}

#pragma mark - Public Methods -

- (void)redraw
{
	[self populateToolbar];
}

- (void)updateStateWithAttributes:(NSDictionary *)attributes
{
	UIFont *font = [attributes objectForKey:NSFontAttributeName];
	NSParagraphStyle *paragraphTyle = [attributes objectForKey:NSParagraphStyleAttributeName];
	
	[self.btnFontSize setTitle:[NSString stringWithFormat:@"%.f", font.pointSize] forState:UIControlStateNormal];
	[self.btnFont setTitle:font.familyName forState:UIControlStateNormal];
	
	self.btnBold.on = [font isBold];
	self.btnItalic.on = [font isItalic];
	
	self.btnTextAlignmentLeft.on = NO;
	self.btnTextAlignmentCenter.on = NO;
	self.btnTextAlignmentRight.on = NO;
	self.btnTextAlignmentJustified.on = NO;
	self.btnParagraphFirstLineHeadIndent.on = (paragraphTyle.firstLineHeadIndent > paragraphTyle.headIndent) ? YES : NO;
	
	switch (paragraphTyle.alignment)
	{
		case NSTextAlignmentLeft:
			self.btnTextAlignmentLeft.on = YES;
			break;
		case NSTextAlignmentCenter:
			self.btnTextAlignmentCenter.on = YES;
			break;
			
		case NSTextAlignmentRight:
			self.btnTextAlignmentRight.on = YES;
			break;
			
		case NSTextAlignmentJustified:
			self.btnTextAlignmentJustified.on = YES;
			break;
			
		default:
			self.btnTextAlignmentLeft.on = YES;
			break;
	}
	
	NSNumber *existingUnderlineStyle = [attributes objectForKey:NSUnderlineStyleAttributeName];
	self.btnUnderline.on = (!existingUnderlineStyle || existingUnderlineStyle.intValue == NSUnderlineStyleNone) ? NO :YES;
	
	NSNumber *existingStrikeThrough = [attributes objectForKey:NSStrikethroughStyleAttributeName];
	self.btnStrikeThrough.on = (!existingStrikeThrough || existingStrikeThrough.intValue == NSUnderlineStyleNone) ? NO :YES;
	
	[self populateToolbar];
}

#pragma mark - IBActions -

- (void)boldSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectBold];
}

- (void)italicSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectItalic];
}

- (void)underLineSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectUnderline];
}

- (void)strikeThroughSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectStrikeThrough];
}

- (void)bulletListSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectBulletList];
}

- (void)paragraphIndentSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectParagraphIndentation:ParagraphIndentationIncrease];
}

- (void)paragraphOutdentSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectParagraphIndentation:ParagraphIndentationDecrease];
}

- (void)paragraphHeadIndentOutdentSelected:(UIButton *)sender
{
	[self.delegate richTextEditorToolbarDidSelectParagraphFirstLineHeadIndent];
}

- (void)fontSizeSelected:(UIButton *)sender
{
	UIViewController <RichTextEditorFontSizePicker> *fontSizePicker = [self.dataSource fontSizePickerForRichTextEditorToolbar];
	
	if (!fontSizePicker)
		fontSizePicker = [[RichTextEditorFontSizePickerViewController alloc] init];
	
	fontSizePicker.delegate = self;
	fontSizePicker.dataSource = self;
	[self presentViewController:fontSizePicker fromView:sender];
}

- (void)fontSelected:(UIButton *)sender
{
	UIViewController <RichTextEditorFontPicker> *fontPicker = [self.dataSource fontPickerForRichTextEditorToolbar];
	
	if (!fontPicker)
		fontPicker= [[RichTextEditorFontPickerViewController alloc] init];
	
	fontPicker.delegate = self;
	fontPicker.dataSource = self;
	[self presentViewController:fontPicker fromView:sender];
}

- (void)textBackgroundColorSelected:(UIButton *)sender
{
	UIViewController <RichTextEditorColorPicker> *colorPicker = [self.dataSource colorPickerForRichTextEditorToolbarWithAction:RichTextEditorColorPickerActionTextBackgroundColor];
	
	if (!colorPicker)
		colorPicker = [[RichTextEditorColorPickerViewController alloc] init];
	
	colorPicker.action = RichTextEditorColorPickerActionTextBackgroundColor;
	colorPicker.delegate = self;
	colorPicker.dataSource = self;
	[self presentViewController:colorPicker fromView:sender];
}

- (void)textForegroundColorSelected:(UIButton *)sender
{
	UIViewController <RichTextEditorColorPicker> *colorPicker = [self.dataSource colorPickerForRichTextEditorToolbarWithAction:RichTextEditorColorPickerActionTextForegroudColor];
	
	if (!colorPicker)
		colorPicker = [[RichTextEditorColorPickerViewController alloc] init];
	
	colorPicker.action = RichTextEditorColorPickerActionTextForegroudColor;
	colorPicker.delegate = self;
	colorPicker.dataSource = self;
	[self presentViewController:colorPicker fromView:sender];
}

- (void)textAlignmentSelected:(UIButton *)sender
{
	NSTextAlignment textAlignment = NSTextAlignmentLeft;
	
	if (sender == self.btnTextAlignmentLeft)
		textAlignment = NSTextAlignmentLeft;
	else if (sender == self.btnTextAlignmentCenter)
		textAlignment = NSTextAlignmentCenter;
	else if (sender == self.btnTextAlignmentRight)
		textAlignment = NSTextAlignmentRight;
	else
		textAlignment = NSTextAlignmentJustified;
	
	[self.delegate richTextEditorToolbarDidSelectTextAlignment:textAlignment];
}

- (void)textAttachmentSelected:(UIButton *)sender
{
	UIImagePickerController *vc = [[UIImagePickerController alloc] init];
	vc.delegate = self;
	[self presentViewController:vc fromView:self.btnTextAttachment];
}

#pragma mark - Private Methods -

- (void)populateToolbar
{
	CGRect visibleRect;
	visibleRect.origin = self.contentOffset;
	visibleRect.size = self.bounds.size;
	
    // Remove any existing subviews.
    for (UIView *subView in self.subviews)
	{
        [subView removeFromSuperview];
    }
    
    // Populate the toolbar with the given features.
    RichTextEditorFeature features = [self.dataSource featuresEnabledForRichTextEditorToolbar];
    UIView *lastAddedView = nil;
    
    self.hidden = (features == RichTextEditorFeatureNone);
	
	if (self.hidden)
		return;
	
	// Font selection
	if (features & RichTextEditorFeatureFont || features & RichTextEditorFeatureAll)
	{
		UIView *separatorView = [self separatorView];
		CGSize size = [self.btnFont sizeThatFits:CGSizeZero];
		CGRect rect = self.btnFont.frame;
		rect.size.width = MAX(size.width + 25, 120);
		self.btnFont.frame = rect;
		
		[self addView:self.btnFont afterView:lastAddedView withSpacing:YES];
		[self addView:separatorView afterView:self.btnFont withSpacing:YES];
		lastAddedView = separatorView;
	}
	
	// Font size
	if (features & RichTextEditorFeatureFontSize || features & RichTextEditorFeatureAll)
	{
		UIView *separatorView = [self separatorView];
		[self addView:self.btnFontSize afterView:lastAddedView withSpacing:YES];
		[self addView:separatorView afterView:self.btnFontSize withSpacing:YES];
		lastAddedView = separatorView;
	}
	
	// Bold
	if (features & RichTextEditorFeatureBold || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnBold afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnBold;
	}
	
	// Italic
	if (features & RichTextEditorFeatureItalic || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnItalic afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnItalic;
	}
	
	// Underline
	if (features & RichTextEditorFeatureUnderline || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnUnderline afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnUnderline;
	}
	
	// Strikethrough
	if (features & RichTextEditorFeatureStrikeThrough || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnStrikeThrough afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnStrikeThrough;
	}
	
	// Separator view after font properties.
	if (features & RichTextEditorFeatureBold || features & RichTextEditorFeatureItalic || features & RichTextEditorFeatureUnderline || features & RichTextEditorFeatureStrikeThrough || features & RichTextEditorFeatureAll)
	{
		UIView *separatorView = [self separatorView];
		[self addView:separatorView afterView:lastAddedView withSpacing:YES];
		lastAddedView = separatorView;
	}
	
	// Align left
	if (features & RichTextEditorFeatureTextAlignmentLeft || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnTextAlignmentLeft afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnTextAlignmentLeft;
	}
	
	// Align center
	if (features & RichTextEditorFeatureTextAlignmentCenter || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnTextAlignmentCenter afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnTextAlignmentCenter;
	}
	
	// Align right
	if (features & RichTextEditorFeatureTextAlignmentRight || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnTextAlignmentRight afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnTextAlignmentRight;
	}
	
	// Align justified
	if (features & RichTextEditorFeatureTextAlignmentJustified || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnTextAlignmentJustified afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnTextAlignmentJustified;
	}
	
	// Separator view after alignment section
	if (features & RichTextEditorFeatureTextAlignmentLeft || features & RichTextEditorFeatureTextAlignmentCenter || features & RichTextEditorFeatureTextAlignmentRight || features & RichTextEditorFeatureTextAlignmentJustified || features & RichTextEditorFeatureAll)
	{
		UIView *separatorView = [self separatorView];
		[self addView:separatorView afterView:lastAddedView withSpacing:YES];
		lastAddedView = separatorView;
	}
	
	// Paragraph indentation
	if (features & RichTextEditorFeatureParagraphIndentation || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnParagraphOutdent afterView:lastAddedView  withSpacing:YES];
		[self addView:self.btnParagraphIndent afterView:self.btnParagraphOutdent withSpacing:YES];
		lastAddedView = self.btnParagraphIndent;
	}
	
	// Paragraph first line indentation
	if (features & RichTextEditorFeatureParagraphFirstLineIndentation || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnParagraphFirstLineHeadIndent afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnParagraphFirstLineHeadIndent;
	}
	
	// Separator view after Indentation
	if (features & RichTextEditorFeatureParagraphIndentation || features & RichTextEditorFeatureParagraphFirstLineIndentation || features & RichTextEditorFeatureAll)
	{
		UIView *separatorView = [self separatorView];
		[self addView:separatorView afterView:lastAddedView withSpacing:YES];
		lastAddedView = separatorView;
	}
	
	// Background color
	if (features & RichTextEditorFeatureTextBackgroundColor || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnBackgroundColor afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnBackgroundColor;
	}
	
	// Text color
	if (features & RichTextEditorFeatureTextForegroundColor || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnForegroundColor afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnForegroundColor;
	}
	
	// Separator view after color section
	if (features & RichTextEditorFeatureTextBackgroundColor || features & RichTextEditorFeatureTextForegroundColor || features & RichTextEditorFeatureAll)
	{
		UIView *separatorView = [self separatorView];
		[self addView:separatorView afterView:lastAddedView withSpacing:YES];
		lastAddedView = separatorView;
	}
	
	// Bullet List
	if (features & RichTextEditorFeatureBulletList || features & RichTextEditorFeatureAll)
	{
		[self addView:self.btnBulletList afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnBulletList;
	}
	
	// Separator view after color section
	if (features & RichTextEditorFeatureBulletList || features & RichTextEditorFeatureAll)
	{
		UIView *separatorView = [self separatorView];
		[self addView:separatorView afterView:lastAddedView withSpacing:YES];
		lastAddedView = separatorView;
	}
	
	if ((features & RichTextEditorFeatureBulletList || features & RichTextEditorFeatureAll) && SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
	{
		[self addView:self.btnTextAttachment afterView:lastAddedView withSpacing:YES];
		lastAddedView = self.btnBulletList;
	}
	
	[self scrollRectToVisible:visibleRect animated:NO];
}

- (void)initializeButtons
{
	self.btnFont = [self buttonWithImageNamed:@"dropDownTriangle.png"
										width:120
								  andSelector:@selector(fontSelected:)];
	[self.btnFont setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
	[self.btnFont setTitle:@"Font" forState:UIControlStateNormal];
	
	
	self.btnFontSize = [self buttonWithImageNamed:@"dropDownTriangle.png"
											width:50
									  andSelector:@selector(fontSizeSelected:)];
	[self.btnFontSize setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
	[self.btnFontSize setTitle:@"14" forState:UIControlStateNormal];
	
	self.btnBold = [self buttonWithImageNamed:@"bold.png"
								  andSelector:@selector(boldSelected:)];
	
	
	self.btnItalic = [self buttonWithImageNamed:@"italic.png"
									andSelector:@selector(italicSelected:)];
	
	
	self.btnUnderline = [self buttonWithImageNamed:@"underline.png"
									   andSelector:@selector(underLineSelected:)];
	
	self.btnStrikeThrough = [self buttonWithImageNamed:@"strikethrough"
										   andSelector:@selector(strikeThroughSelected:)];
	
	
	self.btnTextAlignmentLeft = [self buttonWithImageNamed:@"justifyleft.png"
											   andSelector:@selector(textAlignmentSelected:)];
	
	
	self.btnTextAlignmentCenter = [self buttonWithImageNamed:@"justifycenter.png"
												 andSelector:@selector(textAlignmentSelected:)];
	
	
	self.btnTextAlignmentRight = [self buttonWithImageNamed:@"justifyright.png"
												andSelector:@selector(textAlignmentSelected:)];
	
	self.btnTextAlignmentJustified = [self buttonWithImageNamed:@"justifyfull.png"
													andSelector:@selector(textAlignmentSelected:)];
	
	self.btnForegroundColor = [self buttonWithImageNamed:@"forecolor.png"
											 andSelector:@selector(textForegroundColorSelected:)];
	
	self.btnBackgroundColor = [self buttonWithImageNamed:@"backcolor.png"
											 andSelector:@selector(textBackgroundColorSelected:)];
	
	self.btnBulletList = [self buttonWithImageNamed:@"bullist.png"
										 andSelector:@selector(bulletListSelected:)];
	
	self.btnParagraphIndent = [self buttonWithImageNamed:@"indent.png"
											 andSelector:@selector(paragraphIndentSelected:)];
	
	self.btnParagraphOutdent = [self buttonWithImageNamed:@"outdent.png"
											  andSelector:@selector(paragraphOutdentSelected:)];
	
	self.btnParagraphFirstLineHeadIndent = [self buttonWithImageNamed:@"firstLineIndent.png"
														  andSelector:@selector(paragraphHeadIndentOutdentSelected:)];
	
	self.btnTextAttachment = [self buttonWithImageNamed:@"image.png"
														  andSelector:@selector(textAttachmentSelected:)];
}

- (RichTextEditorToggleButton *)buttonWithImageNamed:(NSString *)image width:(NSInteger)width andSelector:(SEL)selector
{
	RichTextEditorToggleButton *button = [[RichTextEditorToggleButton alloc] init];
	[button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
	[button setFrame:CGRectMake(0, 0, width, 0)];
	[button.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
	[button.titleLabel setTextColor:[UIColor blackColor]];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
	
	return button;
}

- (RichTextEditorToggleButton *)buttonWithImageNamed:(NSString *)image andSelector:(SEL)selector
{
	return [self buttonWithImageNamed:image width:ITEM_WITH andSelector:selector];
}

- (UIView *)separatorView
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.frame.size.height)];
	view.backgroundColor = [UIColor lightGrayColor];
	
	return view;
}

- (void)addView:(UIView *)view afterView:(UIView *)otherView withSpacing:(BOOL)space
{
	CGRect otherViewRect = (otherView) ? otherView.frame : CGRectZero;
	CGRect rect = view.frame;
	rect.origin.x = otherViewRect.size.width + otherViewRect.origin.x;
	if (space)
		rect.origin.x += ITEM_SEPARATOR_SPACE;
	
	rect.origin.y = ITEM_TOP_AND_BOTTOM_BORDER;
	rect.size.height = self.frame.size.height - (2*ITEM_TOP_AND_BOTTOM_BORDER);
	view.frame = rect;
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	
	[self addSubview:view];
	[self updateContentSize];
}

- (void)updateContentSize
{
	NSInteger maxViewlocation = 0;
	
	for (UIView *view in self.subviews)
	{
		NSInteger endLocation = view.frame.size.width + view.frame.origin.x;
		
		if (endLocation > maxViewlocation)
			maxViewlocation = endLocation;
	}
	
	self.contentSize = CGSizeMake(maxViewlocation+ITEM_SEPARATOR_SPACE, self.frame.size.height);
}

- (void)presentViewController:(UIViewController *)viewController fromView:(UIView *)view
{
	if ([self.dataSource presentationStyleForRichTextEditorToolbar] == RichTextEditorToolbarPresentationStyleModal)
	{
		viewController.modalPresentationStyle = [self.dataSource modalPresentationStyleForRichTextEditorToolbar];
		viewController.modalTransitionStyle = [self.dataSource modalTransitionStyleForRichTextEditorToolbar];
		[[self.dataSource firsAvailableViewControllerForRichTextEditorToolbar] presentViewController:viewController animated:YES completion:nil];
	}
	else if ([self.dataSource presentationStyleForRichTextEditorToolbar] == RichTextEditorToolbarPresentationStylePopover)
	{
		id <RichTextEditorPopover> popover = [self popoverWithViewController:viewController];
		[popover presentPopoverFromRect:view.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
	}
}

- (id <RichTextEditorPopover>)popoverWithViewController:(UIViewController *)viewController
{
	id <RichTextEditorPopover> popover;
	
	if (!popover)
	{
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
		{
			popover = (id<RichTextEditorPopover>) [[UIPopoverController alloc] initWithContentViewController:viewController];
		}
		else
		{
			popover = (id<RichTextEditorPopover>) [[WEPopoverController alloc] initWithContentViewController:viewController];
		}
	}
	
	[self.popover dismissPopoverAnimated:YES];
	self.popover = popover;
	
	return popover;
}

- (void)dismissViewController
{
	if ([self.dataSource presentationStyleForRichTextEditorToolbar] == RichTextEditorToolbarPresentationStyleModal)
	{
		[[self.dataSource firsAvailableViewControllerForRichTextEditorToolbar] dismissViewControllerAnimated:YES completion:NO];
	}
	else if ([self.dataSource presentationStyleForRichTextEditorToolbar] == RichTextEditorToolbarPresentationStylePopover)
	{
		[self.popover dismissPopoverAnimated:YES];
	}
	
	[self.delegate richTextEditorToolbarDidDismissViewController];
}

#pragma mark - RichTextEditorColorPickerViewControllerDelegate & RichTextEditorColorPickerViewControllerDataSource Methods -

- (void)richTextEditorColorPickerViewControllerDidSelectColor:(UIColor *)color withAction:(RichTextEditorColorPickerAction)action
{
	if (action == RichTextEditorColorPickerActionTextBackgroundColor)
	{
		[self.delegate richTextEditorToolbarDidSelectTextBackgroundColor:color];
	}
	else
	{
		[self.delegate richTextEditorToolbarDidSelectTextForegroundColor:color];
	}
	
	[self dismissViewController];
}

- (void)richTextEditorColorPickerViewControllerDidSelectClose
{
	[self dismissViewController];
}

- (BOOL)richTextEditorColorPickerViewControllerShouldDisplayToolbar
{
	return ([self.dataSource presentationStyleForRichTextEditorToolbar] == RichTextEditorToolbarPresentationStyleModal) ? YES: NO;
}

#pragma mark - RichTextEditorFontSizePickerViewControllerDelegate & RichTextEditorFontSizePickerViewControllerDataSource Methods -

- (void)richTextEditorFontSizePickerViewControllerDidSelectFontSize:(NSNumber *)fontSize
{
	[self.delegate richTextEditorToolbarDidSelectFontSize:fontSize];
	[self dismissViewController];
}

- (void)richTextEditorFontSizePickerViewControllerDidSelectClose
{
	[self dismissViewController];
}

- (BOOL)richTextEditorFontSizePickerViewControllerShouldDisplayToolbar
{
	return ([self.dataSource presentationStyleForRichTextEditorToolbar] == RichTextEditorToolbarPresentationStyleModal) ? YES: NO;
}

- (NSArray *)richTextEditorFontSizePickerViewControllerCustomFontSizesForSelection
{
	return [self.dataSource fontSizeSelectionForRichTextEditorToolbar];
}

#pragma mark - RichTextEditorFontPickerViewControllerDelegate & RichTextEditorFontPickerViewControllerDataSource Methods -

- (void)richTextEditorFontPickerViewControllerDidSelectFontWithName:(NSString *)fontName
{
	[self.delegate richTextEditorToolbarDidSelectFontWithName:fontName];
	[self dismissViewController];
}

- (void)richTextEditorFontPickerViewControllerDidSelectClose
{
	[self dismissViewController];
}

- (NSArray *)richTextEditorFontPickerViewControllerCustomFontFamilyNamesForSelection
{
	return [self.dataSource fontFamilySelectionForRichTextEditorToolbar];
}

- (BOOL)richTextEditorFontPickerViewControllerShouldDisplayToolbar
{
	return ([self.dataSource presentationStyleForRichTextEditorToolbar] == RichTextEditorToolbarPresentationStyleModal) ? YES: NO;
}

#pragma mark - UIImagePickerViewControllerDelegate -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	[self.delegate richTextEditorToolbarDidSelectTextAttachment:image];
	[self dismissViewController];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewController];
}

@end
