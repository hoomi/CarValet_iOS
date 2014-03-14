//
//  CarDetailsViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 12/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDCar;


@interface CarDetailsViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) UIViewController *delegate;
@property (weak, nonatomic) IBOutlet UITextField *carYearField;
@property (weak, nonatomic) IBOutlet UITextField *carModelField;
@property (weak, nonatomic) IBOutlet UITextField *carMakeField;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UIPickerView *fuelPicker;
@property (weak, nonatomic) IBOutlet UILabel *dayParkedLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeParkedLabel;

@property (weak,nonatomic) CDCar* displayedCar;

@property (copy, nonatomic) void (^nextOrPreviousCar)(BOOL isNext);

@end
