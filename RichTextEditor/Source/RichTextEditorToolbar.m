//
//  RichTextEditorToolbar.m
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "RichTextEditorToolbar.h"

@implementation RichTextEditorToolbar
@synthesize delegate = _toolbarDelegate;

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		UIBarButtonItem *boldItem = [[UIBarButtonItem alloc] initWithTitle:@"Bold" style:UIBarButtonItemStylePlain target:self action:@selector(boldSelected:)];
		
		UIBarButtonItem *italicItem = [[UIBarButtonItem alloc] initWithTitle:@"Italic" style:UIBarButtonItemStylePlain target:self action:@selector(italicSelected:)];
		
		UIBarButtonItem *underlineItem = [[UIBarButtonItem alloc] initWithTitle:@"Underline" style:UIBarButtonItemStylePlain target:self action:@selector(underLineSelected:)];
		
		UIBarButtonItem *fontSizeItem = [[UIBarButtonItem alloc] initWithTitle:@"FontSize" style:UIBarButtonItemStylePlain target:self action:@selector(fontSizeSelected:)];
		
		UIBarButtonItem *fontItem = [[UIBarButtonItem alloc] initWithTitle:@"fontName" style:UIBarButtonItemStylePlain target:self action:@selector(fontSelected:)];
		
		UIBarButtonItem *textBackgroundColorItem = [[UIBarButtonItem alloc] initWithTitle:@"Background" style:UIBarButtonItemStylePlain target:self action:@selector(textBackgroundColorSelected:)];
		
		UIBarButtonItem *textForegroundColorItem = [[UIBarButtonItem alloc] initWithTitle:@"Foreground" style:UIBarButtonItemStylePlain target:self action:@selector(textForegroundColorSelected:)];
		
		UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[
																						   [UIImage imageNamed:@"left.gif"],
																						   [UIImage imageNamed:@"center.gif"],
																						   [UIImage imageNamed:@"right.gif"]
																						   ]];
		[segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
		
		[segmentedControl addTarget:self action:@selector(textAlignmentSegmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
		UIBarButtonItem *textAlignmentItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
		
		[self setItems:@[boldItem, italicItem, underlineItem, fontSizeItem, fontItem, textBackgroundColorItem, textForegroundColorItem, textAlignmentItem]];
	}
	
	return self;
}

#pragma mark - IBActions -

- (void)boldSelected:(UIBarButtonItem *)sender
{
	[self.delegate richTextEditorToolbarDidSelectBold];
}

- (void)italicSelected:(UIBarButtonItem *)sender
{
	[self.delegate richTextEditorToolbarDidSelectItalic];
}

- (void)underLineSelected:(UIBarButtonItem *)sender
{
	[self.delegate richTextEditorToolbarDidSelectUnderline];
}

- (void)fontSizeSelected:(UIBarButtonItem *)sender
{
	RichTextEditorFontSizePickerViewController *fontSizePicker = [[RichTextEditorFontSizePickerViewController alloc] init];
	fontSizePicker.delegate = self;
	[self presentPopoverWithViewController:fontSizePicker fromBarButtonItem:sender];
}

- (void)fontSelected:(UIBarButtonItem *)sender
{
	RichTextEditorFontPickerViewController *fontPicker= [[RichTextEditorFontPickerViewController alloc] init];
	fontPicker.delegate = self;
	[self presentPopoverWithViewController:fontPicker fromBarButtonItem:sender];
}

- (void)textBackgroundColorSelected:(UIBarButtonItem *)sender
{
	RichTextEditorColorPickerViewController *colorPicker = [[RichTextEditorColorPickerViewController alloc] init];
	colorPicker.action = RichTextEditorColorPickerActionTextBackgroundColor;
	colorPicker.delegate = self;
	[self presentPopoverWithViewController:colorPicker fromBarButtonItem:sender];
}

- (void)textForegroundColorSelected:(UIBarButtonItem *)sender
{
	RichTextEditorColorPickerViewController *colorPicker = [[RichTextEditorColorPickerViewController alloc] init];
	colorPicker.action = RichTextEditorColorPickerActionTextForegroudColor;
	colorPicker.delegate = self;
	[self presentPopoverWithViewController:colorPicker fromBarButtonItem:sender];
}

- (void)textAlignmentSegmentedControlDidChange:(UISegmentedControl *)sender
{
	NSTextAlignment textAlignment;
	
	switch (sender.selectedSegmentIndex)
	{
		case 0:
			textAlignment = NSTextAlignmentLeft;
			break;
		case 1:
			textAlignment = NSTextAlignmentCenter;
			break;
		case 2:
			textAlignment = NSTextAlignmentRight;
			break;
			
		default:
			return;
			break;
	}
	
	[self.delegate richTextEditorToolbarDidSelectTextAlignment:textAlignment];
}

#pragma mark - Private Methods -

- (void)presentPopoverWithViewController:(UIViewController *)viewController fromView:(UIView *)view
{
	id <RichTextEditorPopover> popover = [self popoverWithViewController:viewController];
	[popover presentPopoverFromRect:view.frame inView:view.superview permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (void)presentPopoverWithViewController:(UIViewController *)viewController fromBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	id <RichTextEditorPopover> popover = [self popoverWithViewController:viewController];
	[popover presentPopoverFromBarButtonItem:barButtonItem permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
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

#pragma mark - RichTextEditorColorPickerViewControllerDelegate Methods -

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
	
	[self.popover dismissPopoverAnimated:YES];
}

- (void)richTextEditorColorPickerViewControllerDidSelectClose
{
	[self.popover dismissPopoverAnimated:YES];
}

#pragma mark - RichTextEditorFontSizePickerViewControllerDelegate Methods -

- (void)richTextEditorFontSizePickerViewControllerDidSelectFontSize:(NSNumber *)fontSize
{
	[self.delegate richTextEditorToolbarDidSelectFontSize:fontSize];
	[self.popover dismissPopoverAnimated:YES];
}

#pragma mark - RichTextEditorFontPickerViewControllerDelegate Methods -

- (void)richTextEditorFontPickerViewControllerDidSelectFonteWithNam:(NSString *)fontName
{
	[self.delegate richTextEditorToolbarDidSelectFontWithName:fontName];
	[self.popover dismissPopoverAnimated:YES];
}

@end
