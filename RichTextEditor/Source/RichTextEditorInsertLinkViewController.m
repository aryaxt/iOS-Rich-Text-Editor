//
//  RichTextEditorInsertLinkViewController.m
//  RichTextEditor
//
//  Created by Andreas Lillebø Holm on 07/07/14.
//  Copyright (c) 2014 Aryan Ghassemi. All rights reserved.
//

#import "RichTextEditorInsertLinkViewController.h"

@implementation RichTextEditorInsertLinkViewController{
    UITextField *_urlField;
    UITextField *_displayField;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, 235, 100);
    self.view.backgroundColor = [UIColor whiteColor];

	UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 60, 30)];
	[btnClose addTarget:self action:@selector(closeSelected:) forControlEvents:UIControlEventTouchUpInside];
	[btnClose.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
	[btnClose setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btnClose setTitle:@"Close" forState:UIControlStateNormal];
	[self.view addSubview:btnClose];

	UIButton *btnDone = [[UIButton alloc] initWithFrame:CGRectMake(170, 5, 60, 30)];
	[btnDone addTarget:self action:@selector(doneSelected:) forControlEvents:UIControlEventTouchUpInside];
	[btnDone.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
	[btnDone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btnDone setTitle:@"Done" forState:UIControlStateNormal];
	[self.view addSubview:btnDone];

    _urlField = [[UITextField alloc] initWithFrame:CGRectMake(5, 33, 225, 30)];
    [_urlField setFont:[UIFont systemFontOfSize:12]];
    [_urlField setPlaceholder:@"Skriv link her (http://)"];
    [_urlField setBorderStyle:UITextBorderStyleLine];
    [_urlField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_urlField setAutocapitalizationType:UITextAutocorrectionTypeNo];
    [self.view addSubview:_urlField];

    _displayField = [[UITextField alloc] initWithFrame:CGRectMake(5, 65, 225, 30)];
    [_displayField setFont:[UIFont systemFontOfSize:12]];
    [_displayField setPlaceholder:@"Link beskrivelse her"];
    [_displayField setBorderStyle:UITextBorderStyleLine];
    [_displayField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_displayField setAutocapitalizationType:UITextAutocorrectionTypeNo];
    [self.view addSubview:_displayField];

    [_urlField becomeFirstResponder];
}

- (void)doneSelected:(id)sender{
    if([[_displayField text] isEqualToString:@""] || [[_displayField text] isEqualToString:@" "]){
        [_displayField becomeFirstResponder];
        return;
    }

    if([[_urlField text] isEqualToString:@""] || [[_urlField text] isEqualToString:@" "]){
        [_urlField becomeFirstResponder];
        return;
    }

    NSString *urlString = [self replaceURLWithLink:[_urlField text]];

    [self.delegate richTextEditorInsertLinkViewControllerInsertURL:[NSURL URLWithString:urlString] withDisplayText:[_displayField text]];
}
- (void)closeSelected:(id)sender{
    [self.delegate richTextEditorInsertLinkViewControllerDidCancel];
}

-(NSString*)replaceURLWithLink:(NSString*)text{
    NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray* matches = [detector matchesInString:text options:0 range:NSMakeRange(0, [text length])];
    NSString *retstring = text;
    for (NSTextCheckingResult* result in [matches reverseObjectEnumerator]) {
        NSString *match = [[result URL] absoluteString];
        NSRange range = [result range];
        retstring = [retstring stringByReplacingCharactersInRange:range withString:match];
    }

    return retstring;
}

@end
