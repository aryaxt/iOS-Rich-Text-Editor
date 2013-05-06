//
//  UIFont+Additions.h
//  RichTextEditor
//
//  Created by Aryan Gh on 5/4/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface UIFont (Additions)

- (BOOL)isBold;
- (BOOL)isItalic;
- (UIFont *)fontWithBoldTrait:(BOOL)bold andItalicTrait:(BOOL)italic;
+ (UIFont *)fontWithName:(NSString *)name size:(float)size boldTrait:(BOOL)isBold italicTrait:(BOOL)isItalic;

@end
