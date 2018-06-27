//
//  QZZProgressHUD.h
//  
//
//  Created by 秦忠增 on 2018/4/18.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZZProgressHUD : NSObject

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showLoadingMessage:(NSString *)message toView:(UIView *)view;

+ (void)showLoadingMessage:(NSString *)message;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showMessage:(NSString *)message;

+ (void)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated;
@end
