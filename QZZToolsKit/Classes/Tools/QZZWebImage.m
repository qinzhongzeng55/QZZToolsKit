//
//  QZZWebImage.m
//
//
//  Created by qinzhongzeng on 16/6/19.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import "QZZWebImage.h"

@interface QZZWebImage()

@end

static QZZWebImage *_sharedInstance = nil;

@implementation QZZWebImage

+ (instancetype)sharedWebImage{
    @synchronized(self){
        if(_sharedInstance == nil){
            _sharedInstance = [[self alloc] init];
            //计算缓存大小
            [_sharedInstance caculateCacheSize];
        }
    }
    return _sharedInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_sharedInstance == nil) {
            _sharedInstance = [super allocWithZone:zone];
            //计算缓存大小
            [_sharedInstance caculateCacheSize];
        }
    });
    return _sharedInstance;
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

- (void)clearCacheImage
{
    //清除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
    //清除沙盒中的缓存
    [self clearImageCacheInSandbox];
}

/**计算缓存大小*/
- (NSString *)caculateCacheSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSString *directoryPath = kGetImageCachePathInShaHe(self.cacheImagePath);
    BOOL isDirectory = NO;
    // 判断路径是否存在
    BOOL exist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    NSLog(@"\n图片缓存地址:\n%@",directoryPath);
    // 用于累计缓存图片总大小
    NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
    CGFloat totalSize = intg;
    self.totalCacheSize = totalSize;
    if(exist && isDirectory)
    {
        // 列出图片缓存文件夹下的所有图片
        NSArray *imageArray = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
        if(imageArray.count > 0)
        {
            for(NSString *fileName in imageArray)
            {
                NSString *fullPath = [directoryPath stringByAppendingPathComponent:fileName];
                // 判断是否存在
                exist = [mgr fileExistsAtPath:fullPath];
                if(exist)
                {
                    // 计算大小
                    NSDictionary *attributesDict = [mgr attributesOfItemAtPath:fullPath error:nil];
                    // byte为单位
                    NSString *fileSize = attributesDict[NSFileSize];
                    totalSize += fileSize.integerValue;
                }
            }
        }
        self.totalCacheSize =  totalSize;
        return [self convertSize:totalSize];
    }else{
        //目录不存在则创建该目录
        [mgr createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        self.totalCacheSize =  totalSize;
        return [self convertSize:totalSize];
    }
}

- (NSString *)convertSize:(NSInteger)totalSize{
    
    // 1k = 1024, 1m = 1024k
    if (totalSize < 1024.f) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)totalSize];
    }else if (totalSize < 1024.f * 1024.f){// 小于1m
        CGFloat aFloat = totalSize/1024.f;
        return [NSString stringWithFormat:@"%.0fKB",aFloat];
    }else if (totalSize < 1024.f * 1024.f * 1024.f){// 小于1G
        CGFloat aFloat = totalSize/(1024.f * 1024.f);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = totalSize/(1024.f*1024.f*1024.f);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}
/**清除沙盒中的图片缓存*/
- (void)clearImageCacheInSandbox
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 列出图片缓存文件夹下的所有图片
    NSArray *imageArray = [mgr contentsOfDirectoryAtPath:kGetImageCachePathInShaHe(self.cacheImagePath) error:nil];
    NSLog(@"\n图片缓存的地址:\n%@",kGetImageCachePathInShaHe(self.cacheImagePath));
    if(imageArray.count>0)
    {
        for(NSString *fileName in imageArray)
        {
            NSString *fullPath = [kGetImageCachePathInShaHe(self.cacheImagePath) stringByAppendingPathComponent:fileName];
            BOOL exist = [mgr fileExistsAtPath:fullPath];
            if(exist)
            {
                // 删除图片
                [mgr removeItemAtPath:fullPath error:nil];
            }
        }
    }
}

+ (FLAnimatedImageView *)getGifImageWithData:(NSData *)data{
    
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.animatedImage = animatedImage;
    return  imageView;
}

+ (FLAnimatedImageView *)getGifImageWithNameInNSBundle:(NSString *)imgName{
    
    NSString *path = @"";
    NSString *pathExtension = [imgName pathExtension];
    if ([[pathExtension lowercaseString] isEqualToString:@"gif"]) {
        path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
    }else if([pathExtension isEqualToString:@""] || pathExtension == nil){
        path = [[NSBundle mainBundle] pathForResource:imgName ofType:@"gif"];
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    return  [self getGifImageWithData:data];
}

+ (FLAnimatedImageView *)getGifImageWithUrlPath:(NSString *)urlPath{
    
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlPath]];
    return  imageView;
}

/**
 *  将图片转换成圆角图片
 *
 *  @param img 需要转换的图片
 *  @param size 需要转换的图片的尺寸
 *  @return 圆角图片
 */
+ (UIImage *)getImageForArc:(UIImage *)img size:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef cxtRef = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width * 0.5, size.height * 0.5) radius:size.height * 0.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CGContextAddPath(cxtRef, path.CGPath);
    CGContextClip(cxtRef);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *clipImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipImg;
}
/**
 *  将Base64转换成图片
 *
 *  @param string Base64类型的字符串
 */
+ (UIImage *)imageFromBase64String:(NSString *)string{
    if (string == nil) {
        return nil;
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

+ (UIImage *)getScreenCaptureImage{
    
    CGRect rect = [UIApplication sharedApplication].keyWindow.bounds;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 1.开启图片的图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    
    // 2. 将window上的内容画到图形上下文中
    [window drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    
    // 3.获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.关闭图形上下文
    UIGraphicsEndImageContext();
    return img;
}
///获取磨砂图片
+ (UIImage *)getFrostedImage:(UIImage *)image type:(ImageEffectsType)type{
    
    UIImage *effectsImage = image;
    switch (type) {
        case ImageEffectsTypeLight:
            effectsImage = [effectsImage applyLightEffect];
            break;
        case ImageEffectsTypeExtraLight:
            effectsImage = [effectsImage applyExtraLightEffect];
            break;
        case ImageEffectsTypeDark:
            effectsImage = [effectsImage applyDarkEffect];
            break;
        default:
            break;
    }
    return effectsImage;
}
///保存网络图片
- (void)saveImageInPhotoLibraryWithImageUrl:(NSString *)imageUrl completionHandler:(nullable void(^)(BOOL success, NSError *__nullable error,PHAsset *imageAsset))completionHandler{
    
    NSURL *url = [NSURL URLWithString: imageUrl];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    __weak typeof(self) weakSelf = self;
    [manager diskImageExistsForURL:url completion:^(BOOL isInCache) {
        UIImage *img;
        if (isInCache){
            img =  [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
        }else{
            //从网络下载图片
            NSData *data = [NSData dataWithContentsOfURL:url];
            img = [UIImage imageWithData:data];
        }
        //保存图片
        [weakSelf saveImageInPhotoLibraryWithImage:img completionHandler:completionHandler];
    }];
}
///保存图片
- (void)saveImageInPhotoLibraryWithImage:(UIImage *)image completionHandler:(nullable void(^)(BOOL success, NSError *__nullable error,PHAsset *imageAsset))completionHandler{
    if (image != nil) {
        
        NSMutableArray *imageIds = [NSMutableArray array];
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //写入图片到相册
            PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            //记录本地标识，等待完成后取到相册中的图片对象
            [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            NSLog(@"保存到相册时success = %d, error = %@", success, error);
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [QZZProgressHUD showError:@"保存失败"];
                });
                return;
            }
            if (success){
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [QZZProgressHUD showSuccess:@"已保存到系统相册"];
                });
                //成功后取相册中的图片对象
                __block PHAsset *imageAsset = nil;
                PHFetchResult *result = [PHAsset fetchAssetsWithLocalIdentifiers:imageIds options:nil];
                [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    imageAsset = obj;
                    *stop = YES;
                    completionHandler(success,error,imageAsset);
                }];
            }
        }];
    }
}
@end
