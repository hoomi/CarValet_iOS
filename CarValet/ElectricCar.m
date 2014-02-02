//
//  ElectricCar.m
//  CarValet
//
//  Created by Hooman Ostovari on 15/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "ElectricCar.h"

@implementation ElectricCar

- (id) init
{
    self = [super init];
    if (self != nil) {
        _numberOfBatteries = 0;
    }
    return self;
}

- (id) initWithMake:(NSString *)make model:(NSString *)model year:(int)year fuelAmount:(float)fuelAmount numberOfBatteries:(int)numberOfBatteries {
    self = [super initWithMake:make model:model year:year fuelAmount:fuelAmount];
    if (self != nil) {
        _numberOfBatteries = numberOfBatteries;
    }
    return self;
}

- (void) printCarInfo {
    NSLog(@"Make ---- Model ---- Year ---- Battery Level ----- Batteries");
    NSLog(@"%@ ----- %@ ----- %d ----- %0.2f ----- %d", self.make, self.model,self.year, self.fuelAmount, self.numberOfBatteries);
}
@end
