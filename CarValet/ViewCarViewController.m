//
//  ViewCarViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "ViewCarViewController.h"
#import "CarEditViewController.h"
#import "MakeModelEditViewController.h"
#import "Car.h"

#define kCurrentEditMake 0
#define kCurrentEditModel 1

@interface ViewCarViewController ()

@end

@implementation ViewCarViewController
{
    NSInteger currentEditType;
}

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
    UIColor *toolbarColor = [UIColor colorWithRed:102.0/255.0
                                            green:204.0/255.0
                                             blue:0.0/255.0
                                            alpha:1.0];
    self.navigationController.toolbar.barTintColor = toolbarColor;
    self.navigationController.toolbarHidden = NO;
    [self changeDisplayedCar:self.displayedCarIndex];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString:@"MakeEditSegue"] || [identifier isEqualToString:@"ModelEditSegue"]) {
        MakeModelEditViewController *nextController = segue.destinationViewController;
        nextController.delegate = self;
        currentEditType = [identifier isEqualToString:@"MakeEditSegue"] ? kCurrentEditMake : kCurrentEditModel;
    }
}

- (IBAction)editingDone:(UIStoryboardSegue*)segue
{
    NSLog(@"editingDone called \n");
    [self displayCarInformation];
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

- (NSString*) titleText
{
    switch (currentEditType) {
        case kCurrentEditModel:
            return @"Model";
        case kCurrentEditMake:
            return @"Make";
        default:
            return @"";
    }
}
- (NSString*) editLabelText
{
    switch (currentEditType) {
        case kCurrentEditModel:
            return @"Enter the Model:";
        case kCurrentEditMake:
            return @"Enter the Make:";
        default:
            return @"Enter:";
    }
}
- (NSString*) editFieldText
{
    Car *car = [self.arrayOfCars objectAtIndex:self.displayedCarIndex];
    return currentEditType == kCurrentEditModel ? car.model : car.make;
    
}
- (NSString*) editFieldPlaceholderText
{
    switch (currentEditType) {
        case kCurrentEditModel:
            return @"Car Model";
        case kCurrentEditMake:
            return @"Car Make";
        default:
            return @"...";
    }
}
- (void) editDone: (NSString*) textFieldValue
{
    if (IsEmptyString(textFieldValue)) {
        return;
    }
    Car *displayedCar = self.arrayOfCars[self.displayedCarIndex];
    switch (currentEditType) {
        case kCurrentEditMake:
            displayedCar.make = textFieldValue;
            self.makeLabel.text = textFieldValue;
            break;
        case kCurrentEditModel:
            displayedCar.model = textFieldValue;
            self.modelLabel.text = textFieldValue;
            break;
        default:
            break;
    }
    
}


@end
