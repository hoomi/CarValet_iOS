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
@class CDCar;
@interface ViewCarViewController : UITableViewController <MakeModelEditProtocol,EditYearProtocol, UINavigationControllerDelegate>
@property (weak, nonatomic) UIViewController *delegate;
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

@property (copy,nonatomic) CDCar* (^carToView)(void);
@property (copy,nonatomic) void (^carViewDone)(BOOL dataChanged);
@property (copy,nonatomic) void (^nextOrPreviousCar) (BOOL isNext);

@end
