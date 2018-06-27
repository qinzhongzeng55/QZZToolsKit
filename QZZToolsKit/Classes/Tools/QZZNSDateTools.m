//
//  QZZNSDateTools.m
//  
//
//  Created by qinzhongzeng on 16/7/25.
//  Copyright © 2016年 qinzhongzeng. All rights reserved.
//

#import "QZZNSDateTools.h"

@interface QZZNSDateTools ()

@end

@implementation QZZNSDateTools

static QZZNSDateTools *_dateTools = nil;

+ (instancetype)sharedDateTools{

    return [[self alloc] init];
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_dateTools == nil) {
            
            _dateTools = [super allocWithZone:zone];
            _dateTools.dateFormatter = [[NSDateFormatter alloc] init];
        }
    });
    return _dateTools;
}

- (id)copyWithZone:(NSZone *)zone{
    
    return self;
}

- (NSString *)getDateStringWithTimeFromDate:(NSDate *)inputDate{
    
    self.dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [self.dateFormatter stringFromDate:inputDate];
}

- (NSString *)getMaxDateStringWithDate:(NSDate *)timeDate WithBeforeDate:(NSDate *)beforeTimeDate dateFormat:(NSString *)dateFormat{
    
    self.dateFormatter.dateFormat = dateFormat;
    NSString *timeStr = [self.dateFormatter stringFromDate:timeDate];
    NSString *beforeTimeStr = [self.dateFormatter stringFromDate:beforeTimeDate];
    NSInteger result = [self compareOneDay:timeStr withAnotherDay:beforeTimeStr dateFormat:dateFormat];
    //1 大于 -1 小于 0等于
    if (result == 1) {
        
        return timeStr;
    }else if(result == -1){
        return beforeTimeStr;
    }
    return timeStr;
}
- (NSString *)getDateStringWithTimeFromDate:(NSDate *)inputDate dateFormat:(NSString *)dateFormat{
    
    
    self.dateFormatter.dateFormat = dateFormat;
    return [self.dateFormatter stringFromDate:inputDate];
}

- (NSDate *)getDateFromDateString:(NSString *)inputDateString dateFormat:(NSString *)dateFormat{
    
    
    self.dateFormatter.dateFormat = dateFormat;
    return [self.dateFormatter dateFromString:inputDateString];
}
- (NSInteger)dayFromDate:(NSDate *)inputDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:inputDate];
    NSInteger iCurDay = [components day];  // 当前的号数
    return iCurDay;
}

- (NSInteger)monthFromDate:(NSDate *)inputDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:inputDate];
    NSInteger iCurMonth = [components month];  //当前的月份
    return iCurMonth;
}

- (NSInteger)yearFromDate:(NSDate *)inputDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:inputDate];
    NSInteger iCurYear = [components year];  //当前的年份
    return iCurYear;
}

- (NSString*)weekdayStringFromDate:(NSDate *)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

- (BOOL)runYearFromDate:(NSDate *)inputDate{
    
    NSInteger year = [self yearFromDate:inputDate];
    if (((year % 4 == 0)&&(year % 100 != 0))||(year % 400 == 0)) {//闰年
        return YES;
    } else {
        return NO;
    }
}
- (NSUInteger)numberOfDaysInMonth{

    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
   
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
   
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

- (NSUInteger)numberOfDaysInMonth:(NSDate *)inputDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:inputDate];
    
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

- (NSInteger)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay dateFormat:(NSString *)dateFormat{

    [self.dateFormatter setDateFormat:dateFormat];
    NSDate *dateA = [self.dateFormatter dateFromString:oneDay];
    NSDate *dateB = [self.dateFormatter dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        
        return 1;
    }
    else if (result == NSOrderedAscending){
        
        return -1;
    }else{
        return 0;
    }
}

- (NSInteger)getDaysdDifferenceOneDay:(NSString *)oneDay betweenWithAnotherDay:(NSString *)anotherDay{

    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateA = [self.dateFormatter dateFromString:oneDay];
    NSDate *dateB = [self.dateFormatter dateFromString:anotherDay];
    int timediff = [dateB timeIntervalSince1970]-[dateA timeIntervalSince1970];
    return timediff/60/60/24;
}
@end
