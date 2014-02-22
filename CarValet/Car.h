//
//  Car.h
//  CarValet
//
//  Created by Hooman Ostovari on 14/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
    @property (readonly) BOOL isALemon;
    @property (readonly) NSString *carInfo;
    @property NSString* make;
    @property NSString* model;
    @property NSInteger year;
    @property (setter = setTheFuelAmountTo:,nonatomic)float fuelAmount;
    @property (getter = isShowingLitres) BOOL showLitres;


- (id)initWithMake:(NSString *)make
            model:(NSString *)model
             year:(int)year
       fuelAmount:(float)fuelAmount;
- (void) printCarInfo;
- (void) shoutMake;

@end
