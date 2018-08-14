//
//  AutomaticSizeTools.m
//  Pods
//
//  Created by 秦忠增 on 2018/7/25.
//

#import "AutomaticSizeTools.h"

@implementation AutomaticSizeTools

singleton_implementation(AutomaticSizeTools)

/**
 * 根据文本计算size
 * @param txt 需要计算size的文本
 * @param font 文本的字体
 * @param size 最大size
 * @param LineSpacing 行间距
 * @param WordsSpacing 字间距
 */
- (CGSize)boundingALLRectWithSize:(NSString*)txt Font:(UIFont*)font MaxSize:(CGSize)size LineSpacing:(CGFloat)LineSpacing WordsSpacing:(CGFloat)WordsSpacing{
    if (txt == nil) {
        return CGSizeZero;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:txt];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:LineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [txt length])];
    
    CGSize realSize = CGSizeZero;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    CGRect textRect = [txt boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style,NSKernAttributeName:@(WordsSpacing)} context:nil];
    realSize = textRect.size;
#else
    realSize = [txt sizeWithFont:font constrainedToSize:size];
#endif
    
    realSize.width = ceilf(realSize.width);
    realSize.height = ceilf(realSize.height);
    return realSize;
}
- (CGSize)calculateSizeForLabel:(UILabel *)label MaxWidth:(CGFloat)width LineSpacing:(CGFloat)LineSpacing WordsSpacing:(CGFloat)WordsSpacing{
    UIFont *contentFont = label.font;
    CGSize contentTextMaxSize = CGSizeMake(width,DBL_MAX);
    CGSize size = [[AutomaticSizeTools sharedAutomaticSizeTools] boundingALLRectWithSize:label.text Font:contentFont MaxSize:contentTextMaxSize LineSpacing:LineSpacing WordsSpacing:WordsSpacing];
    UIFontDescriptor *ctfFont = contentFont.fontDescriptor;
    NSNumber *fontString = [ctfFont objectForKey:@"NSFontSizeAttribute"];
    if (size.height <= ([fontString integerValue]+LineSpacing+10)) {
        size = CGSizeMake(size.width, size.height - LineSpacing);
        [UILabel changeSpace:label withLineSpace:0 WordSpace:WordsSpacing];
    }else{
        [UILabel changeSpace:label withLineSpace:LineSpacing WordSpace:WordsSpacing];
    }
    return size;
}
- (CGSize)calculateSizeForTextView:(UITextView *)textView MaxWidth:(CGFloat)width LineSpacing:(CGFloat)LineSpacing WordsSpacing:(CGFloat)WordsSpacing{
    UIFont *contentFont = textView.font;
    CGSize contentTextMaxSize = CGSizeMake(width,DBL_MAX);
    CGSize size = [self boundingALLRectWithSize:textView.text Font:contentFont MaxSize:contentTextMaxSize LineSpacing:LineSpacing WordsSpacing:WordsSpacing];
    UIFontDescriptor *ctfFont = contentFont.fontDescriptor;
    NSNumber *fontString = [ctfFont objectForKey:@"NSFontSizeAttribute"];
    if (size.height <= ([fontString integerValue]+LineSpacing+10)) {
        size = CGSizeMake(size.width, size.height - LineSpacing);
        [UITextView changeSpace:textView withLineSpace:0 WordSpace:WordsSpacing];
    }else{
        [UITextView changeSpace:textView withLineSpace:LineSpacing WordSpace:WordsSpacing];
    }
    return size;
}
@end
