//
//  AppDelegate.m
//  VKText1
//
//  Created by Alexey Storozhev on 04/12/15.
//  Copyright © 2015 Aleksey Storozhev. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[RootViewController alloc] initWithStyle:UITableViewStylePlain]];
    [window makeKeyAndVisible];
    self.window = window;
    return YES;
}

@end
