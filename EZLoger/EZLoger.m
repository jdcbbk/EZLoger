//
//  EZLoger.m
//  EZLoger
//
//  Created by tobinchen on 16/3/14.
//  Copyright © 2016年 tobinchen. All rights reserved.
//

#import "EZLoger.h"

@interface EZLoger(){
    dispatch_queue_t _logQueue;
}

@property (nonatomic,assign)int daysToDelLog;
@property (nonatomic,copy,readonly)NSString* logPath;
@end


@implementation EZLoger

+(EZLoger*)loger{
    static EZLoger* _inctance=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _inctance = [self new];
        [_inctance initLoger];
    });
    
    return _inctance;
}

-(void)initLoger{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *logDirectory       = [documentsDirectory stringByAppendingString:@"/log/"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:logDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:logDirectory
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];;
    NSString *fileNamePrefix = [dateFormatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"ez_log_%@.log", fileNamePrefix];
    _logPath = [logDirectory stringByAppendingPathComponent:fileName];
    
#if DEBUG
    NSLog(@"LogPath: %@", _logPath);
#endif

    if(![[NSFileManager defaultManager] fileExistsAtPath:_logPath])
        [[NSFileManager defaultManager] createFileAtPath:_logPath contents:nil attributes:nil];
    
    NSDate *prevDate = [[NSDate date] dateByAddingTimeInterval:-60*60*24*self.daysToDelLog];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:prevDate];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    NSDate *delDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSArray *logFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:logDirectory error:nil];
    for (NSString *file in logFiles)
    {
        NSString *fileName = [file stringByReplacingOccurrencesOfString:@".log" withString:@""];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"av_log_" withString:@""];
        NSDate *fileDate = [dateFormatter dateFromString:fileName];
        if (nil == fileDate)
        {
            continue;
        }
        if (NSOrderedAscending == [fileDate compare:delDate])
        {
            [[NSFileManager defaultManager] removeItemAtPath:[logDirectory stringByAppendingString:file] error:nil];
        }
    }
    
    _logQueue =  dispatch_queue_create("com.ez.log", DISPATCH_QUEUE_SERIAL);
    
#ifdef DEBUG
    _logLevel=EZ_LOG_DEBUG;
#else
    _logLevel=EZ_LOG_INFO;
#endif

}

+ (NSString*)levelName:(EZLogLevel)logLevel
{
    switch (logLevel)
    {
        case EZ_LOG_DEBUG: return @"DEBUG";
        case EZ_LOG_INFO: return @"INFO";
        case EZ_LOG_WARNING: return @"WARNING";
        case EZ_LOG_ERROR: return @"ERROR";
    }
    return @"NULL";
}

+ (NSDate *)logTime
{
    NSTimeZone *AA = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSInteger seconds = [AA secondsFromGMTForDate: [NSDate date]];
    return [NSDate dateWithTimeInterval: seconds sinceDate: [NSDate date]];
}

- (void)log:(EZLogLevel)level format:(NSString *)format vaList:(va_list)args
{
    
    NSString *contentStr = [[NSString alloc] initWithFormat:format arguments:args] ;
    
    dispatch_async(_logQueue, ^{
        
        if (level >= _logLevel)
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *content = [NSString stringWithFormat:@"%@ %@ %@\n", [dateFormatter stringFromDate:[EZLoger logTime]],[EZLoger levelName:level], contentStr];

            
            NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:_logPath];
            [file seekToEndOfFile];
            [file writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
            [file closeFile];
#ifdef DEBUG
            NSLog(@"%@", content);
#endif
            
        }
        
    });
    
}

- (void)log:(EZLogLevel)level format:(NSString *)format ,...{
    va_list args;
    
    if (format) {
        va_start(args, format);
        [self log:level format:format vaList:args];
        va_end(args);
    }
}
@end
