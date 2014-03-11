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
    NSArray *arrayOfCars;
    NSFetchRequest *fetchRequest;
    NSInteger currentEditType;
    NSManagedObjectContext *managedObjectContext;
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
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    
    NSError *error = nil;
    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CDCar"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"make" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];

    arrayOfCars = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error != nil) {
        NSLog(@"Unresolved error %@, %@",error, [error userInfo]);
        abort();
    }
    self.displayedCarIndex = [self.delegate carToView];
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

- (void) changeDisplayedCar:(NSInteger) index
{
    NSInteger count = [arrayOfCars count];
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

- (void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == (UIViewController*) self.delegate) {
        if (dataUpdated) {
            [self.delegate carViewDone:dataUpdated];
        }
        navigationController.delegate = nil;
    }
}

- (void) displayCarInformation {
    
    CDCar * displayedCar = [arrayOfCars objectAtIndex:self.displayedCarIndex];
    self.makeLabel.text = (displayedCar.make == nil) ? @"Unknown" : displayedCar.make;
    
    self.modelLabel.text = (displayedCar.model == nil) ? @"Unknown" : displayedCar.model;
    
    self.yearLabel.text = [NSString stringWithFormat:@"%@", displayedCar.year];
    
    self.fuelLabel.text = [NSString stringWithFormat:@"%0.2f",[displayedCar.fuel floatValue]];
    
    self.dateLabel.text = [NSDateFormatter
                           localizedStringFromDate:displayedCar.createdAt
                           dateStyle:NSDateFormatterMediumStyle
                           timeStyle:NSDateFormatterNoStyle];
    
    self.timeLabel.text = [NSDateFormatter
                           localizedStringFromDate:displayedCar.createdAt
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
    CDCar *car = [arrayOfCars objectAtIndex:self.displayedCarIndex];
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

-(NSInteger)editValueYear
{
    CDCar *car = arrayOfCars[self.displayedCarIndex];
    return [car.year integerValue];
}

- (void)editYearDone:(NSInteger)editValueYear
{
    CDCar *car = arrayOfCars[self.displayedCarIndex];
    if (editValueYear < kModelTYear || editValueYear == [car.year integerValue]) {
        return;
    }
    dataUpdated = YES;
    car.year = [NSNumber numberWithInteger:editValueYear];
    NSString *string = [Utils localizeDateWithYear:editValueYear];
    self.yearLabel.text = string;
    [self.tableView reloadData];
}

- (void) editDone: (NSString*) textFieldValue
{
    if (IsEmptyString(textFieldValue)) {
        return;
    }
    CDCar *displayedCar = arrayOfCars[self.displayedCarIndex];
    switch (currentEditType) {
        case kCurrentEditMake:
            dataUpdated = dataUpdated || ![displayedCar.make isEqualToString:textFieldValue];
            displayedCar.make = textFieldValue;
            self.makeLabel.text = textFieldValue;
            break;
        case kCurrentEditModel:
            dataUpdated = dataUpdated || ![displayedCar.make isEqualToString:textFieldValue];
            displayedCar.model = textFieldValue;
            self.modelLabel.text = textFieldValue;
            break;
        default:
            break;
    }
    
}


@end
