//
//  RichTextEditorFontViewController.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RichTextEditorFontPickerViewControllerDelegate <NSObject>
- (void)richTextEditorFontPickerViewControllerDidSelectFontWithName:(NSString *)fontName;
- (void)richTextEditorFontPickerViewControllerDidSelectClose;
@end

@protocol RichTextEditorFontPickerViewControllerDataSource <NSObject>
- (NSArray *)richTextEditorFontPickerViewControllerCustomFontFamilyNamesForSelection;
- (BOOL)richTextEditorFontPickerViewControllerShouldDisplayToolbar;
@end

@interface RichTextEditorFontPickerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <RichTextEditorFontPickerViewControllerDelegate> delegate;
@property (nonatomic, weak) id <RichTextEditorFontPickerViewControllerDataSource> dataSource;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *fontNames;

@end
