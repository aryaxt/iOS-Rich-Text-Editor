//
//  RichTextEditorTogleButton.m
//  RichTextEditor
//
//  Created by Aryan Gh on 7/27/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//
// https://github.com/aryaxt/iOS-Rich-Text-Editor
//
// Permission to use, copy, modify and distribute this software and its documentation
// is hereby granted, provided that both the copyright notice and this permission
// notice appear in all copies of the software, derivative works or modified versions,
// and any portions thereof, and that both notices appear in supporting documentation,
// and that credit is given to Aryan Ghassemi in all documents and publicity
// pertaining to direct or indirect use of this code or its derivatives.
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
