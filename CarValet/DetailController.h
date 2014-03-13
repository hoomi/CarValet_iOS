//
//  DetailController.h
//  CarValet
//
//  Created by Hooman Ostovari on 12/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailController : NSObject<UISplitViewControllerDelegate>

@property (weak,nonatomic) UISplitViewController* splitViewController;
@property (weak,nonatomic) UIViewController* currDetailController;

+(DetailController*)sharedDetailController;

-(void)hidePopover;
-(void)setCurrDetailController:(UIViewController *)currDetailController hidePopover:(BOOL)hidePopover;

@end
