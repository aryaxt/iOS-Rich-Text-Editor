//
//  RichTextEditorFontSizePickerViewController.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RichTextEditorFontSizePickerViewControllerDelegate <NSObject>
- (void)richTextEditorFontSizePickerViewControllerDidSelectFontSize:(NSNumber *)fontSize;
@end

@interface RichTextEditorFontSizePickerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<RichTextEditorFontSizePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *fontSizes;

@end
