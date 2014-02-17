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
#import "CarEditViewController.h"


@interface ViewController ()

@end

@implementation ViewController {
    NSMutableArray *arrayOfCars;
    NSInteger displayedCarIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    arrayOfCars = [[NSMutableArray alloc] init];
    displayedCarIndex = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeDisplayedCar:displayedCarIndex];
}

- (void) changeDisplayedCar : (NSInteger) displayCarIndex {
    if (displayCarIndex < 0) {
        displayCarIndex = 0;
    } else if (displayCarIndex >= [arrayOfCars count]) {
        displayCarIndex = [arrayOfCars count] - 1;
    }
    displayedCarIndex = displayCarIndex;
    self.prevCarButton.enabled = displayedCarIndex > 0;
    self.nextCarButton.enabled = displayedCarIndex < [arrayOfCars count] -1;
    [self displayCarInformation];
    
}

- (void) updateLabel :(UILabel *) label : (NSString*) withBaseString : (NSInteger) count {
    NSString* newText = [NSString stringWithFormat:@"%@: %d",withBaseString,count];
    label.text = newText;
}

- (void) displayCarInformation {
    if ([arrayOfCars count] == 0) {
        self.numberCarLabel.text = [NSString stringWithFormat:@"No Cars"];
        self.carInfoLabel.text = nil;
    } else {        
        Car *currentCar = [arrayOfCars objectAtIndex:displayedCarIndex];
        self.numberCarLabel.text = [NSString stringWithFormat:@"Car Number: %d",displayedCarIndex];
        [self updateLabel:self.numberCarLabel :@"Car number" :displayedCarIndex + 1];
        self.carInfoLabel.text = [currentCar carInfo];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Segue %@",segue.identifier);
    if ([segue.identifier isEqualToString:@"EditSegue"]) {
        CarEditViewController* nextController;
        nextController = segue.destinationViewController;
        nextController.delegate = self;
    }
}

- (IBAction)newCar:(id)sender {
    Car* newCar = [[Car alloc] init];
    [arrayOfCars addObject:newCar];
    [self updateLabel:self.totalCarLabel :@"Total Cars" :[arrayOfCars count]];
    [self changeDisplayedCar:[arrayOfCars count] - 1];
}

- (IBAction)nextCar:(id)sender {
    [self changeDisplayedCar:displayedCarIndex + 1];
}

- (IBAction)prevCar:(id)sender {
    [self changeDisplayedCar:displayedCarIndex - 1];
}

- (void)editedCarUpdated
{
    [self displayCarInformation];
    NSLog(@"Edited car updated called\n");
}

- (Car *)carToEdit
{
    return arrayOfCars[displayedCarIndex];
}

- (NSInteger)carNumber
{
    return displayedCarIndex + 1;
}

- (IBAction)editingDone:(UIStoryboardSegue*)segue
{
    NSLog(@"editingDone called \n");
    [self displayCarInformation];
}


@end
