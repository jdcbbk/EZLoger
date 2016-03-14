//
//  AppDelegate.m
//  Demo
//
//  Created by tobinchen on 16/3/14.
//  Copyright © 2016年 EZLoger. All rights reserved.
//

#import "AppDelegate.h"
#import "EZLoger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    EZLog_Debug(@"didFinishLaunchingWithOptions:%@%@",application,launchOptions);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    EZLog_Info(@"applicationWillResignActive:%@",application)
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    EZLog_Debug(@"applicationWillResignActive:%@",application)
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    EZLog_Info(@"applicationWillResignActive:%@",application)
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    EZLog_Warning(@"applicationWillResignActive:%@",application)
}

- (void)applicationWillTerminate:(UIApplication *)application {
    EZLog_Error(@"applicationWillTerminate:%@",application)
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
