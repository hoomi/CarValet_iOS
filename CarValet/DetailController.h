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

+(DetailController*)sharedDetailController;

@end
