//
//  FontPickerView.h
//  RichTextEditor
//
//  Created by Aryan Gh on 5/5/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FontPickerViewDelegate <NSObject>
- (void)fontPickerViewDidSelectFontWithName:(NSString *)fontName;
@end

@interface FontPickerView : UIView

@property (nonatomic, strong) NSArray *fontFamilies;
@property (nonatomic, weak) id<FontPickerViewDelegate> delegate;

@end
