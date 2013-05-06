//
//  ColorPickerViewController.m
//  RichTextEditor
//
//  Created by Aryan Gh on 5/5/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "ColorPickerView.h"

@implementation ColorPickerView
@synthesize colorsImageView;
@synthesize selectedColorView;
@synthesize delegate;
@synthesize tag;

#pragma mark - Initialization Methods -

- (id)init
{
	self = [[[NSBundle mainBundle]loadNibNamed:@"ColorPickerView" owner:nil options:nil] lastObject];
	return self;
}

#pragma mark - Private Methods -

- (void)populateColorsForPoint:(CGPoint)point
{
	self.selectedColorView.backgroundColor = [self.colorsImageView colorOfPoint:point];
}

#pragma mark - IBActions -

- (IBAction)doneSelected:(id)sender
{
	[self.delegate colorPickerView:self didSelectColor:self.selectedColorView.backgroundColor];
}

- (IBAction)closeSelected:(id)sender
{
	[self.delegate colorPickerViewDidSelectClose:self];
}

#pragma mark - Touch Detection -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint locationPoint = [[touches anyObject] locationInView:self.colorsImageView];
	[self populateColorsForPoint:locationPoint];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint locationPoint = [[touches anyObject] locationInView:self.colorsImageView];
	[self populateColorsForPoint:locationPoint];
}

@end
