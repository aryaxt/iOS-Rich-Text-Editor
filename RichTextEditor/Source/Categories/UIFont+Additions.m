//
//  UIFont+Additions.m
//  RichTextEditor
//
//  Created by Aryan Gh on 5/4/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "UIFont+Additions.h"

@implementation UIFont (Additions)

+ (UIFont *)fontWithName:(NSString *)name size:(float)size boldTrait:(BOOL)isBold italicTrait:(BOOL)isItalic
{
	CTFontSymbolicTraits traits = 0;
	CTFontRef newFontRef;
	CTFontRef fontWithoutTrait = CTFontCreateWithName((__bridge CFStringRef)(name), size, NULL);
	
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

- (UIFont *)fontWithBoldTrait:(BOOL)bold andItalicTrait:(BOOL)italic
{
	CTFontRef fontRef = (__bridge CTFontRef)self;
	NSString *familyName = (__bridge NSString *)(CTFontCopyName(fontRef, kCTFontFamilyNameKey));
	return [[self class] fontWithName:familyName size:self.pointSize boldTrait:bold italicTrait:italic];
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

/*- (int)weight
 {
 CTFontRef fontRef = (__bridge CTFontRef)self;
 CFDictionaryRef dictionaryRef = (CTFontCopyAttribute(fontRef, kCTFontTraitsAttribute));
 int weight = (int) [(__bridge NSDictionary *)dictionaryRef objectForKey:(NSString *)kCTFontWeightTrait];
 CFRelease(dictionaryRef);
 
 return weight;
 }
 
 - (UIFont *)fontByAddingSymbolicTrait:(CTFontSymbolicTraits)addedTtait
 {
 CTFontRef fontRef = (__bridge CTFontRef)self;
 CTFontSymbolicTraits currentTrait = CTFontGetSymbolicTraits(fontRef);
 CTFontSymbolicTraits newTrait = currentTrait | addedTtait;
 CTFontRef newFontRef;
 
 if (newTrait == currentTrait)
 {
 newFontRef= CTFontCreateCopyWithAttributes(fontRef, 0.0, NULL, NULL);
 }
 else
 {
 newFontRef = CTFontCreateCopyWithSymbolicTraits(fontRef, 0.0, NULL, newTrait, newTrait);
 }
 
 if (newFontRef)
 {
 NSString *fontNameKey = (__bridge NSString *)(CTFontCopyName(newFontRef, kCTFontPostScriptNameKey));
 return [UIFont fontWithName:fontNameKey size:CTFontGetSize(newFontRef)];
 }
 
 return nil;
 }
 
 - (UIFont *)fontByRemovingSymbolicTrait:(CTFontSymbolicTraits)removingTrait
 {
 CTFontRef fontRef = (__bridge CTFontRef)self;
 CTFontSymbolicTraits currentTrait = CTFontGetSymbolicTraits(fontRef);
 CTFontSymbolicTraits newTrait = currentTrait & ~removingTrait;
 CTFontRef newFontRef;
 
 if (newTrait == currentTrait)
 {
 newFontRef= CTFontCreateCopyWithAttributes(fontRef, 0.0, NULL, NULL);
 }
 else
 {
 newFontRef = CTFontCreateCopyWithSymbolicTraits(fontRef, 0.0, NULL, newTrait, newTrait);
 }
 
 if (newFontRef)
 {
 NSString *fontNameKey = (__bridge NSString *)(CTFontCopyName(newFontRef, kCTFontPostScriptNameKey));
 return [UIFont fontWithName:fontNameKey size:CTFontGetSize(newFontRef)];
 }
 
 return nil;
 }*/

@end
