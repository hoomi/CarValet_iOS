//
//  CDCar.h
//  CarValet
//
//  Created by Hooman Ostovari on 08/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDCar : NSManagedObject

@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSNumber * fuel;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSDate * createdAt;

@end
