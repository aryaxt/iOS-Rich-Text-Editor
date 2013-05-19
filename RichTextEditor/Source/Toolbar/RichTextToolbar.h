//
//  Toolbar.h
//  RichTextEditor
//
//  Created by Aryan Gh on 5/7/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RichTextToolbarDelegate <NSObject>
- (void)richTextToolbarDidSelectBold;
- (void)richTextToolbarDidSelectItalic;
- (void)richTextToolbarDidSelectUnderline;
- (void)richTextToolbarDidSelectBackgroundColor;
- (void)richTextToolbarDidSelectTextColor;
- (void)richTextToolbarDidSelectFontSize;
- (void)richTextToolbarDidSelectFont;
- (void)richTextToolbarDidSelectTextAlignment:(NSTextAlignment)textAlignment;
@end

@interface RichTextToolbar : UIToolbar

@property (nonatomic, weak) id <RichTextToolbarDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnBold;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnItalic;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnUnderline;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnBackgroundColor;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnTextColor;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnFont;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *btnFontSize;
@property (nonatomic, strong) IBOutlet UISegmentedControl *textAlignmentSegmentedControl;

- (id)initWithDeleate:(id <RichTextToolbarDelegate>)aDelegate;
- (void)populateWithAttributes:(NSDictionary *)attributes;
- (IBAction)boldSelected:(id)sender;
- (IBAction)italicSelected:(id)sender;
- (IBAction)underlineSelected:(id)sender;
- (IBAction)backgroundColorSelected:(id)sender;
- (IBAction)textColorSelected:(id)sender;
- (IBAction)fontSelected:(id)sender;
- (IBAction)fontSizeSelected:(id)sender;
- (IBAction)textAlignmentSelected:(id)sender;

@end
