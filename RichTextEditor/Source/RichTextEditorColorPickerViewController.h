//
//  RichTextEditorColorPickerViewController.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIView+RichTextEditor.h"

typedef enum {
	RichTextEditorColorPickerActionTextForegroudColor,
	RichTextEditorColorPickerActionTextBackgroundColor
}RichTextEditorColorPickerAction;

@protocol RichTextEditorColorPickerViewControllerDelegate <NSObject>
- (void)richTextEditorColorPickerViewControllerDidSelectColor:(UIColor *)color withAction:(RichTextEditorColorPickerAction)action;
- (void)richTextEditorColorPickerViewControllerDidSelectClose;
@end

@interface RichTextEditorColorPickerViewController : UIViewController

@property (nonatomic, weak) id<RichTextEditorColorPickerViewControllerDelegate> delegate;
@property (nonatomic, assign) RichTextEditorColorPickerAction action;
@property (nonatomic, strong) UIImageView *colorsImageView;
@property (nonatomic, strong) UIView *selectedColorView;

- (IBAction)doneSelected:(id)sender;
- (IBAction)closeSelected:(id)sender;

@end
