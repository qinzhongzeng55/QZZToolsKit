//
//  UILabel+ChangeLineSpaceAndWordSpace.h
//  
//
//  Created by qinzhongzeng on 2017/2/23.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//  设置label的行间距和字间距

#import <UIKit/UIKit.h>

@interface UILabel (ChangeLineSpaceAndWordSpace)

/**
 *  改变行间距
 */
+ (void)changeLineSpace:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpace:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpace:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

/**
 *  改变字体对齐方式 行间距和字间距
 */
+ (void)changeSpace:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace textAlignment:(NSTextAlignment)textAlignment;
@end
