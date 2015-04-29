//
//  RichTextEditorLinkPickerViewController.m
//  RichTextEditor
//
//  Created by Aryan Gh on 8/20/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "RichTextEditorLinkPickerViewController.h"

@implementation RichTextEditorLinkPickerViewController

#pragma mark - UIViewController Methods -

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
	
	self.txtTitle = [[UITextField alloc] initWithFrame:CGRectMake(5, 100, 300, 44)];
	[self.txtTitle setPlaceholder:@"Title"];
	[self.view addSubview:self.txtTitle];
	
	self.txtUrl = [[UITextField alloc] initWithFrame:CGRectMake(5, 150, 300, 44)];
	[self.txtUrl setPlaceholder:@"Title"];
	[self.view addSubview:self.txtUrl];
	
	if ([self.dataSource RichTextEditorLinkPickerViewControllerShouldDisplayToolbar])
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
		
		[toolbar setItems:@[doneItem, flexibleSpaceItem , closeItem]];
		[self.view addSubview:toolbar];
	}
	
	self.contentSizeForViewInPopover = CGSizeMake(300, 240);
}

#pragma mark - IBActions -

- (void)closeSelected:(id)sender
{
	[self.delegate richTextEditorLinkPickerViewControllerDidSelectClose];
}

- (void)doneSelected:(id)sender
{
	[self.delegate richTextEditorLinkPickerViewControllerDidSelectLinkWithTitle:self.txtTitle.text andUrl:[NSURL URLWithString:self.txtUrl.text]];
}

@end
