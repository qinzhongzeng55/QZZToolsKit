//
//  AutomaticSizeTools.h
//  自动计算文本大小
//
//  Created by 秦忠增 on 2018/7/25.
//

#import <Foundation/Foundation.h>
#import "QZZSingleton.h"
#import <QZZCategoryKit/UILabel+ChangeLineSpaceAndWordSpace.h>
#import <QZZCategoryKit/UITextView+ChangeLineSpaceAndWordSpace.h>

@interface AutomaticSizeTools : NSObject

singleton_interface(AutomaticSizeTools)

/**
 * 根据文本计算size
 * @param txt 需要计算size的文本
 * @param font 文本的字体
 * @param size 最大size
 * @param LineSpacing 行间距
 * @param WordsSpacing 字间距
 */
- (CGSize)boundingALLRectWithSize:(NSString*)txt Font:(UIFont*)font MaxSize:(CGSize)size LineSpacing:(CGFloat)LineSpacing WordsSpacing:(CGFloat)WordsSpacing;
/**
 * 根据文本计算size
 * @param label 需要计算size的UILabel
 * @param width 文本的最大宽度
 * @param LineSpacing 行间距
 * @param WordsSpacing 字间距
 */
- (CGSize)calculateSizeForLabel:(UILabel *)label MaxWidth:(CGFloat)width LineSpacing:(CGFloat)LineSpacing WordsSpacing:(CGFloat)WordsSpacing;
/**
 * 根据文本计算size
 * @param textView 需要计算size的UITextView
 * @param width 文本的最大宽度
 * @param LineSpacing 行间距
 * @param WordsSpacing 字间距
 */
- (CGSize)calculateSizeForTextView:(UITextView *)textView MaxWidth:(CGFloat)width LineSpacing:(CGFloat)LineSpacing WordsSpacing:(CGFloat)WordsSpacing;
@end
