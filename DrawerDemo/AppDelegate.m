//
//  AppDelegate.m
//  DrawerDemo
//
//  Created by xalo on 16/1/30.
//  Copyright © 2016年 岳朝逢. All rights reserved.
//

#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 先创建出window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    [self.window makeKeyAndVisible];
    // 抽屉视图控制器
    DrawerViewController *drawerVC = [[DrawerViewController alloc] init];
    self.window.rootViewController = drawerVC;
    // 抽屉下的第一个控制器
    ViewController1 *VC1 = [[ViewController1 alloc] init];
    // 设置是否需要导航条
//    [drawerVC setRootVC:VC1 isNeedNavi:YES];
    
    ViewController2 *VC2 = [[ViewController2 alloc] init];
    ViewController3 *VC3 = [[ViewController3 alloc] init];
    
    drawerVC.menuList = @[@"vc1",@"vc2",@"vc3"];
    
    drawerVC.menuListVC = @[VC1, VC2, VC3];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
