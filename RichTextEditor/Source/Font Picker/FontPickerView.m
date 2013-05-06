//
//  FontPickerView.m
//  RichTextEditor
//
//  Created by Aryan Gh on 5/5/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "FontPickerView.h"

@implementation FontPickerView
@synthesize fontFamilies;
@synthesize delegate;

#pragma mark - Initialization Methods -

- (id)init
{
	self = [[[NSBundle mainBundle]loadNibNamed:@"FontPickerView" owner:nil options:nil] lastObject];
	self.fontFamilies = [UIFont familyNames];
	return self;
}

#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.fontFamilies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"FontFamilyCell";
	
	NSString *fontFamilyName = [self.fontFamilies objectAtIndex:indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	
	cell.textLabel.text = fontFamilyName;
	cell.textLabel.font = [UIFont fontWithName:fontFamilyName size:14];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *fontFamilyName = [self.fontFamilies objectAtIndex:indexPath.row];
	[self.delegate fontPickerViewDidSelectFontWithName:fontFamilyName];
}

@end
