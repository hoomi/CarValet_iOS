//
//  CarTableViewProtocol.h
//  CarValet
//
//  Created by Hooman Ostovari on 12/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CDCar;

@protocol CarTableViewProtocol <NSObject>

-(void) selectCar:(CDCar*) selectedCar;

@optional
- (void) editMode:(BOOL) isEdit;

@end
