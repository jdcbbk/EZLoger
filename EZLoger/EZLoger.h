//
//  EZLoger.h
//  EZLoger
//
//  Created by tobinchen on 16/3/14.
//  Copyright © 2016年 tobinchen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    EZ_LOG_DEBUG = 0,
    EZ_LOG_INFO = 1,
    EZ_LOG_WARNING = 2,
    EZ_LOG_ERROR = 3,
} EZLogLevel;

@interface EZLoger : NSObject

@property(nonatomic,assign) EZLogLevel logLevel;

+ (EZLoger*)loger;
- (void)log:(EZLogLevel)level format:(NSString *)format ,...NS_FORMAT_FUNCTION(2,3);
@end


#define EZLog_Debug(fmt, ...) do{ [[EZLoger loger] log:EZ_LOG_DEBUG format:fmt, ## __VA_ARGS__]; }while(0);
#define EZLog_Info(fmt, ...) do{ [[EZLoger loger] log:EZ_LOG_INFO format:fmt, ## __VA_ARGS__]; }while(0);
#define EZLog_Warning(fmt, ...) do{ [[EZLoger loger] log:EZ_LOG_WARNING format:fmt, ## __VA_ARGS__]; }while(0);
#define EZLog_Error(fmt, ...) do{ [[EZLoger loger] log:EZ_LOG_ERROR format:fmt, ## __VA_ARGS__]; }while(0);