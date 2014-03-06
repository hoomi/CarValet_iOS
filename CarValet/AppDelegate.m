//
//  AppDelegate.m
//  CarValet
//
//  Created by Hooman Ostovari on 14/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "AppDelegate.h"
#import "AboutViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    UITabBarController *tabBarController = (UITabBarController*)self.window.rootViewController;
//    AboutViewController *aboutViewController = [[AboutViewController alloc]
//                                                initWithNibName:@"AboutViewController"
//                                                bundle:[NSBundle mainBundle]];
//    NSString *localizedAbout = NSLocalizedStringWithDefaultValue(@"About", nil, [NSBundle mainBundle], @"About", @"About tab title");
//    UITabBarItem *aboutTabItem = [[UITabBarItem alloc] initWithTitle:localizedAbout image:[UIImage imageNamed:@"info"] tag:0];
//    [aboutViewController setTabBarItem:aboutTabItem];
//    NSMutableArray *currentItems = [NSMutableArray arrayWithArray:tabBarController.viewControllers];
//    [currentItems addObject:aboutViewController];
//    [tabBarController setViewControllers:currentItems animated:NO];
    UIColor *mocha = [UIColor colorWithRed:128.0/255.0 green:64.0/255.0         // 1
                                      blue:0.0 alpha:1.0];
    UIColor *mochaPressed = [UIColor colorWithRed:128.0/255.0 green:64.0/255.0         // 1
                                      blue:1.0 alpha:1.0];
    [[UIButton appearance] setTitleColor:mocha forState:UIControlStateNormal];
    [[UIButton appearance] setTitleColor:mochaPressed forState:UIControlStateSelected];
    [[UIBarButtonItem appearance] setTintColor:mocha];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    UITabBarController *tabController = (UITabBarController*)self.window.rootViewController;
    // Get the last viewed scene (0 if there was none)
    NSInteger lastScene = [defaults integerForKey:@"LastSceneShown"] ;
    tabController.selectedIndex = lastScene;
    
     NSLog(@"didFinishLaunchingWithOptions --> The tab index was: %d",  lastScene);

    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UITabBarController *tabBarController = (UITabBarController*)self.window.rootViewController;
    
    // get the standard user defaults for this app
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // set the preference for current scene
    // (assumes currSceneType is set elsewhere to the id for the scene)
    [defaults setInteger:tabBarController.selectedIndex forKey:@"LastSceneShown"];
    
    // make sure to synchronize so the defaults are saved
    [defaults synchronize];
    
    NSLog(@"applicationDidEnterBackground --> The tab index was: %d",  tabBarController.selectedIndex);

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
   }

@end
