//
//  HybridCar.h
//  CarValet
//
//  Created by Hooman Ostovari on 14/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

@interface HybridCar : Car

@property (nonatomic) float mpg;

- (id) initWithMake:(NSString *)make model:(NSString *)model year:(int)year fuelAmount:(float)fuelAmount MPG:(float)MPG;
- (float) milesUntilEmpty;


@end
