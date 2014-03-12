//
//  CarDetailsViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 12/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "CarDetailsViewController.h"
#import "CDCar.h"


@interface CarDetailsViewController ()

@end

@implementation CarDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton= YES;
    self.fuelPicker.dataSource = self;
    self.fuelPicker.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self saveCar];
}

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {    // 1
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {                 // 2
    if (component == 3) {
        return 1;                                                           // 3
    }
    
    return 10;                                                              // 4
}

#pragma mark - UIPickerView Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {                             // 5
    
    if (component == 3) {
        return @".";                                                        // 6
    }
    
    return [NSString stringWithFormat:@"%ld", row];                          // 7
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark – Utility Methods

- (float) getFuelValue {
    float fuel = 0.0;
    
    fuel = [self.fuelPicker selectedRowInComponent:kFuelPickerHundreds]
    * 100.0;
    fuel += [self.fuelPicker selectedRowInComponent:kFuelPickerTens]
    * 10.0;
    fuel += [self.fuelPicker selectedRowInComponent:kFuelPickerOnes]
    * 1.0;
    fuel += [self.fuelPicker selectedRowInComponent:kFuelPickerTenths]
    * 0.1;
    
    return fuel;
}

- (void)setFuelValues {
    float fuel = [self.displayedCar.fuel floatValue];                        // 1
    
    NSInteger currentValue;
    
    currentValue = (NSInteger)floor(fuel / 100);                            // 2
    [self.fuelPicker selectRow:currentValue                                 // 3
                   inComponent:kFuelPickerHundreds
                      animated:YES];
    fuel -= (currentValue * 100);                                           // 4
    
    currentValue = (NSInteger)floor(fuel / 10);                             // 5
    [self.fuelPicker selectRow:currentValue
                   inComponent:kFuelPickerTens
                      animated:YES];
    fuel -= (currentValue * 10);
    
    
    currentValue = (NSInteger)floor(fuel);
    [self.fuelPicker selectRow:currentValue
                   inComponent:kFuelPickerOnes
                      animated:YES];
    fuel -= currentValue;
    
    fuel *= 10;                                                             // 6
    currentValue = (NSInteger)floor(fuel);
    [self.fuelPicker selectRow:currentValue
                   inComponent:kFuelPickerTenths
                      animated:YES];
}

- (void) saveCar {
    if (_displayedCar == nil) {
        return;
    }
    self.displayedCar.make = self.carMakeField.text;
    self.displayedCar.model = self.carModelField.text;
    self.displayedCar.year = @([self.carYearField.text floatValue]);
    
    self.displayedCar.fuel = @([self getFuelValue]);
}
#pragma mark - Setters

- (void)setDisplayedCar:(CDCar *)displayedCar {
    if (displayedCar != _displayedCar) {
        
        [self saveCar];
    }
    _displayedCar = displayedCar;                                                     // 2
    
    self.carMakeField.text = _displayedCar.make;                               // 3
    self.carModelField.text = _displayedCar.model;
    self.carYearField.text = [_displayedCar.year stringValue];
    
    self.dayParkedLabel.text = [NSDateFormatter                         // 4
                                localizedStringFromDate:_displayedCar.createdAt
                                dateStyle:NSDateFormatterMediumStyle
                                timeStyle:NSDateFormatterNoStyle];
    
    self.timeParkedLabel.text = [NSDateFormatter
                                 localizedStringFromDate:_displayedCar.createdAt
                                 dateStyle:NSDateFormatterNoStyle
                                 timeStyle:NSDateFormatterMediumStyle];
    
    [self setFuelValues];                                               // 5
}


@end
