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
        self.year = year;
        self.fuelAmount = fuelAmount;
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
    NSLog(@"---Car was Built in %d", _year);
    NSLog(@"---Car  fuel level is at %0.2f", self.fuelAmount);
}

- (NSString*) carInfo {
    NSString *makeLabel = NSLocalizedStringWithDefaultValue(@"CarMakeLabel", nil, [NSBundle mainBundle], @"Make", @"Make label for the model of the car");
    NSString *modelLabel = NSLocalizedStringWithDefaultValue(@"CarModelLabel", nil, [NSBundle mainBundle], @"Model", @"Model label for the car model");
    NSString *yearLabel = NSLocalizedStringWithDefaultValue(@"CarYearLabel", nil, [NSBundle mainBundle], @"Year", @"Year label of the car");
    NSString *fuelLabel = NSLocalizedStringWithDefaultValue(@"CarFuelLabel", nil, [NSBundle mainBundle], @"Fuel Amount", @"Fuel label for the fuel of the car");
    NSString *unknownModel = NSLocalizedStringWithDefaultValue(@"UnknownModel", nil, [NSBundle mainBundle], @"Unknown Model", @"Place holder for when the car model is empty");
      NSString *unknownMake = NSLocalizedStringWithDefaultValue(@"UnknownMake", nil, [NSBundle mainBundle], @"Unknown Make", @"Place holder for when the make is empty");
    
    
    return [NSString stringWithFormat:
            @"%@: %@\n%@: %@\n%@: %d\n%@: %f\n",
            makeLabel,self.make ? self.make : unknownMake,
            modelLabel,self.model ? self.model : unknownModel,
            yearLabel,self.year,
            fuelLabel,self.fuelAmount];
}

-(void) shoutMake {
    self.make = [_make uppercaseString];
}
@end
