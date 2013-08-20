RichTextEditor-iOS
==================
RichTextEditor for iPhone &amp; iPad

Features:
- Bold
- Italic
- Underline
- StrikeThrough
- Font
- Font size
- Text background color
- Text foregroud color
- Text alignment
- Paragraph Indent/Outdent

![alt tag](https://raw.github.com/aryaxt/iOS-Rich-Text-Editor/master/ipadScreenShot.png)

![alt tag](https://raw.github.com/aryaxt/iOS-Rich-Text-Editor/master/iphoneScreenshot.png)


Custom Font Size Selection
-------------------------
Font size selection can be customized by implementing the following data source method

```objective-c
- (NSArray *)fontSizeSelectionForRichTextEditor:(RichTextEditor *)richTextEditor
{
	// pas an array of NSNumbers
	return @[@5, @10, @20, @30];
}
```

Custom Font Family Selection
-------------------------
Font family selection can be customized by implementing the following data source method

```objective-c
- (NSArray *)fontFamilySelectionForRichTextEditor:(RichTextEditor *)richTextEditor
{
	// pas an array of Strings
  // Can be taken from [UIFont familyNames]
	return @[@"Helvetica", @"Arial", @"Marion", @"Papyrus"];
}
```

Presentation Style
-------------------------
You can switch between popover, or modal by implementing the following data source method
```objective-c
- (RichTextEditorToolbarPresentationStyle)presentarionStyleForRichTextEditor:(RichTextEditor *)richTextEditor
{
  // RichTextEditorToolbarPresentationStyleModal Or RichTextEditorToolbarPresentationStylePopover
	return RichTextEditorToolbarPresentationStyleModal;
}
```

Modal Presentation Style
-------------------------
When presentarionStyleForRichTextEditor is a modal, modal-transition-style & modal-presentation-style can be configured
```objective-c
- (UIModalPresentationStyle)modalPresentationStyleForRichTextEditor:(RichTextEditor *)richTextEditor
{
	return UIModalPresentationFormSheet;
}

- (UIModalTransitionStyle)modalTransitionStyleForRichTextEditor:(RichTextEditor *)richTextEditor
{
	return UIModalTransitionStyleFlipHorizontal;
}
```

Customizing Features
-------------------------
Features can be turned on/off by iplementing the following data source method
```objective-c
- (RichTextEditorFeature)featuresEnabledForRichTextEditor:(RichTextEditor *)richTextEditor
{
   return RichTextEditorFeatureFont | 
          RichTextEditorFeatureFontSize |
          RichTextEditorFeatureBold |
          RichTextEditorFeatureParagraphIndentation;
}
```

Credits
==================
iPhone popover by werner77
https://github.com/werner77/WEPopover
