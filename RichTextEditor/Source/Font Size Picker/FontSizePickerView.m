//
//  FontSizePickerView.m
//  RichTextEditor
//
//  Created by Aryan Gh on 5/5/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "FontSizePickerView.h"

@implementation FontSizePickerView
@synthesize fontSizes;
@synthesize delegate;

#pragma mark - Initialization Methods -

- (id)init
{
	self = [[[NSBundle mainBundle]loadNibNamed:@"FontSizePickerView" owner:nil options:nil] lastObject];
	self.fontSizes = @[@8, @10, @12, @14, @16, @18, @20, @22, @24, @26, @28, @30];
	return self;
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.fontSizes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"FontSizeCell";
	
	NSNumber *fontSize = [self.fontSizes objectAtIndex:indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	cell.textLabel.text = fontSize.stringValue;
	cell.textLabel.font = [UIFont boldSystemFontOfSize:fontSize.intValue];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSNumber *fontSize = [self.fontSizes objectAtIndex:indexPath.row];
	[self.delegate fontSizePickerViewDidSelectFontSize:fontSize.intValue];
}

@end
