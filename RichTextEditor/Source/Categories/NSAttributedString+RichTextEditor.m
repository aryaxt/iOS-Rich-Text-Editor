//
//  NSAttributedString+RichTextEditor.m
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "NSAttributedString+RichTextEditor.h"

@implementation NSAttributedString (RichTextEditor)

- (NSRange)paragraphRangeFromTextRange:(NSRange)range
{
	NSInteger start = -1;
	NSInteger end = -1;
	NSInteger length = 0;
	
	NSInteger startingRange = (range.location == self.string.length || [self.string characterAtIndex:range.location] == '\n') ?
		range.location-1 :
		range.location;
	
	for (int i=startingRange ; i>=0 ; i--)
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
	
	for (int i=moveForwardIndex; i<= self.string.length-1 ; i++)
	{
		char c = [self.string characterAtIndex:i];
		if (c == '\n')
		{
			end = i;
			break;
		}
	}
	
	end = (end == -1) ? self.string.length-1 : end;
	length = end - start;
	
	return NSMakeRange(start, length);
}

@end
