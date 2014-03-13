//
//  ViewCarProtocol.h
//  CarValet
//
//  Created by Hooman Ostovari on 07/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CDCar;

@protocol ViewCarProtocol <NSObject>

- (CDCar*) carToView;
- (void) carViewDone:(BOOL) dataUpdated;

@optional
- (void)nextOrPreviousCar:(BOOL)isNext;

@end
