//
//  NSAttributedString+RichTextEditor.m
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

#import "NSAttributedString+RichTextEditor.h"

@implementation NSAttributedString (RichTextEditor)

#pragma mark - Public MEthods -

- (NSRange)firstParagraphRangeFromTextRange:(NSRange)range
{
	if (self.string.length == 0)
		return NSMakeRange(0, 0);
	
	NSInteger start = -1;
	NSInteger end = -1;
	NSInteger length = 0;
	
	NSInteger startingRange = (range.location == self.string.length || [self.string characterAtIndex:range.location] == '\n') ?
		range.location-1 :
		range.location;
	
	for (NSInteger i=startingRange ; i>=0 ; i--)
	{
		char c = [self.string characterAtIndex:i];
		if (c == '\n')
		{
			start = i+1;
			break;
		}
	}
	
	start = (start == -1) ? 0 : start;
	
	NSInteger moveForwardIndex = (range.location > start) ? range.location : start;
	
	for (NSInteger i=moveForwardIndex; i<= self.string.length-1 ; i++)
	{
		char c = [self.string characterAtIndex:i];
		if (c == '\n')
		{
			end = i;
			break;
		}
	}
	
	end = (end == -1) ? self.string.length : end;
	length = end - start;
	
	return NSMakeRange(start, length);
}

- (NSArray *)rangeOfParagraphsFromTextRange:(NSRange)textRange
{
	NSMutableArray *paragraphRanges = [NSMutableArray array];
	NSInteger rangeStartIndex = textRange.location;
	
	while (true)
	{
		NSRange range = [self firstParagraphRangeFromTextRange:NSMakeRange(rangeStartIndex, 0)];
		rangeStartIndex = range.location + range.length + 1;
		
		[paragraphRanges addObject:[NSValue valueWithRange:range]];
		
		if (range.location + range.length >= textRange.location + textRange.length)
			break;
	}
	
	return paragraphRanges;
}

- (NSString *)htmlString
{
	NSMutableString *htmlString = [NSMutableString string];
	NSArray *paragraphRanges = [self rangeOfParagraphsFromTextRange:NSMakeRange(0, self.string.length-1)];
	
	for (int i=0 ; i<paragraphRanges.count ; i++)
	{
		NSValue *value = [paragraphRanges objectAtIndex:i];
		NSRange range = [value rangeValue];
		NSDictionary *paragraphDictionary = [self attributesAtIndex:range.location effectiveRange:nil];
		NSParagraphStyle *paragraphStyle = [paragraphDictionary objectForKey:NSParagraphStyleAttributeName];
		NSString *textAlignmentString = [self htmlTextAlignmentString:paragraphStyle.alignment];
		
		[htmlString appendString:@"<p "];
		
		if (textAlignmentString)
			[htmlString appendFormat:@"align=\"%@\" ", textAlignmentString];
		
		[htmlString appendFormat:@"style=\""];
		
		if (paragraphStyle.firstLineHeadIndent > 0)
			[htmlString appendFormat:@"text-indent:%.0fpx; ", paragraphStyle.firstLineHeadIndent - paragraphStyle.headIndent];
		
		if (paragraphStyle.headIndent > 0)
			[htmlString appendFormat:@"margin-left:%.0fpx; ", paragraphStyle.headIndent];
			
		
		[htmlString appendString:@" \">"];
		
		[self enumerateAttributesInRange:range
								 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
							  usingBlock:^(NSDictionary *dictionary, NSRange range, BOOL *stop){
											  
								  NSMutableString *fontString = [NSMutableString string];
								  UIFont *font = [dictionary objectForKey:NSFontAttributeName];
								  UIColor *foregroundColor = [dictionary objectForKey:NSForegroundColorAttributeName];
								  UIColor *backGroundColor = [dictionary objectForKey:NSBackgroundColorAttributeName];
								  NSNumber *underline = [dictionary objectForKey:NSUnderlineStyleAttributeName];
								  BOOL hasUnderline = (!underline || underline.intValue == NSUnderlineStyleNone) ? NO :YES;
								  NSNumber *strikeThrough = [dictionary objectForKey:NSStrikethroughStyleAttributeName];
								  BOOL hasStrikeThrough = (!strikeThrough || strikeThrough.intValue == NSUnderlineStyleNone) ? NO :YES;
								  
								  [fontString appendFormat:@"<font "];
								  [fontString appendFormat:@"face=\"%@\" ", font.familyName];
								  
								  // Begin style
								  [fontString appendString:@" style=\" "];
								  
								  [fontString appendFormat:@"font-size:%.0fpx; ", font.pointSize];
								  
								  if (foregroundColor && [foregroundColor isKindOfClass:[UIColor class]])
									  [fontString appendFormat:@"color:%@; ", [self htmlRgbColor:foregroundColor]];
								  
								  if (backGroundColor && [backGroundColor isKindOfClass:[UIColor class]])
									  [fontString appendFormat:@"background-color:%@; ", [self htmlRgbColor:backGroundColor]];
								  
								  [fontString appendString:@"\" "];
								  // End Style
								  
								  [fontString appendString:@">"];
								  [fontString appendString:[[self.string substringFromIndex:range.location] substringToIndex:range.length]];
								  [fontString appendString:@"</font>"];
								  
								  if ([font isBold])
								  {
									  [fontString insertString:@"<b>" atIndex:0];
									  [fontString insertString:@"</b>" atIndex:fontString.length];
								  }
								  
								  if ([font isItalic])
								  {
									  [fontString insertString:@"<i>" atIndex:0];
									  [fontString insertString:@"</i>" atIndex:fontString.length];
								  }
								  
								  if (hasUnderline)
								  {
									  [fontString insertString:@"<u>" atIndex:0];
									  [fontString insertString:@"</u>" atIndex:fontString.length];
								  }
								  
								  if (hasStrikeThrough)
								  {
									  [fontString insertString:@"<strike>" atIndex:0];
									  [fontString insertString:@"</strike>" atIndex:fontString.length];
								  }
								  
								  
								  [htmlString appendString:fontString];
							  }];
		
		[htmlString appendString:@"</p>"];
	}
	
	return htmlString;
}

#pragma mark - Helper Methods -

- (NSString *)htmlTextAlignmentString:(NSTextAlignment)textAlignment
{
	switch (textAlignment)
	{
		case NSTextAlignmentLeft:
			return @"left";
	
		case NSTextAlignmentCenter:
			return @"center";
			
		case NSTextAlignmentRight:
			return @"right";
			
		case NSTextAlignmentJustified:
			return @"justify";
			
		default:
			return nil;
	}
}

- (NSString *)htmlRgbColor:(UIColor *)color
{
	CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
	[color getRed:&red green:&green blue:&blue alpha:&alpha];
	return [NSString stringWithFormat:@"rgb(%d,%d,%d)",(int)(red*255.0), (int)(green*255.0), (int)(blue*255.0)];
}

@end
