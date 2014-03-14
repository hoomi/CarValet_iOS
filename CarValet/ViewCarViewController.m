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
#import "YearEditViewController.h"
#import "CDCar.h"
#import "AppDelegate.h"

#define kCurrentEditMake 0
#define kCurrentEditModel 1

@interface ViewCarViewController ()

@end

@implementation ViewCarViewController
{
    NSInteger currentEditType;
    CDCar* myCar;
    BOOL dataUpdated;
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
       dataUpdated = NO;
       UIColor *toolbarColor = [UIColor colorWithRed:102.0/255.0
                                            green:204.0/255.0
                                             blue:0.0/255.0
                                            alpha:1.0];
    self.navigationController.toolbar.barTintColor = toolbarColor;
    self.navigationController.toolbarHidden = NO;
    [self loadCarData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
        NSLog(@"viewControllerName: %@",[viewController nibName]);
    if (viewController == self.delegate) {
        if (dataUpdated) {
            self.carViewDone(dataUpdated);
        }
        navigationController.delegate = nil;
    }
}

- (void) displayCarInformation {
    
    self.makeLabel.text = myCar.make;
    
    self.modelLabel.text = myCar.model;
    
    self.yearLabel.text = [NSString stringWithFormat:@"%@", myCar.year];
    
    self.fuelLabel.text = [NSString stringWithFormat:@"%0.2f",[myCar.fuel floatValue]];
    
    self.dateLabel.text = [NSDateFormatter
                           localizedStringFromDate:myCar.createdAt
                           dateStyle:NSDateFormatterMediumStyle
                           timeStyle:NSDateFormatterNoStyle];
    
    self.timeLabel.text = [NSDateFormatter
                           localizedStringFromDate:myCar.createdAt
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
    } else if ([identifier isEqualToString:@"YearEditSegue"]) {
        YearEditViewController *yearEditController =segue.destinationViewController;
        yearEditController.delegate = self;
    }
}

- (void)loadCarData
{
    myCar = self.carToView();
    
    dataUpdated = NO;
    
    NSLog(@"Car make: %@",myCar.make);
    
    self.makeLabel.text = myCar.make;
    
    self.modelLabel.text = myCar.model;
    
    self.yearLabel.text = [NSString stringWithFormat:@"%@",
                           myCar.year];
    
    self.fuelLabel.text = [NSString stringWithFormat:@"%0.2f",
                           [myCar.fuel floatValue]];
    
    self.dateLabel.text = [NSDateFormatter
                           localizedStringFromDate:myCar.createdAt
                           dateStyle:NSDateFormatterMediumStyle
                           timeStyle:NSDateFormatterNoStyle];
    
    self.timeLabel.text = [NSDateFormatter
                           localizedStringFromDate:myCar.createdAt
                           dateStyle:NSDateFormatterNoStyle
                           timeStyle:NSDateFormatterMediumStyle];
}

#pragma mark - Next/Prev Car
- (void) nextOrPreviousCar:(BOOL) isNext {
    self.carViewDone(dataUpdated);
    
    self.nextOrPreviousCar(isNext);
    
    [self loadCarData];
}

- (IBAction)editingDone:(UIStoryboardSegue*)segue
{
    NSLog(@"editingDone called \n");
    [self displayCarInformation];
}

- (IBAction)nextCar:(id)sender {
    if ([NSLocale characterDirectionForLanguage:[NSLocale preferredLanguages][0]] == NSLocaleLanguageDirectionRightToLeft) {
       [self nextOrPreviousCar:NO];
    } else {
       [self nextOrPreviousCar:YES];
    }
}

- (IBAction)prevCar:(id)sender {

    if ([NSLocale characterDirectionForLanguage:[NSLocale preferredLanguages][0]] == NSLocaleLanguageDirectionRightToLeft) {
        [self nextOrPreviousCar:YES];
    } else {
        [self nextOrPreviousCar:NO];
    }
}

#pragma mark - Utility Functions
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
    return currentEditType == kCurrentEditModel ? myCar.model : myCar.make;
    
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

-(NSInteger)editValueYear
{
    return [myCar.year integerValue];
}

- (void)editYearDone:(NSInteger)editValueYear
{
    if (editValueYear < kModelTYear || editValueYear == [myCar.year integerValue]) {
        return;
    }
    dataUpdated = YES;
    myCar.year = [NSNumber numberWithInteger:editValueYear];
    NSString *string = [Utils localizeDateWithYear:editValueYear];
    self.yearLabel.text = string;
    [self.tableView reloadData];
}

- (void) editDone: (NSString*) textFieldValue
{
    if (IsEmptyString(textFieldValue)) {
        return;
    }
    switch (currentEditType) {
        case kCurrentEditMake:
            dataUpdated = dataUpdated || ![myCar.make isEqualToString:textFieldValue];
            myCar.make = textFieldValue;
            self.makeLabel.text = textFieldValue;
            break;
        case kCurrentEditModel:
            dataUpdated = dataUpdated || ![myCar.make isEqualToString:textFieldValue];
            myCar.model = textFieldValue;
            self.modelLabel.text = textFieldValue;
            break;
        default:
            break;
    }
    
}

#pragma mark - Gestures

- (IBAction)swipeCarRight:(UISwipeGestureRecognizer*)sender {
    if ([NSLocale characterDirectionForLanguage:[NSLocale preferredLanguages][0]] == NSLocaleLanguageDirectionRightToLeft) {
        [self nextOrPreviousCar:NO];
    } else {
        [self nextOrPreviousCar:YES];
    }
}

- (IBAction)swipeCarLeft:(UISwipeGestureRecognizer*)sender {
    if ([NSLocale characterDirectionForLanguage:[NSLocale preferredLanguages][0]] == NSLocaleLanguageDirectionRightToLeft) {
        [self nextOrPreviousCar:YES];
    } else {
        [self nextOrPreviousCar:NO];
    }
}

@end
