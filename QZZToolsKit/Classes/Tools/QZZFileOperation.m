//
//  QZZFileOperation.m
//
//
//  Created by qinzhongzeng on 2017/5/19.
//  Copyright © 2017年 bejingyimeng. All rights reserved.
//

#import "QZZFileOperation.h"

@implementation QZZFileOperation
/*
 *  document根文件夹
 */
+ (NSString *)documentFolder{
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

/*
 *  caches根文件夹
 */
+ (NSString *)cachesFolder{
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
/**
 *  生成文件夹
 *
 *  如果文件夹不存在，则直接创建；如果已经存在，则直接返回
 *
 *  @param filePath 文件夹路径
 */
+ (void)createDirectory:(NSString *)filePath{
    
    BOOL isDir = NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL existed = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    
    NSError *createFileError = nil;
    
    if (!(isDir == YES && existed == YES)){
        
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&createFileError];
        if (createFileError) {
            NSLog(@"创建文件夹失败: %@",createFileError);
        }
    }
}

///获取该目录中所有的文件
+ (NSArray *)getAllFileWithDirectoryPath:(NSString *)filePath fileType:(NSString *)type{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL isHave = [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
    NSError *fileError = nil;
    if (isHave && isDirectory) {
        
        NSArray *subPaths = [fileManager subpathsOfDirectoryAtPath:filePath error:&fileError];
        if (fileError) {
            NSLog(@"获取该目录中所有的文件失败原因--->\n%@",fileError);
            return nil;
        }
        if(subPaths.count > 0){
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSString *fileName in subPaths) {
                
                if ([[fileName pathExtension] isEqualToString:type]) {
                    
                    [tempArray addObject:fileName];
                }
            }
            return tempArray;
        }
    }
    return nil;
}
@end
