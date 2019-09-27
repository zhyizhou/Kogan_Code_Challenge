//
//  AppDelegate.m
//  Coding Challenge
//
//  Created by Zhang Joey on 26/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import "AppDelegate.h"
#import "CubicWeightViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - App lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupWindow];

    return YES;
}

#pragma mark - Setup
- (void)setupWindow {
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    CubicWeightViewController *rootViewController = [[CubicWeightViewController alloc] init];
    [self.window setRootViewController:rootViewController];
}


@end
