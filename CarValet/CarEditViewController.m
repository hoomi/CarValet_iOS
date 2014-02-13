//
//  CarEditViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 08/02/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "CarEditViewController.h"
#import "Car.h"


@implementation CarEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.currentCar.make = self.makeTextField.text;
    self.currentCar.model = self.modelTextField.text;
    self.currentCar.year = [self.yearTextField.text integerValue];
    self.currentCar.fuelAmount = [self.fuelAmountTextField.text floatValue];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* carNumberText = [NSString stringWithFormat:@"Car number: %d",self.carNumber];
    self.carNumberLabel.text = carNumberText;
    self.makeTextField.text = self.currentCar.make;
    self.modelTextField.text = self.currentCar.model;
    self.yearTextField.text = [NSString stringWithFormat:@"%d",self.currentCar.year];
    self.fuelAmountTextField.text = [NSString stringWithFormat:@"%0.2f",self.currentCar.fuelAmount];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
