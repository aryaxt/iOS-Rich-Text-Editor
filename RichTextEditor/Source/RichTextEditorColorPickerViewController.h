//
//  RichTextEditorColorPickerViewController.h
//  RichTextEdtor
//
//  Created by Aryan Gh on 7/21/13.
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIView+RichTextEditor.h"

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

@interface RichTextEditorColorPickerViewController : UIViewController

@property (nonatomic, weak) id <RichTextEditorColorPickerViewControllerDelegate> delegate;
@property (nonatomic, weak) id <RichTextEditorColorPickerViewControllerDataSource> dataSource;
@property (nonatomic, assign) RichTextEditorColorPickerAction action;
@property (nonatomic, strong) UIImageView *colorsImageView;
@property (nonatomic, strong) UIView *selectedColorView;

- (IBAction)doneSelected:(id)sender;
- (IBAction)closeSelected:(id)sender;

@end
