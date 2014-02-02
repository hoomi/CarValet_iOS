//
//  ElectricCar.h
//  CarValet
//
//  Created by Hooman Ostovari on 15/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

@interface ElectricCar : Car

@property (nonatomic) int numberOfBatteries;

- (id) init;
- (id) initWithMake:(NSString *)make model:(NSString *)model year:(int)year fuelAmount:(float)fuelAmount numberOfBatteries:(int) numberOfBatteries;


@end
