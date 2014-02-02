//
//  HybridCar.m
//  CarValet
//
//  Created by Hooman Ostovari on 14/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "HybridCar.h"

@implementation HybridCar

-(id) init
{
    self = [super init];
    if (self != nil) {
        _mpg = 0.0f;
    }
    return self;
}

- (id) initWithMake:(NSString *)make model:(NSString *)model year:(int)year fuelAmount:(float)fuelAmount MPG:(float)MPG
{
    self = [super initWithMake:make model:model year:year fuelAmount:fuelAmount];
    if (self != nil) {
        _mpg = MPG;
    }
    return self;
}

- (void) printCarInfo {
    [super printCarInfo];
    NSLog(@"Car's MPG is %0.2f",_mpg);
    
    if (_mpg > 0.0f) {
        NSLog(@"Miles until it empties its tank %0.2f",[self milesUntilEmpty]);
    }
}

- (float) milesUntilEmpty
{
    BOOL showInLitres = self.isShowingLitres;
    if (showInLitres)
    {
        self.showLitres = NO;
        
    }
    float miles = self.fuelAmount * self.mpg;
    self.showLitres = showInLitres;
    return miles;
}

@end
