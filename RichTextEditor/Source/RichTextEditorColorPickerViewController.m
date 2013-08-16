//
//  RichTextEditorColorPickerViewController.m
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

#import "RichTextEditorColorPickerViewController.h"

@implementation RichTextEditorColorPickerViewController

#pragma mark - VoewController Methods -

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 60, 30)];
	[btnClose addTarget:self action:@selector(closeSelected:) forControlEvents:UIControlEventTouchUpInside];
	[btnClose.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
	[btnClose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btnClose setTitle:@"Close" forState:UIControlStateNormal];
	[self.view addSubview:btnClose];
	
	UIButton *btnDone = [[UIButton alloc] initWithFrame:CGRectMake(65, 5, 60, 30)];
	[btnDone addTarget:self action:@selector(doneSelected:) forControlEvents:UIControlEventTouchUpInside];
	[btnDone.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
	[btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btnDone setTitle:@"Done" forState:UIControlStateNormal];
	[self.view addSubview:btnDone];
	
	self.selectedColorView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 35 - 5, 5, 35, 30)];
	self.selectedColorView.backgroundColor = [UIColor blackColor];
	self.selectedColorView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.selectedColorView.layer.borderWidth = 1;
	self.selectedColorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	[self.view addSubview:self.selectedColorView];
	
	self.colorsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colors.jpg"]];;
	self.colorsImageView.frame = CGRectMake(2, 40, self.view.frame.size.width-4, self.view.frame.size.height - 40 - 2);
	self.colorsImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.colorsImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	self.colorsImageView.layer.borderWidth = 1;
	[self.view addSubview:self.colorsImageView];
	
	if ([self.dataSource richTextEditorColorPickerViewControllerShouldDisplayToolbar])
	{
		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
		toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self.view addSubview:toolbar];
		
		UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																						   target:nil
																						   action:nil];
		
		UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
																	  style:UIBarButtonItemStyleDone
																	 target:self
																	 action:@selector(doneSelected:)];
		
		UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
																	  style:UIBarButtonItemStyleDone
																	 target:self
																	 action:@selector(closeSelected:)];
		
		UIBarButtonItem *selectedColorItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectedColorView];
		
		[toolbar setItems:@[doneItem, selectedColorItem, flexibleSpaceItem , closeItem]];
		[self.view addSubview:toolbar];
		
		self.colorsImageView.frame = CGRectMake(2, 46, self.view.frame.size.width-4, self.view.frame.size.height - 46 - 2);
	}
	
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
