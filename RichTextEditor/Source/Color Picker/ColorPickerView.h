//
//  ColorPickerViewController.h
//  RichTextEditor
//
//  Created by Aryan Gh on 5/5/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Additions.h"

@class ColorPickerView;
@protocol ColorPickerViewDelegate <NSObject>
- (void)colorPickerView:(ColorPickerView *)colorPickerView didSelectColor:(UIColor *)color;
- (void)colorPickerViewDidSelectClose:(ColorPickerView *)colorPickerView;
@end

@interface ColorPickerView : UIView

@property (nonatomic, strong) IBOutlet UIImageView *colorsImageView;
@property (nonatomic, strong) IBOutlet UIView *selectedColorView;
@property (nonatomic, assign) int tag;
@property (nonatomic, weak) id <ColorPickerViewDelegate> delegate;

- (IBAction)doneSelected:(id)sender;
- (IBAction)closeSelected:(id)sender;

@end
