//
//  UILabel+ChangeLineSpaceAndWordSpace.m
//
//
//  Created by qinzhongzeng on 2017/2/23.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import "UILabel+ChangeLineSpaceAndWordSpace.h"

@implementation UILabel (ChangeLineSpaceAndWordSpace)

+ (void)changeLineSpace:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    if (labelText == nil) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSFontAttributeName:label.font}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpace:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    if (labelText == nil) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space),NSFontAttributeName:label.font}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpace:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    if (labelText == nil) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace),NSFontAttributeName:label.font}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}
+ (void)changeSpace:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace textAlignment:(NSTextAlignment)textAlignment{
    
    NSString *labelText = label.text;
    if (labelText == nil) {
        return;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace),NSFontAttributeName:label.font}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    paragraphStyle.alignment = textAlignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
@end
