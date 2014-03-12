//
//  MainMenuTableViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 12/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarTableViewProtocol.h"
@class AboutViewController;

@interface MainMenuTableViewController : UITableViewController<CarTableViewProtocol>

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *menuImages;

@end
