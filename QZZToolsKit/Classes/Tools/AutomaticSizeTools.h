//
//  AutomaticSizeTools.h
//  自动计算文本大小
//
//  Created by 秦忠增 on 2018/7/25.
//

#import <Foundation/Foundation.h>
#import "QZZSingleton.h"

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
@end
