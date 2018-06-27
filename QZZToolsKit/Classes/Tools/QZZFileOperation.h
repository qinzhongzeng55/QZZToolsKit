//
//  QZZFileOperation.h
//  
//
//  Created by qinzhongzeng on 2017/5/19.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//  文件操作

#import <Foundation/Foundation.h>

@interface QZZFileOperation : NSObject

///document根文件夹
+ (NSString *)documentFolder;

///caches根文件夹
+ (NSString *)cachesFolder;

/**
 *  生成文件夹
 *  如果文件夹不存在，则直接创建；如果已经存在，则直接返回
 *  @param filePath 文件夹路径
 */
+ (void)createDirectory:(NSString *)filePath;

/**
 * 获取该目录中所有的文件
 * @param type 获得文件的后缀名（不带'.'） 
 */
+ (NSArray *)getAllFileWithDirectoryPath:(NSString *)filePath fileType:(NSString *)type;

@end
