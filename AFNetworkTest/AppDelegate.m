//
//  AppDelegate.m
//  AFNetworkTest
//
//  Created by 23 on 1/7/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "AppDelegate.h"

#import "ProductCollectionViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic)  UICollectionViewController* productCollectionViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.productCollectionViewController = [[ProductCollectionViewController alloc] initWithNibName:@"ProductCollectionViewController" bundle:nil];
    self.window.rootViewController = self.productCollectionViewController;
    [self.window makeKeyAndVisible];
    return YES;
}





@end
