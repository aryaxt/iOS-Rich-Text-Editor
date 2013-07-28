//
//  RichTextEditorTogleButton.h
//  RichTextEditor
//
//  Created by Aryan Gh on 7/27/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
	RichTextEditorToggleButtonStyleLeft,
	RichTextEditorToggleButtonStyleCenter,
	RichTextEditorToggleButtonStyleRight,
	RichTextEditorToggleButtonStyleNormal
}RichTextEditorToggleButtonStyle;

@interface RichTextEditorToggleButton : UIButton

- (id)initWithStyle:(RichTextEditorToggleButtonStyle)style;

@property (nonatomic, readonly) RichTextEditorToggleButtonStyle style;
@property (nonatomic, assign) BOOL on;

@end
