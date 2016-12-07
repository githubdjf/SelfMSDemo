//
//  AppDelegate.m
//  SelfDemo
//
//  Created by Jaffer on 16/12/5.
//  Copyright © 2016年 51Nage. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *root = [[ViewController alloc] init];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:root];
    rootNav.view.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = rootNav;
    
    [_window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
