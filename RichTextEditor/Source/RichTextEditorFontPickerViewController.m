//
//  RichTextEditorFontViewController.m
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "RichTextEditorFontPickerViewController.h"

@implementation RichTextEditorFontPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSArray *customizedFontFamilies = [self.dataSource richTextEditorFontPickerViewControllerCustomFontFamilyNamesForSelection];
	
	if (customizedFontFamilies)
		self.fontNames = customizedFontFamilies;
	else
		self.fontNames = [UIFont familyNames];
	
	if ([self.dataSource richTextEditorFontPickerViewControllerShouldDisplayToolbar])
	{
		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
		toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self.view addSubview:toolbar];
		
		UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																						   target:nil
																						   action:nil];
		
		UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
																	  style:UIBarButtonItemStyleDone
																	 target:self
																	 action:@selector(closeSelected:)];
		
		[toolbar setItems:@[flexibleSpaceItem , closeItem]];
		
		self.tableview.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44);
	}
	else
	{
		self.tableview.frame = self.view.bounds;
	}
	
	[self.view addSubview:self.tableview];
	
	self.contentSizeForViewInPopover = CGSizeMake(250, 400);
}

#pragma mark - IBActions -

- (void)closeSelected:(id)sender
{
	[self.delegate richTextEditorFontPickerViewControllerDidSelectClose];
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.fontNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"FontSizeCell";
	
	NSString *fontName = [self.fontNames objectAtIndex:indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	cell.textLabel.text = fontName;
	cell.textLabel.font = [UIFont fontWithName:fontName size:16];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *fontName = [self.fontNames objectAtIndex:indexPath.row];
	[self.delegate richTextEditorFontPickerViewControllerDidSelectFontWithName:fontName];
}

#pragma mark - Setter & Getter -

- (UITableView *)tableview
{
	if (!_tableview)
	{
		_tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_tableview.delegate = self;
		_tableview.dataSource = self;
	}

	return _tableview;
}

@end
