//
//  CarEditViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 08/02/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "CarEditViewController.h"
#import "Car.h"

@interface CarEditViewController ()

@end

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
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.carNumberLabel.text = [NSString stringWithFormat:@"Car Number: %d",self.carNumber];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.makeTextField.text = self.currentCar.make;
    self.modelTextField.text = self.currentCar.model;
    self.yearTextField.text = [NSString stringWithFormat:@"%d",self.currentCar.year];
    self.fuelAmountTextField.text = [NSString stringWithFormat:@"%0.2f",self.currentCar.fuelAmount];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditDoneSegue"]) {
        [self updateCurrentCar];
    }
}

- (void) updateCurrentCar {
    self.currentCar.make = self.makeTextField.text;
    self.currentCar.model = self.modelTextField.text;
    self.currentCar.year = [self.yearTextField.text integerValue];
    self.currentCar.fuelAmount = [self.fuelAmountTextField.text floatValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
