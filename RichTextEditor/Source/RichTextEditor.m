//
//  RichTextEditor.m
//  RichTextEditor
//
//  Created by Aryan Gh on 5/4/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "RichTextEditor.h"

@implementation RichTextEditor
@synthesize textView;
@synthesize defaultFont;
@synthesize colorPickerView;
@synthesize fontPickerView;
@synthesize fontSizePickerView;
@synthesize toolbar;
@synthesize shouldAttachToolbarToKeyboard;

#pragma mark - Initialization -

- (id)initWithFrame:(CGRect)frame
{
    if (self = [self init])
	{
		self.frame = frame;
	}
	
	return self;
}

- (id)init
{
	self = [[[NSBundle mainBundle]loadNibNamed:@"RichTextEditor" owner:nil options:nil] lastObject];

	self.shouldAttachToolbarToKeyboard = NO;
	self.textView.text = @"Hello this is a test";
	
	self.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.layer.borderWidth = 1;
	
	return self;
}

#pragma mark - ToolbarDelegateMethods -

- (void)richTextToolbarDidSelectBold
{
	NSDictionary *dictionary = [self.textView.attributedText attributesAtIndex:self.textView.selectedRange.location effectiveRange:nil];
	UIFont *font = [dictionary objectForKey:NSFontAttributeName];
	UIFont *newFont = [font fontWithBoldTrait:![font isBold] andItalicTrait:[font isItalic]];
	
	[self applyAttrubutesToSelectedRange:newFont forKey:NSFontAttributeName];
}

- (void)richTextToolbarDidSelectItalic
{
	NSDictionary *dictionary = [self.textView.attributedText attributesAtIndex:self.textView.selectedRange.location effectiveRange:nil];
	UIFont *font = [dictionary objectForKey:NSFontAttributeName];
	UIFont *newFont = [font fontWithBoldTrait:[font isBold] andItalicTrait:![font isItalic]];
	
	[self applyAttrubutesToSelectedRange:newFont forKey:NSFontAttributeName];
}

- (void)richTextToolbarDidSelectUnderline
{
	NSDictionary *dictionary = [self.textView.attributedText attributesAtIndex:self.textView.selectedRange.location effectiveRange:nil];
	
	NSNumber *existingUnderlineStyle = [dictionary objectForKey:NSUnderlineStyleAttributeName];
	
	if (!existingUnderlineStyle || existingUnderlineStyle.intValue == NSUnderlineStyleNone)
		existingUnderlineStyle = [NSNumber numberWithInteger:NSUnderlineStyleSingle];
	else
		existingUnderlineStyle = [NSNumber numberWithInteger:NSUnderlineStyleNone];
	
	[self applyAttrubutesToSelectedRange:existingUnderlineStyle forKey:NSUnderlineStyleAttributeName];
}

- (void)richTextToolbarDidSelectBackgroundColor
{
	[self addSubview:self.colorPickerView];
	self.colorPickerView.tag = ColorPickerViewActionTextBackgroundColor;
}

- (void)richTextToolbarDidSelectTextColor
{
	[self addSubview:self.colorPickerView];
	self.colorPickerView.tag = ColorPickerViewActionTextColor;
}

- (void)richTextToolbarDidSelectFontSize
{
	[self addSubview:self.fontSizePickerView];
}

- (void)richTextToolbarDidSelectFont
{
		[self addSubview:self.fontPickerView];
}

- (void)richTextToolbarDidSelectTextAlignment:(NSTextAlignment)textAlignment
{
	NSMutableParagraphStyle *mutParaStyle = [[NSMutableParagraphStyle alloc] init];
	mutParaStyle.alignment = textAlignment;
	
	[self applyAttrubutesToSelectedRange:mutParaStyle forKey:NSParagraphStyleAttributeName];
}

#pragma mark - Private Methods -

- (void)applyAttributes:(id)attribute forKey:(NSString *)key atRange:(NSRange)range
{	
	if (range.length > 0)
	{
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
		[attributedString addAttributes:[NSDictionary dictionaryWithObject:attribute forKey:key] range:range];
		
		[self.textView setAttributedText:attributedString];
		[self.textView setSelectedRange:range];
	}
}

- (void)applyAttrubutesToSelectedRange:(id)attribute forKey:(NSString *)key
{
	[self applyAttributes:attribute forKey:key atRange:self.textView.selectedRange];
}

#pragma mark - UITextViewDelegate -

- (void)textViewDidChangeSelection:(UITextView *)textView
{
	/*NSDictionary *dictionary = [self.textView.attributedText attributesAtIndex:self.textView.selectedRange.location
																effectiveRange:nil];
	
	[self.toolbar populateWithAttributes:dictionary];*/
}

#pragma mark - ColorPickerViewDelegate -

- (void)colorPickerView:(ColorPickerView *)aColorPickerView didSelectColor:(UIColor *)color
{
	NSString *colorChangeKey = (aColorPickerView.tag == ColorPickerViewActionTextBackgroundColor) ? NSBackgroundColorAttributeName : NSForegroundColorAttributeName;
	
	[self applyAttrubutesToSelectedRange:color forKey:colorChangeKey];
	[self.colorPickerView removeFromSuperview];
}

- (void)colorPickerViewDidSelectClose:(ColorPickerView *)colorPickerView
{
	[self.colorPickerView removeFromSuperview];
}

#pragma mark - FontPickerViewDelegate -

- (void)fontPickerViewDidSelectFontWithName:(NSString *)fontName
{
	NSDictionary *dictionary = [self.textView.attributedText attributesAtIndex:self.textView.selectedRange.location effectiveRange:nil];
	UIFont *font = [dictionary objectForKey:NSFontAttributeName];
	UIFont *newFont = [UIFont fontWithName:fontName size:font.pointSize boldTrait:[font isBold] italicTrait:[font isItalic]];
	[self applyAttrubutesToSelectedRange:newFont forKey:NSFontAttributeName];
	
	[self.fontPickerView removeFromSuperview];
}

#pragma mark - FontSizePickerView -

- (void)fontSizePickerViewDidSelectFontSize:(NSInteger)fontSize
{
	NSDictionary *dictionary = [self.textView.attributedText attributesAtIndex:self.textView.selectedRange.location effectiveRange:nil];
	UIFont *font = [dictionary objectForKey:NSFontAttributeName];
	UIFont *newFont = [UIFont fontWithName:font.familyName size:fontSize boldTrait:[font isBold] italicTrait:[font isItalic]];
	[self applyAttrubutesToSelectedRange:newFont forKey:NSFontAttributeName];
	
	[self.fontSizePickerView removeFromSuperview];
}

#pragma mark - Getter & Setter -

- (ColorPickerView *)colorPickerView
{
	if (!colorPickerView)
	{
		colorPickerView = [[ColorPickerView alloc] init];
		colorPickerView.delegate = self;
	}
	
	return colorPickerView;
}

- (FontPickerView *)fontPickerView
{
	if (!fontPickerView)
	{
		fontPickerView = [[FontPickerView alloc] init];
		fontPickerView.delegate = self;
	}
	
	return fontPickerView;
}

- (FontSizePickerView *)fontSizePickerView
{
	if (!fontSizePickerView)
	{
		fontSizePickerView = [[FontSizePickerView alloc] init];
		fontSizePickerView.delegate = self;
	}
	
	return fontSizePickerView;
}

- (RichTextToolbar *)toolbar
{
	if (!toolbar)
	{
		toolbar = [[RichTextToolbar alloc] initWithDeleate:self];
	}
	
	return toolbar;
}

- (void)setShouldAttachToolbarToKeyboard:(BOOL)markShouldAttachToolbarToKeyboard
{
	shouldAttachToolbarToKeyboard = markShouldAttachToolbarToKeyboard;
	
	if (shouldAttachToolbarToKeyboard)
	{
		[self.toolbar removeFromSuperview];
		self.textView.frame = self.bounds;
		self.textView.inputAccessoryView = self.toolbar;
	}
	else
	{
		self.textView.inputAccessoryView = nil;
		
		CGRect toolbarRect = self.toolbar.frame;
		toolbarRect.size.width = self.frame.size.width;
		toolbarRect.origin.x = 0;
		toolbarRect.origin.y = 0;
		self.toolbar.frame = toolbarRect;
		[self addSubview:self.toolbar];
		
		CGRect textViewRect = self.textView.frame;
		textViewRect.origin.y = toolbarRect.size.height;
		textViewRect.size.height = self.frame.size.height - toolbarRect.size.height;
		self.textView.frame = textViewRect;
	}
}

@end
