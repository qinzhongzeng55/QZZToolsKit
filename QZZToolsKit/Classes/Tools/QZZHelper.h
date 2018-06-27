//
//  QZZHelper.h
//
//
//  Created by qinzhongzeng on 2017/10/3.
//  Copyright © 2017年 Triangle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZZHelper : NSObject


/**
 将传递进来的参数拼接成url

 @param baseUrl 基础地址
 @param params  参数列表
 @return 完整url
 */
+ (NSString *)connectBaseUrl:(NSString *)baseUrl params:(NSMutableDictionary *)params;

@end
