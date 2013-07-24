//
//  NSAttributedString+RichTextEditor.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (RichTextEditor)

- (NSRange)paragraphRangeFromTextRange:(NSRange)range;

@end
