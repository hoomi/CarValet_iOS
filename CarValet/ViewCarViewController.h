//
//  ViewCarViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MakeModelEditProtocol.h"
#import "EditYearProtocol.h"
#import "ViewCarProtocol.h"

@interface ViewCarViewController : UITableViewController <MakeModelEditProtocol,EditYearProtocol, UINavigationControllerDelegate>
@property (weak, nonatomic) id <ViewCarProtocol> delegate;
@property (weak, nonatomic) IBOutlet UILabel *makeLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuelLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextCarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevCarButton;
- (IBAction)prevCar:(id)sender;
- (IBAction)nextCar:(id)sender;

@end
