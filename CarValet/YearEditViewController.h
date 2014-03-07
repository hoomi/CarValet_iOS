//
//  YearEditViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 07/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditYearProtocol.h"

@interface YearEditViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak,nonatomic) id <EditYearProtocol> delegate;
- (IBAction)editCancelled:(id)sender;
- (IBAction)editDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *editPicker;

@end
