//
//  FontSizePickerView.h
//  RichTextEditor
//
//  Created by Aryan Gh on 5/5/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FontSizePickerViewDelegate <NSObject>
- (void)fontSizePickerViewDidSelectFontSize:(NSInteger)fontSize;
@end

@interface FontSizePickerView : UIView

@property (nonatomic, strong) NSArray *fontSizes;
@property (nonatomic, weak) id <FontSizePickerViewDelegate> delegate;

@end
