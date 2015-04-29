//
//  RichTextEditorFontSizePicker.h
//  RichTextEditor
//
//  Created by Aryan Gh on 2/8/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RichTextEditorFontSizePickerViewControllerDelegate <NSObject>
- (void)richTextEditorFontSizePickerViewControllerDidSelectFontSize:(NSNumber *)fontSize;
- (void)richTextEditorFontSizePickerViewControllerDidSelectClose;
@end

@protocol RichTextEditorFontSizePickerViewControllerDataSource <NSObject>
- (BOOL)richTextEditorFontSizePickerViewControllerShouldDisplayToolbar;
- (NSArray *)richTextEditorFontSizePickerViewControllerCustomFontSizesForSelection;
@end

@protocol RichTextEditorFontSizePicker <NSObject>

@property (nonatomic, weak) id<RichTextEditorFontSizePickerViewControllerDelegate> delegate;
@property (nonatomic, weak) id<RichTextEditorFontSizePickerViewControllerDataSource> dataSource;

@end
