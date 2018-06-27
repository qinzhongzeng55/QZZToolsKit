//
//  QZZProgressHUD.m
//  
//
//  Created by 秦忠增 on 2018/4/18.
//  Copyright © 2018年 tiankairuixiang. All rights reserved.
//

#import "QZZProgressHUD.h"
#import "MBProgressHUD+MJ.h"

@implementation QZZProgressHUD

+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [MBProgressHUD showSuccess:success toView:view];
}

+ (void)showSuccess:(NSString *)success{
    [MBProgressHUD showSuccess:success];
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
    [MBProgressHUD showError:error toView:view];
}

+ (void)showError:(NSString *)error{
    [MBProgressHUD showError:error];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    [MBProgressHUD showMessage:message toView:view];
}

+ (void)showMessage:(NSString *)message{
    [MBProgressHUD showMessage:message toView:nil];
}

+ (void)showLoadingMessage:(NSString *)message{
    [self showLoadingMessage:message toView:nil];
}

+ (void)showLoadingMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.opacity = 0.65f;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = YES;
    [view addSubview:hud];
    [view bringSubviewToFront:hud];
}

+ (void)hideAllHUDsForView:(UIView *)view animated:(BOOL)animated{
    if (view == nil)
        view = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

+ (void)tishi:(NSString *)title toView:(UIView *)superView{
    CGFloat y = NAV_HEIGHT;
    __block UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((Screen_Width / 2 - 150), y+10, 300, 30)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 5;
    label.backgroundColor = [UIColor colorWithWhite:0/255.0 alpha:0.6];
    label.textColor = [UIColor whiteColor];
    if (superView == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:label];
    }else{
        [superView addSubview:label];
        [superView bringSubviewToFront:label];
    }
    [UIView animateWithDuration:0.5f animations:^{
        label.alpha = 0.9f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3.5f animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            label = nil;
        }];
    }];
}
@end
