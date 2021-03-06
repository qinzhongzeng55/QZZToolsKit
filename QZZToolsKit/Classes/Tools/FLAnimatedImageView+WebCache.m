/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "FLAnimatedImageView+WebCache.h"

#if SD_UIKIT
#import "objc/runtime.h"
#import <SDWebImage/UIView+WebCacheOperation.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/NSData+ImageContentType.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation FLAnimatedImageView (WebCache)

- (void)sd_setImageWithURL:(nullable NSURL *)url {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder options:(SDWebImageOptions)options completed:(nullable SDExternalCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)sd_setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                   options:(SDWebImageOptions)options
                   context:(nullable SDWebImageContext *)context
                  progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                 completed:(nullable SDInternalCompletionBlock)completedBlock {
    __weak typeof(self)weakSelf = self;
    [self sd_internalSetImageWithURL:url placeholderImage:placeholder options:options context:context setImageBlock:^(UIImage * _Nullable image, NSData * _Nullable imageData, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:imageData];
        if (imageFormat == SDImageFormatGIF) {
            weakSelf.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
            weakSelf.image = nil;
        } else {
            weakSelf.image = image;
            weakSelf.animatedImage = nil;
        }
    } progress:progressBlock completed:completedBlock];
}

@end

#endif
