//
//  NSString+RichTextEditor.m
//  RichTextEditor
//
//  Created by Aryan Gh on 9/15/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "NSString+RichTextEditor.h"

@implementation NSString (RichTextEditor)

- (BOOL)startsWithString:(NSString *)string
{
	if (!string.length || string.length > self.length)
		return NO;
	
	return ([[self substringToIndex:string.length] isEqualToString:string]) ? YES : NO;
}

@end
