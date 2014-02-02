//
//  ViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 14/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "ViewController.h"
#import "HybridCar.h"
#import "ElectricCar.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Car *car = [[Car alloc] initWithMake:@"bmw" model:@"M3" year:2013 fuelAmount:60.0f];
    [car printCarInfo];
    [car shoutMake];
    [car printCarInfo];
    car.make = @"VW";
    car.model = @"CC";
    car.year = 2013;
    [car setTheFuelAmountTo:23.0f];
    
    [car printCarInfo];
    car.showLitres = YES;
    [car printCarInfo];
    
    HybridCar *secondCar = [[HybridCar alloc] init];
    [secondCar printCarInfo];
    secondCar.mpg = 42.0f;
    [secondCar printCarInfo];
    HybridCar *thirdCar = [[HybridCar alloc] initWithMake:@"Toyota" model:@"Prius" year:2013 fuelAmount:8.3f MPG:42.0f];
    [thirdCar printCarInfo];
    ElectricCar *electricCar = [[ElectricCar alloc] initWithMake:@"BMW" model:@"i3" year:2014 fuelAmount:20.0f numberOfBatteries:3];
    [electricCar printCarInfo];
    self.totalCarLable.text = @"Total number of cars is: 999";
    
}

@end
