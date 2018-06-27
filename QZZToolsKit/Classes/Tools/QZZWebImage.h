//
//  QZZWebImage.h
//  ==================注释说明====================
//                      ||
//                      ||
//                      ||
//                     \\//
//                      \/
//                  图片操作类
//基于SDWebImage
//  =============================================
//  Created by qinzhongzeng on 16/6/19.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <QZZCategoryKit/UIImage+ImageEffects.h>
#import "FLAnimatedImageView+WebCache.h"

///图片沙盒路径
#define kGetImageCachePathInShaHe(imagePath) [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:imagePath]

typedef NS_ENUM(NSInteger, ImageEffectsType) {
    ImageEffectsTypeLight,
    ImageEffectsTypeExtraLight,
    ImageEffectsTypeDark
};

@interface QZZWebImage : NSObject

///图片缓存路径
@property (nonatomic, copy) NSString *cacheImagePath;
///图片缓存大小(以MB为单位)
@property (nonatomic, assign) CGFloat totalCacheSize;

+ (instancetype)sharedWebImage;

/**
 *  清理缓存图片(包括内存和沙盒中的缓存)
 */
- (void)clearCacheImage;

/**清除沙盒中的图片缓存*/
- (void)clearImageCacheInSandbox;

/**计算缓存大小*/
- (NSString *)caculateCacheSize;

/**
 *  根据data加载GIF图片
 */
+ (FLAnimatedImageView *)getGifImageWithData:(NSData *)data;

/**
 *  根据图片名称加载NSBundle中的GIF图片
 *
 *  @param imgName 图片名称
 */
+ (FLAnimatedImageView *)getGifImageWithNameInNSBundle:(NSString *)imgName;
/**
 *  根据URL地址加载GIF图片
 *
 *  @param urlPath 网络GIF图片的地址
 */
+ (FLAnimatedImageView *)getGifImageWithUrlPath:(NSString *)urlPath;

/**
 *  将图片转换成圆角图片
 *
 *  @param img 需要转换的图片
 *  @param size 需要转换的图片的尺寸
 *  @return 圆角图片
 */
+ (UIImage *)getImageForArc:(UIImage *)img size:(CGSize)size;

/**
 *  将Base64转换成图片
 *
 *  @param string Base64类型的字符串
 */
+ (UIImage *)imageFromBase64String:(NSString *)string;
/**
 *  获取屏幕截图
 */
+ (UIImage *)getScreenCaptureImage;
/**
 *  获取磨砂图片
 *
 *  @param type 磨砂效果类型
 */
+ (UIImage *)getFrostedImage:(UIImage *)image type:(ImageEffectsType)type;
@end
