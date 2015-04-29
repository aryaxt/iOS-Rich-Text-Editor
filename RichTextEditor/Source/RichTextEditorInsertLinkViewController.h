//
//  RichTextEditorInsertLinkViewController.h
//  RichTextEditor
//
//  Created by Andreas Lillebø Holm on 07/07/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RichTextEditorInsertLinkViewControllerDelegate <NSObject>

- (void)richTextEditorInsertLinkViewControllerInsertURL:(NSURL *)url withDisplayText:(NSString *)displayText;
- (void)richTextEditorInsertLinkViewControllerDidCancel;

@end

@interface RichTextEditorInsertLinkViewController : UIViewController

@property(nonatomic, weak) id<RichTextEditorInsertLinkViewControllerDelegate> delegate;

- (void)doneSelected:(id)sender;
- (void)closeSelected:(id)sender;

@end


