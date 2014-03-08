//
//  RichTextEditorFontSizePickerViewController.m
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

#import "RichTextEditorFontSizePickerViewController.h"

@implementation RichTextEditorFontSizePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSArray *customizedFontSizes = [self.dataSource richTextEditorFontSizePickerViewControllerCustomFontSizesForSelection];
	
	if (customizedFontSizes)
		self.fontSizes = customizedFontSizes;
	else
		self.fontSizes = @[@8, @10, @12, @14, @16, @18, @20, @22, @24, @26, @28, @30];
	
	if ([self.dataSource richTextEditorFontSizePickerViewControllerShouldDisplayToolbar])
	{
        
        CGFloat reservedSizeForStatusBar = (
                                            UIDevice.currentDevice.systemVersion.floatValue >= 7.0
                                            && !(   UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
                                                 && self.modalPresentationStyle==UIModalPresentationFormSheet
                                                 )
                                            ) ? 20.:0.; //Add the size of the status bar for iOS 7, not on iPad presenting modal sheet

        CGFloat toolbarHeight = 44 +reservedSizeForStatusBar;
		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, toolbarHeight)];
		toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		[self.view addSubview:toolbar];
		
		UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																						   target:nil
																						   action:nil];
		
		UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                   target:self
                                                                                   action:@selector(closeSelected:)];
		[toolbar setItems:@[closeItem, flexibleSpaceItem]];
		
		self.tableview.frame = CGRectMake(0, toolbarHeight, self.view.frame.size.width, self.view.frame.size.height - toolbarHeight);
	}
	else
	{
		self.tableview.frame = self.view.bounds;
	}
	
	[self.view addSubview:self.tableview];
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    
    self.preferredContentSize = CGSizeMake(100, 400);
#else
    
	self.contentSizeForViewInPopover = CGSizeMake(100, 400);
#endif

}

#pragma mark - IBActions -

- (void)closeSelected:(id)sender
{
	[self.delegate richTextEditorFontSizePickerViewControllerDidSelectClose];
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
	[self.delegate richTextEditorFontSizePickerViewControllerDidSelectFontSize:fontSize];
}

#pragma mark - Setter & Getter -

- (UITableView *)tableview
{
	if (!_tableview)
	{
		_tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
		_tableview.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_tableview.delegate = self;
		_tableview.dataSource = self;
	}
	
	return _tableview;
}

@end
