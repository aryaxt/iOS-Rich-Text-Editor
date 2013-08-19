//
//  UIFont+RichTextEditor.m
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

#import "UIFont+RichTextEditor.h"

@implementation UIFont (RichTextEditor)

+ (NSString *)postscriptNameFromFullName:(NSString *)fullName
{
	UIFont *font = [UIFont fontWithName:fullName size:1];
	return (__bridge NSString *)(CTFontCopyPostScriptName((__bridge CTFontRef)(font)));
}

+ (UIFont *)fontWithName:(NSString *)name size:(CGFloat)size boldTrait:(BOOL)isBold italicTrait:(BOOL)isItalic
{
	NSString *postScriptName = [UIFont postscriptNameFromFullName:name];
	
	CTFontSymbolicTraits traits = 0;
	CTFontRef newFontRef;
	CTFontRef fontWithoutTrait = CTFontCreateWithName((__bridge CFStringRef)(postScriptName), size, NULL);
	
	if (isItalic)
		traits |= kCTFontItalicTrait;
	
	if (isBold)
		traits |= kCTFontBoldTrait;
	
	if (traits == 0)
	{
		newFontRef= CTFontCreateCopyWithAttributes(fontWithoutTrait, 0.0, NULL, NULL);
	}
	else
	{
		newFontRef = CTFontCreateCopyWithSymbolicTraits(fontWithoutTrait, 0.0, NULL, traits, traits);
	}
	
	if (newFontRef)
	{
		NSString *fontNameKey = (__bridge NSString *)(CTFontCopyName(newFontRef, kCTFontPostScriptNameKey));
		return [UIFont fontWithName:fontNameKey size:CTFontGetSize(newFontRef)];
	}
	
	return nil;
}

- (UIFont *)fontWithBoldTrait:(BOOL)bold italicTrait:(BOOL)italic andSize:(CGFloat)size
{
	CTFontRef fontRef = (__bridge CTFontRef)self;
	NSString *familyName = (__bridge NSString *)(CTFontCopyName(fontRef, kCTFontFamilyNameKey));
	NSString *postScriptName = [UIFont postscriptNameFromFullName:familyName];
	return [[self class] fontWithName:postScriptName size:size boldTrait:bold italicTrait:italic];
}

- (UIFont *)fontWithBoldTrait:(BOOL)bold andItalicTrait:(BOOL)italic
{
	return [self fontWithBoldTrait:bold italicTrait:italic andSize:self.pointSize];
}

- (BOOL)isBold
{
	CTFontSymbolicTraits trait = CTFontGetSymbolicTraits((__bridge CTFontRef)self);
	
	if ((trait & kCTFontTraitBold) == kCTFontTraitBold)
		return YES;
	
	return NO;
}

- (BOOL)isItalic
{
	CTFontSymbolicTraits trait = CTFontGetSymbolicTraits((__bridge CTFontRef)self);
	
	if ((trait & kCTFontTraitItalic) == kCTFontTraitItalic)
		return YES;
	
	return NO;
}

@end
