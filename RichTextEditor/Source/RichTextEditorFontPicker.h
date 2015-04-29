//
//  RichTextEditorFontPicker.h
//  RichTextEditor
//
//  Created by Aryan Gh on 2/8/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RichTextEditorFontPickerViewControllerDelegate <NSObject>
- (void)richTextEditorFontPickerViewControllerDidSelectFontWithName:(NSString *)fontName;
- (void)richTextEditorFontPickerViewControllerDidSelectClose;
@end

@protocol RichTextEditorFontPickerViewControllerDataSource <NSObject>
- (NSArray *)richTextEditorFontPickerViewControllerCustomFontFamilyNamesForSelection;
- (BOOL)richTextEditorFontPickerViewControllerShouldDisplayToolbar;
@end

@protocol RichTextEditorFontPicker <NSObject>

@property (nonatomic, weak) id <RichTextEditorFontPickerViewControllerDelegate> delegate;
@property (nonatomic, weak) id <RichTextEditorFontPickerViewControllerDataSource> dataSource;

@end
