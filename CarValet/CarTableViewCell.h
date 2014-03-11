//
//  CarTableViewCell.h
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDCar;

@interface CarTableViewCell : UITableViewCell

@property (strong,nonatomic) CDCar *displayedCar;
@property (weak, nonatomic) IBOutlet UIImageView *carImage;
@property (weak, nonatomic) IBOutlet UILabel *makeModelLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateCreatedLabel;


-  (void) configureCell;


@end
