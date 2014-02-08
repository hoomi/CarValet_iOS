//
//  ViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 14/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *carInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberCarLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCarLabel;
- (IBAction)newCar:(id)sender;
- (IBAction)nextCar:(id)sender;
- (IBAction)prevCar:(id)sender;

@end
