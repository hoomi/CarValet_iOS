//
//  CarTableViewCell.h
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Car;

@interface CarTableViewCell : UITableViewCell

@property (strong,nonatomic) Car *displayedCar;


-  (void) configureCell;


@end
