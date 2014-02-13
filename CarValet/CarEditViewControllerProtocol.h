//
//  CarEditViewControllerProtocol.h
//  CarValet
//
//  Created by Hooman Ostovari on 13/02/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Car;

@protocol CarEditViewControllerProtocol <NSObject>

- (Car*) carToEdit;
- (NSInteger) carNumber;
- (void) editedCarUpdated;

@end
