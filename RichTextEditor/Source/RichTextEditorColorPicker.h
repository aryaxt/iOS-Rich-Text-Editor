//
//  RichTextEditorColorPicker.h
//  RichTextEditor
//
//  Created by Aryan Gh on 2/8/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	RichTextEditorColorPickerActionTextForegroudColor,
	RichTextEditorColorPickerActionTextBackgroundColor
}RichTextEditorColorPickerAction;

@protocol RichTextEditorColorPickerViewControllerDelegate <NSObject>
- (void)richTextEditorColorPickerViewControllerDidSelectColor:(UIColor *)color withAction:(RichTextEditorColorPickerAction)action;
- (void)richTextEditorColorPickerViewControllerDidSelectClose;
@end

@protocol RichTextEditorColorPickerViewControllerDataSource <NSObject>
- (BOOL)richTextEditorColorPickerViewControllerShouldDisplayToolbar;
@end

@protocol RichTextEditorColorPicker <NSObject>

@property (nonatomic, weak) id <RichTextEditorColorPickerViewControllerDelegate> delegate;
@property (nonatomic, weak) id <RichTextEditorColorPickerViewControllerDataSource> dataSource;
@property (nonatomic, assign) RichTextEditorColorPickerAction action;

@end
