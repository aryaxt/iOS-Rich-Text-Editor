//
//  RichTextEditorTogleButton.m
//  RichTextEditor
//
//  Created by Aryan Gh on 7/27/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "RichTextEditorToggleButton.h"

@implementation RichTextEditorToggleButton

- (id)initWithStyle:(RichTextEditorToggleButtonStyle)aStyle
{
	if (self = [super init])
	{
		_style = aStyle;
		self.on = NO;
	}
	
	return self;
}

- (void)setOn:(BOOL)on
{
	_on = on;
	
	[self setBackgroundImage:[self imageForState] forState:UIControlStateNormal];
}

- (UIImage *)imageForState
{
	if (self.on)
	{
		switch (self.style)
		{
			case RichTextEditorToggleButtonStyleLeft:
				return [UIImage imageNamed:@"buttonleftSelected.png"];
			case RichTextEditorToggleButtonStyleCenter:
				return [UIImage imageNamed:@"buttoncenterSelected.png"];
			case RichTextEditorToggleButtonStyleRight:
				return [UIImage imageNamed:@"buttonrightSelected.png"];
			case RichTextEditorToggleButtonStyleNormal:
				return [UIImage imageNamed:@"buttonSelected.png"];
			default:
				return nil;;
		}
	}
	else
	{
		switch (self.style)
		{
			case RichTextEditorToggleButtonStyleLeft:
				return [UIImage imageNamed:@"buttonleft.png"];
			case RichTextEditorToggleButtonStyleCenter:
				return [UIImage imageNamed:@"buttoncenter.png"];
			case RichTextEditorToggleButtonStyleRight:
				return [UIImage imageNamed:@"buttonright.png"];
			case RichTextEditorToggleButtonStyleNormal:
				return [UIImage imageNamed:@"button.png"];
			default:
				return nil;;
		}
	}
	
	return nil;
}

@end
