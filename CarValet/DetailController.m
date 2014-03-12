//
//  DetailController.m
//  CarValet
//
//  Created by Hooman Ostovari on 12/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "DetailController.h"

@implementation DetailController
{
    UIBarButtonItem *menuPopoverButtonItem;
    UIPopoverController *menuPopoverController;
    UINavigationController *detailNavController;
    
}


#pragma mark - Singleton

+(DetailController*)sharedDetailController
{
    static DetailController *sharedDetailController = nil;               // 2
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{                                              // 3
        sharedDetailController = [super new];
    });
    
    return sharedDetailController;
    
}

#pragma mark – UISplitViewControllerDelegate

-(BOOL)splitViewController:(UISplitViewController *)svc
  shouldHideViewController:(UIViewController *)vc
             inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

-(void)splitViewController:(UISplitViewController *)svc
    willHideViewController:(UIViewController *)aViewController
         withBarButtonItem:(UIBarButtonItem *)barButtonItem
      forPopoverController:(UIPopoverController *)pc
{
    
    barButtonItem.title = @"Menu";                                          // 2
    
    menuPopoverButtonItem = barButtonItem;                                  // 3
    menuPopoverController = pc;
    
    UINavigationItem *detailNavItem =                                       // 4
    detailNavController.topViewController.navigationItem;
    detailNavItem.leftBarButtonItem = barButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc                    // 5
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    menuPopoverButtonItem = nil;                                            // 6
    menuPopoverController = nil;
    
    UINavigationItem *detailNavItem =                                       // 7
    detailNavController.topViewController.navigationItem;
    detailNavItem.leftBarButtonItem = nil;
    
}

- (void)setSplitViewController:(UISplitViewController *)splitViewController {
    if (splitViewController != _splitViewController) {                      // 1
        _splitViewController = splitViewController;                         // 2
        detailNavController =                                               // 3
        [splitViewController.viewControllers lastObject];
        _splitViewController.delegate = self;                               // 4
    }
}



@end
