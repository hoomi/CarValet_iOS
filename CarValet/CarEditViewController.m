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
     NSString *localizedString = NSLocalizedStringWithDefaultValue(@"CarNumberLabel",nil,[NSBundle mainBundle],@"Car Number",@"Label for the index number of the current car");
    self.carNumberLabel.text = [NSString stringWithFormat:@"%@: %d",localizedString,self.carNumber];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self localizeUI];
    self.makeTextField.text = self.currentCar.make;
    self.modelTextField.text = self.currentCar.model;
    self.yearTextField.text = [NSString stringWithFormat:@"%d",self.currentCar.year];
    self.fuelAmountTextField.text = [NSString stringWithFormat:@"%0.2f",self.currentCar.fuelAmount];
    self.title = NSLocalizedStringWithDefaultValue(@"EditScreenTitle", nil, [NSBundle mainBundle], @"Edit Car", @"Title for the edit Screen");
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

- (void) localizeUI
{
    NSString *localizedString = NSLocalizedStringWithDefaultValue(@"CarMakeLabel", nil, [NSBundle mainBundle], @"Make", @"Make label for the model of the car");
    [self.makeLabel setText:localizedString];
    [self.makeTextField setPlaceholder:localizedString];
    localizedString = NSLocalizedStringWithDefaultValue(@"CarModelLabel", nil, [NSBundle mainBundle], @"Model", @"Model label for the car model");
    [self.modelLabel setText:localizedString];
    [self.modelTextField setPlaceholder:localizedString];
    localizedString = NSLocalizedStringWithDefaultValue(@"CarYearLabel", nil, [NSBundle mainBundle], @"Year", @"Year label of the car");
    [self.yearLabel setText:localizedString];
    [self.yearTextField setPlaceholder:localizedString];
    localizedString= NSLocalizedStringWithDefaultValue(@"CarFuelLabel", nil, [NSBundle mainBundle], @"Fuel Amount", @"Fuel label for the fuel of the car");
    [self.fuelLabel setText:localizedString];
    [self.fuelAmountTextField setPlaceholder:localizedString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
