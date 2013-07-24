//
//  RichTextEditorColorPickerViewController.m
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "RichTextEditorColorPickerViewController.h"

@implementation RichTextEditorColorPickerViewController

#pragma mark - VoewController Methods -

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 60, 35)];
	[btnClose addTarget:self action:@selector(closeSelected:) forControlEvents:UIControlEventTouchUpInside];
	[btnClose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btnClose setTitle:@"Close" forState:UIControlStateNormal];
	[self.view addSubview:btnClose];
	
	UIButton *btnDone = [[UIButton alloc] initWithFrame:CGRectMake(65, 5, 60, 35)];
	[btnDone addTarget:self action:@selector(doneSelected:) forControlEvents:UIControlEventTouchUpInside];
	[btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btnDone setTitle:@"Done" forState:UIControlStateNormal];
	[self.view addSubview:btnDone];
	
	self.selectedColorView = [[UIView alloc] initWithFrame:CGRectMake(130, 5, 35, 35)];
	self.selectedColorView.backgroundColor = [UIColor blackColor];
	self.selectedColorView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.selectedColorView.layer.borderWidth = 1;
	[self.view addSubview:self.selectedColorView];
	
	self.colorsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colors.jpg"]];;
	self.colorsImageView.frame = CGRectMake(2, 50, self.view.frame.size.width-4, self.view.frame.size.height - 50 - 2);
	self.colorsImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.colorsImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.colorsImageView.layer.borderWidth = 1;
	[self.view addSubview:self.colorsImageView];
	
	self.contentSizeForViewInPopover = CGSizeMake(300, 240);
}

#pragma mark - Private Methods -

- (void)populateColorsForPoint:(CGPoint)point
{
	self.selectedColorView.backgroundColor = [self.colorsImageView colorOfPoint:point];
}

#pragma mark - IBActions -

- (IBAction)doneSelected:(id)sender
{
	[self.delegate richTextEditorColorPickerViewControllerDidSelectColor:self.selectedColorView.backgroundColor withAction:self.action];
}

- (IBAction)closeSelected:(id)sender
{
	[self.delegate richTextEditorColorPickerViewControllerDidSelectClose];
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
