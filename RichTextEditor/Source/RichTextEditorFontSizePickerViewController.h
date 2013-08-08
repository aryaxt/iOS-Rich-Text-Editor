//
//  RichTextEditorFontSizePickerViewController.h
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

#import <UIKit/UIKit.h>

@protocol RichTextEditorFontSizePickerViewControllerDelegate <NSObject>
- (void)richTextEditorFontSizePickerViewControllerDidSelectFontSize:(NSNumber *)fontSize;
- (void)richTextEditorFontSizePickerViewControllerDidSelectClose;
@end

@protocol RichTextEditorFontSizePickerViewControllerDataSource <NSObject>
- (BOOL)richTextEditorFontSizePickerViewControllerShouldDisplayToolbar;
- (NSArray *)richTextEditorFontSizePickerViewControllerCustomFontSizesForSelection;
@end

@interface RichTextEditorFontSizePickerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<RichTextEditorFontSizePickerViewControllerDelegate> delegate;
@property (nonatomic, weak) id<RichTextEditorFontSizePickerViewControllerDataSource> dataSource;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *fontSizes;

@end
