//
//  CarEditViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 08/02/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Car;

@interface CarEditViewController : UIViewController

@property (nonatomic) NSInteger carNumber;
@property (strong, nonatomic) Car* currentCar;

@property (weak, nonatomic) IBOutlet UITextField *makeTextField;
@property (weak, nonatomic) IBOutlet UITextField *modelTextField;
@property (weak, nonatomic) IBOutlet UITextField *fuelAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;

@end
