//
//  RichTextEditorLinkPickerViewController.h
//  RichTextEditor
//
//  Created by Aryan Gh on 8/20/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RichTextEditorLinkPickerViewControllerDelegate <NSObject>
- (void)richTextEditorLinkPickerViewControllerDidSelectLinkWithTitle:(NSString *)title andUrl:(NSURL *)url;
- (void)richTextEditorLinkPickerViewControllerDidSelectClose;
@end

@protocol RichTextEditorLinkPickerViewControllerDataSource <NSObject>
- (BOOL)RichTextEditorLinkPickerViewControllerShouldDisplayToolbar;
@end

@interface RichTextEditorLinkPickerViewController : UIViewController

@property (nonatomic, weak) id <RichTextEditorLinkPickerViewControllerDelegate> delegate;
@property (nonatomic, weak) id <RichTextEditorLinkPickerViewControllerDataSource> dataSource;
@property (nonatomic, strong) UITextField *txtTitle;
@property (nonatomic, strong) UITextField *txtUrl;

@end
