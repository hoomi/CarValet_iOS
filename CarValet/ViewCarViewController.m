//
//  ViewCarViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "ViewCarViewController.h"
#import "Car.h"

@interface ViewCarViewController ()

@end

@implementation ViewCarViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayCarInformation];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) changeDisplayedCar:(NSInteger) index
{
    NSInteger count = [self.arrayOfCars count];
    if (index >= count || index < 0) {
        return;
    }
    self.displayedCarIndex = index;
    
    NSLocaleLanguageDirection langDirection = [NSLocale characterDirectionForLanguage:[NSLocale preferredLanguages][0]];
    if (langDirection == NSLocaleLanguageDirectionLeftToRight) {
        self.prevCarButton.enabled = index > 0;
        self.nextCarButton.enabled = index < count -1;
    } else {
        self.prevCarButton.enabled = index < count -1;
        self.nextCarButton.enabled = index > 0;
    }
    self.editButton.enabled = count > 0;
    [self displayCarInformation];
    
}

- (void) displayCarInformation {
    
    Car * displayedCar = [self.arrayOfCars objectAtIndex:self.displayedCarIndex];
    self.makeLabel.text = (displayedCar.make == nil) ? @"Unknown" : displayedCar.make;
    
    self.modelLabel.text = (displayedCar.model == nil) ? @"Unknown" : displayedCar.model;
    
    self.yearLabel.text = [NSString stringWithFormat:@"%d", displayedCar.year];
    
    self.fuelLabel.text = [NSString stringWithFormat:@"%0.2f",displayedCar.fuelAmount];
    
    self.dateLabel.text = [NSDateFormatter
                           localizedStringFromDate:displayedCar.dateCreated
                           dateStyle:NSDateFormatterMediumStyle
                           timeStyle:NSDateFormatterNoStyle];
    
    self.timeLabel.text = [NSDateFormatter
                           localizedStringFromDate:displayedCar.dateCreated
                           dateStyle:NSDateFormatterNoStyle
                           timeStyle:NSDateFormatterMediumStyle];
}

- (IBAction)nextCar:(id)sender {
    NSInteger indexShift  = 1;
    if ([NSLocale characterDirectionForLanguage:[NSLocale preferredLanguages][0]] == NSLocaleLanguageDirectionRightToLeft) {
        indexShift = -1;
    }
    [self changeDisplayedCar:self.displayedCarIndex + indexShift];
}

- (IBAction)prevCar:(id)sender {
    NSInteger indexShift  = -1;
    if ([NSLocale characterDirectionForLanguage:[NSLocale preferredLanguages][0]] == NSLocaleLanguageDirectionRightToLeft) {
        indexShift = 1;
    }
    [self changeDisplayedCar:self.displayedCarIndex + indexShift];
}
@end
