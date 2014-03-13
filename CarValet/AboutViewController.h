//
//  AboutViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 05/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *taxiView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *taxiHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *taxiWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTaxiSpace;

@end
