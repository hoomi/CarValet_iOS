//
//  Car.m
//  CarValet
//
//  Created by Hooman Ostovari on 14/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "Car.h"

@implementation Car

- (id)initWithMake:(NSString *)make model:(NSString *)model year:(int)year fuelAmount:(float)fuelAmount
{
    self = [super init];
    if (self != nil)
    {
        self.model = [model copy];
        self.make = [make copy];
        self.year = kModelTYear;
        self.fuelAmount = fuelAmount;
        self.dateCreated = [NSDate date];
    }
    return self;
}

- (id) init
{
    return [self initWithMake:nil model:nil year:1900 fuelAmount:0.0f];
}

- (float) fuelAmount
{
    if (self.isShowingLitres) {
        return _fuelAmount * 3.7854;
    }
    return _fuelAmount;
}

- (void) printCarInfo
{
    if (!_make || !_model)
    {
        NSString * message;
        if (!_make && !_model) {
            message = @"Make and model cannot be empty";
        } else {
            message = !_make ? @"Make was not defined" : @"Model was not defined";
        }
        NSLog(@"%@",message);
        return;
    }
    NSLog(@"---Car Make: %@",_make);
    NSLog(@"---Car Model: %@", _model);
    NSLog(@"---Car was Built in %ld", (long)_year);
    NSLog(@"---Car  fuel level is at %0.2f", self.fuelAmount);
}

- (NSString*) carInfo {
    NSString *makeLabel = NSLocalizedStringWithDefaultValue(@"CarMakeLabel", @"CarTable", [NSBundle mainBundle], @"Make", @"Make label for the model of the car");
    NSString *modelLabel = NSLocalizedStringWithDefaultValue(@"CarModelLabel", @"CarTable", [NSBundle mainBundle], @"Model", @"Model label for the car model");
    NSString *yearLabel = NSLocalizedStringWithDefaultValue(@"CarYearLabel", @"CarTable", [NSBundle mainBundle], @"Year", @"Year label of the car");
    NSString *fuelLabel = NSLocalizedStringWithDefaultValue(@"CarFuelLabel", @"CarTable", [NSBundle mainBundle], @"Fuel Amount", @"Fuel label for the fuel of the car");
    NSString *unknownModel = NSLocalizedStringWithDefaultValue(@"UnknownModel", @"CarTable", [NSBundle mainBundle], @"Unknown Model", @"Place holder for when the car model is empty");
    NSString *unknownMake = NSLocalizedStringWithDefaultValue(@"UnknownMake", @"CarTable", [NSBundle mainBundle], @"Unknown Make", @"Place holder for when the make is empty");
    NSString *carInfoString = [NSString stringWithFormat:
                               @"%@: %@\n%@: %@\n%@: %@\n%@: %@\n",
                               makeLabel,self.make ? self.make : unknownMake,
                               modelLabel,self.model ? self.model : unknownModel,
                               yearLabel,[Utils localizeDateWithYear:self.year],
                               fuelLabel,[Utils localizeDouble:self.fuelAmount]];
    NSLog(@"%@",carInfoString);
    return carInfoString;
}

-(void) shoutMake {
    self.make = [_make uppercaseString];
}
@end
