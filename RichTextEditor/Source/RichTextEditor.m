//
//  RichTextEditor.m
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "RichTextEditor.h"

@implementation RichTextEditor

- (void)awakeFromNib
{
	self.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.layer.borderWidth = 1;
	
	UIView *lastToolbarSubview = self.toolBar.subviews.lastObject;
	float newWidth = lastToolbarSubview.frame.origin.x + lastToolbarSubview.frame.size.width;
	
	CGFloat screenWidth = [self currentScreenBoundsDependOnOrientation].size.width;
	CGRect toolBarRect = self.toolBar.frame;
	toolBarRect.size.width = newWidth;
	
	if (toolBarRect.size.width < screenWidth)
		toolBarRect.size.width = screenWidth;
	
	self.toolBar.frame = toolBarRect;
	self.toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, toolBarRect.size.height)];
	scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	scrollView.backgroundColor =[UIColor yellowColor];
	scrollView.backgroundColor = [UIColor whiteColor];
	scrollView.contentSize = CGSizeMake(newWidth, 35);
	[scrollView addSubview:self.toolBar];
	self.inputAccessoryView = scrollView;
}

#pragma mark - RichTextEditorToolbarDelegate Methods -

- (void)richTextEditorToolbarDidSelectBold
{
	NSRange range = self.selectedRange;
	
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
	
	[attributedString beginEditing];
	[attributedString enumerateAttributesInRange:self.selectedRange
										 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
									  usingBlock:^(NSDictionary *dictionary, NSRange range, BOOL *stop){
										  
										  UIFont *font = [dictionary objectForKey:NSFontAttributeName];
										  UIFont *newFont = [font fontWithBoldTrait:![font isBold] andItalicTrait:[font isItalic]];
										  [attributedString addAttributes:[NSDictionary dictionaryWithObject:newFont forKey:NSFontAttributeName] range:range];
									  }];
	[attributedString endEditing];
	self.attributedText = attributedString;
	
	[self setSelectedRange:range];
}

- (void)richTextEditorToolbarDidSelectItalic
{
	NSRange range = self.selectedRange;
	
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
	
	[attributedString beginEditing];
	[attributedString enumerateAttributesInRange:self.selectedRange
										 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
									  usingBlock:^(NSDictionary *dictionary, NSRange range, BOOL *stop){
										  
										  UIFont *font = [dictionary objectForKey:NSFontAttributeName];
										  UIFont *newFont = [font fontWithBoldTrait:[font isBold] andItalicTrait:![font isItalic]];
										  [attributedString addAttributes:[NSDictionary dictionaryWithObject:newFont forKey:NSFontAttributeName] range:range];
									  }];
	[attributedString endEditing];
	self.attributedText = attributedString;
	
	[self setSelectedRange:range];
}

- (void)richTextEditorToolbarDidSelectUnderline
{
	NSDictionary *dictionary = [self.attributedText attributesAtIndex:self.selectedRange.location effectiveRange:nil];
	
	NSNumber *existingUnderlineStyle = [dictionary objectForKey:NSUnderlineStyleAttributeName];
	
	if (!existingUnderlineStyle || existingUnderlineStyle.intValue == NSUnderlineStyleNone)
		existingUnderlineStyle = [NSNumber numberWithInteger:NSUnderlineStyleSingle];
	else
		existingUnderlineStyle = [NSNumber numberWithInteger:NSUnderlineStyleNone];
	
	[self applyAttrubutesToSelectedRange:existingUnderlineStyle forKey:NSUnderlineStyleAttributeName];
}

- (void)richTextEditorToolbarDidSelectFontSize:(NSNumber *)fontSize
{
	NSRange range = self.selectedRange;
	
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
	
	[attributedString beginEditing];
	[attributedString enumerateAttributesInRange:self.selectedRange
										 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
									  usingBlock:^(NSDictionary *dictionary, NSRange range, BOOL *stop){
										  
										  UIFont *font = [dictionary objectForKey:NSFontAttributeName];
										  UIFont *newFont = [UIFont fontWithName:font.familyName size:fontSize.intValue boldTrait:[font isBold] italicTrait:[font isItalic]];
										  [attributedString addAttributes:[NSDictionary dictionaryWithObject:newFont forKey:NSFontAttributeName] range:range];
									  }];
	[attributedString endEditing];
	self.attributedText = attributedString;
	
	[self setSelectedRange:range];
}

- (void)richTextEditorToolbarDidSelectFontWithName:(NSString *)fontName
{
	NSRange range = self.selectedRange;
	
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
	
	[attributedString beginEditing];
	[attributedString enumerateAttributesInRange:self.selectedRange
										 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
									  usingBlock:^(NSDictionary *dictionary, NSRange range, BOOL *stop){
										  
										  UIFont *font = [dictionary objectForKey:NSFontAttributeName];
										  UIFont *newFont = [UIFont fontWithName:fontName size:font.pointSize boldTrait:[font isBold] italicTrait:[font isItalic]];
										  [attributedString addAttributes:[NSDictionary dictionaryWithObject:newFont forKey:NSFontAttributeName] range:range];
									  }];
	[attributedString endEditing];
	self.attributedText = attributedString;
	
	[self setSelectedRange:range];
}

- (void)richTextEditorToolbarDidSelectTextBackgroundColor:(UIColor *)color
{
	[self applyAttrubutesToSelectedRange:color forKey:NSBackgroundColorAttributeName];
}

- (void)richTextEditorToolbarDidSelectTextForegroundColor:(UIColor *)color
{
	[self applyAttrubutesToSelectedRange:color forKey:NSForegroundColorAttributeName];
}

- (void)richTextEditorToolbarDidSelectTextAlignment:(NSTextAlignment)textAlignment
{
	NSMutableParagraphStyle *mutParaStyle = [[NSMutableParagraphStyle alloc] init];
	mutParaStyle.alignment = textAlignment;
	
	NSRange paragraphRange = [self.attributedText paragraphRangeFromTextRange:self.selectedRange];
	[self applyAttributes:mutParaStyle forKey:NSParagraphStyleAttributeName atRange:paragraphRange];
}

#pragma mark - Private Methods -

- (void)applyAttributes:(id)attribute forKey:(NSString *)key atRange:(NSRange)range
{
	if (range.length > 0)
	{
		NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
		[attributedString addAttributes:[NSDictionary dictionaryWithObject:attribute forKey:key] range:range];
		
		[self setAttributedText:attributedString];
		[self setSelectedRange:range];
	}
}

- (void)applyAttrubutesToSelectedRange:(id)attribute forKey:(NSString *)key
{
	[self applyAttributes:attribute forKey:key atRange:self.selectedRange];
}

- (CGRect)currentScreenBoundsDependOnOrientation
{
	
    CGRect screenBounds = [UIScreen mainScreen].bounds ;
    CGFloat width = CGRectGetWidth(screenBounds)  ;
    CGFloat height = CGRectGetHeight(screenBounds) ;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
	
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        screenBounds.size = CGSizeMake(width, height);
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        screenBounds.size = CGSizeMake(height, width);
    }
    return screenBounds ;
}

#pragma mark - Setter & Getter -

- (RichTextEditorToolbar *)toolBar
{
	if (!_toolBar)
	{
		_toolBar = [[RichTextEditorToolbar alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, 40)];
		_toolBar.delegate = self;
	}
	
	return _toolBar;
}

@end
