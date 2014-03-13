//
//  DetailController.m
//  CarValet
//
//  Created by Hooman Ostovari on 12/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
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

- (void) setCurrDetailController:(UIViewController *)currDetailController
{
    [self setCurrDetailController:currDetailController hidePopover:YES];
}

- (void)setCurrDetailController:(UIViewController *)currDetailController hidePopover:(BOOL)hidePopover
{
    
    NSArray *newStack = nil;                                                 // 1
    
    if (currDetailController == nil) {                                       // 2
        UINavigationController *rootController =                             // 3
        detailNavController.viewControllers[0];
        
        if (detailNavController.topViewController != rootController) {       // 4
            
            newStack = @[detailNavController.viewControllers[0]];            // 5
            
        }
    } else if (![currDetailController isMemberOfClass:                       // 6
                 [detailNavController.topViewController class]]) {
        
        newStack = @[detailNavController.viewControllers[0],                 // 7
                     currDetailController];
    }
    
    if (hidePopover) {
        [self hidePopover];                                                  // 8
    }
    
    if (newStack != nil) {
        CATransition *transition = [CATransition animation];
        transition.duration = 0.7f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromRight;
        [detailNavController.view.layer addAnimation:transition forKey:nil];
        [detailNavController setViewControllers:newStack animated:NO];      // 9
        
        _currDetailController = detailNavController.topViewController;      // 10
        _currDetailController.navigationItem.leftBarButtonItem = menuPopoverButtonItem;
    }
}

#pragma mark - Public Methods

- (void)hidePopover {
    [menuPopoverController dismissPopoverAnimated:YES];
}

@end
