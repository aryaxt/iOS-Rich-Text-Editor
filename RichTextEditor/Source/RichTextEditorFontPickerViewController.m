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
	
	if (!self.fontNames)
		self.fontNames = [UIFont familyNames];
	
	[self.view addSubview:self.tableview];
	
	self.contentSizeForViewInPopover = CGSizeMake(250, 400);
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
	[self.delegate richTextEditorFontPickerViewControllerDidSelectFonteWithNam:fontName];
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
