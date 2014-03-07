//
//  YearEditViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 07/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "YearEditViewController.h"
#import "Car.h"

@interface YearEditViewController ()

@end

@implementation YearEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSInteger currentYear = [self.delegate editValueYear];
    NSInteger rows = [self.editPicker numberOfRowsInComponent:0];
    NSInteger maxYear = rows + kModelTYear -1;
    NSInteger index = rows - (maxYear - currentYear) -1;
    [self.editPicker selectRow:index inComponent:0 animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger maxYear = [Utils getYearFromDate:[NSDate date]];
    maxYear += 1;
    return maxYear - kModelTYear + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d", kModelTYear + row];
}
- (IBAction)editCancelled:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Edit year cancelled");
    }];
}

- (IBAction)editDone:(id)sender {
    NSInteger selectedIndex = [self.editPicker selectedRowInComponent:0];
    [self.delegate editYearDone:kModelTYear + selectedIndex];
    [self dismissViewControllerAnimated:YES completion:^ {
        NSLog(@"Edit Year Done");
    }];
}
@end
