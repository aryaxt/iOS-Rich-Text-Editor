//
//  RichTextEditor.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RichTextEditorToolbar.h"
#import "UIFont+RichTextEditor.h"
#import "NSAttributedString+RichTextEditor.h"

@interface RichTextEditor : UITextView <RichTextEditorToolbarDelegate>

@property (nonatomic, strong) RichTextEditorToolbar *toolBar;

@end
