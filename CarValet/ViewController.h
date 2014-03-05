//
//  ViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 14/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *carInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberCarLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextCarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editCarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevCarButton;
@property (weak, nonatomic) IBOutlet UIButton *addCarButton;
@property (weak, nonatomic) IBOutlet UILabel *totalCarLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *aboutBarButton;
- (IBAction)aboutCareValet:(id)sender;
@property (strong,nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *addCarViewPortraitConstraints;
@property (strong,nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray * separatorViewPortraitConstraints;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rootViewPortraitConstraints;
- (IBAction)newCar:(id)sender;
- (IBAction)nextCar:(id)sender;
- (IBAction)prevCar:(id)sender;

@end
