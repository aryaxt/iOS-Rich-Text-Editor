//
//  Toolbar.m
//  RichTextEditor
//
//  Created by Aryan Gh on 5/7/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "RichTextToolbar.h"

@implementation RichTextToolbar
@synthesize delegate;

#pragma mark - Initialization Methods -

- (id)initWithDeleate:(id <RichTextToolbarDelegate>)aDelegate
{
	if (self = [self init])
	{
		self.delegate = aDelegate;
	}
	
	return self;
}

- (id)init
{
	self = [[[NSBundle mainBundle]loadNibNamed:@"RichTextToolbar" owner:nil options:nil] lastObject];
	return self;
}

#pragma mark - Public Methods -

- (void)populateWithAttributes:(NSDictionary *)attributes
{
	/*
	 UIFont *font = [dictionary objectForKey:NSFontAttributeName];
	 NSParagraphStyle *paragraphStyle = [dictionary objectForKey:NSParagraphStyleAttributeName];
	 NSNumber *underline = [dictionary objectForKey:NSUnderlineStyleAttributeName];
	 */
}

#pragma mark - IBActions -

- (IBAction)boldSelected:(id)sender
{
	[self.delegate richTextToolbarDidSelectBold];
}

- (IBAction)italicSelected:(id)sender
{
	[self.delegate richTextToolbarDidSelectItalic];
}

- (IBAction)underlineSelected:(id)sender
{
	[self.delegate richTextToolbarDidSelectUnderline];
}

- (IBAction)backgroundColorSelected:(id)sender
{
	[self.delegate richTextToolbarDidSelectBackgroundColor];
}

- (IBAction)textColorSelected:(id)sender
{
	[self.delegate richTextToolbarDidSelectTextColor];
}

- (IBAction)fontSelected:(id)sender
{
	[self.delegate richTextToolbarDidSelectFont];
}

- (IBAction)fontSizeSelected:(id)sender
{
	[self.delegate richTextToolbarDidSelectFontSize];
}

- (IBAction)textAlignmentSelected:(UISegmentedControl *)sender
{
	NSTextAlignment textAlignment;
	
	switch (sender.selectedSegmentIndex)
	{
		case 0:
			textAlignment = NSTextAlignmentLeft;
			break;
		case 1:
			textAlignment = NSTextAlignmentCenter;
			break;
		case 2:
			textAlignment = NSTextAlignmentRight;
			break;
			
		default:
			break;
	}
	
	[self.delegate richTextToolbarDidSelectTextAlignment:textAlignment];
}

@end
