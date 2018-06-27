//
//  QZZNSDateTools.h
//  
//
//  Created by qinzhongzeng on 16/7/25.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QZZNSDateTools : NSObject

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

+ (instancetype)sharedDateTools;

/**
 *  根据NSDate获取带有时间的日期类型的NSString
 */
- (NSString *)getDateStringWithTimeFromDate:(NSDate *)inputDate;
/**
 *  比较两个时间
 */
- (NSString *)getMaxDateStringWithDate:(NSDate *)timeDate WithBeforeDate:(NSDate *)beforeTimeDate dateFormat:(NSString *)dateFormat;
/**
 *  根据NSDate和日期格式获取日期类型的NSString
 *
 *  @param inputDate  需要转换的日期
 *  @param dateFormat 日期格式
 */
- (NSString *)getDateStringWithTimeFromDate:(NSDate *)inputDate dateFormat:(NSString *)dateFormat;
/**
 *  根据date获取对应的星期
 *
 *  @param inputDate date
 */
- (NSString*)weekdayStringFromDate:(NSDate *)inputDate;
/**
 *  根据date获取是几号
 *
 *  @param inputDate date
 */
- (NSInteger)dayFromDate:(NSDate *)inputDate;
/**
 *  根据date获取是几月
 *
 *  @param inputDate date
 */
- (NSInteger)monthFromDate:(NSDate *)inputDate;
/**
 *  根据date获取是哪一年
 *
 *  @param inputDate date
 */
- (NSInteger)yearFromDate:(NSDate *)inputDate;
/**
 *  根据date获取是否是闰年
 *
 *  @param inputDate date
 */
- (BOOL)runYearFromDate:(NSDate *)inputDate;
/**
 *  当月最大的天数
 */
- (NSUInteger)numberOfDaysInMonth;
/**
 *  当前日期所在月份最大的天数
 *
 *  @param inputDate 当前日期
 */
- (NSUInteger)numberOfDaysInMonth:(NSDate *)inputDate;
/**
 *  根据字符串获取对应的NSDate
 *
 *  @param inputDateString 日期类型的字符串
 */
- (NSDate *)getDateFromDateString:(NSString *)inputDateString dateFormat:(NSString *)dateFormat;
/**
 *  比较两个时间 
 * 返回1 大于 -1 小于 0等于
 */
- (NSInteger)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay dateFormat:(NSString *)dateFormat;
/**
 *  获取两个日期之间相差的天数
 */
- (NSInteger)getDaysdDifferenceOneDay:(NSString *)oneDay betweenWithAnotherDay:(NSString *)anotherDay;
@end
