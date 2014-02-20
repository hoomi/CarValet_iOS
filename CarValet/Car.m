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
    return [NSString stringWithFormat:
            @"Name: %@\nModel: %@\nYear: %d\nFuel Amount: %f\n",
            self.make ? self.make : @"Unknown make",
            self.model ? self.model : @"Unknown model",
            self.year,
            self.fuelAmount];
}

-(void) shoutMake {
    self.make = [_make uppercaseString];
}
@end
