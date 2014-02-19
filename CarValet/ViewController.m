//
//  ViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 14/01/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "ViewController.h"
#import "HybridCar.h"
#import "ElectricCar.h"
#import "CarEditViewController.h"


@interface ViewController ()

@end

@implementation ViewController {
    
    BOOL isShowingPortrait;
    
    NSMutableArray *arrayOfCars;
    NSInteger displayedCarIndex;
    NSArray *rootViewLandscapeConstraints;
    NSArray *separatorViewLandscapeConstraints;
    NSArray *addCarViewLandscapeConstraints;
    
    __weak IBOutlet UIView *addCarView;
    __weak IBOutlet UIView *separatorView;
    
    __weak IBOutlet UIView *viewCarView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLandscapeConstraints];
    arrayOfCars = [[NSMutableArray alloc] init];
    displayedCarIndex = 0;
    isShowingPortrait = [self isPortrait];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    isShowingPortrait = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    [self updateUiBasedOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self changeDisplayedCar:displayedCarIndex];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsPortrait(currentOrientation) ^ isShowingPortrait) {
        [self willAnimateRotationToInterfaceOrientation:currentOrientation duration:0];
    }
}

- (void) updateUiBasedOrientation
{
    if (isShowingPortrait) {
        [self.view removeConstraints:rootViewLandscapeConstraints];
        [addCarView removeConstraints:addCarViewLandscapeConstraints];
        [separatorView removeConstraints:separatorViewLandscapeConstraints];
        
        [self.view addConstraints:self.rootViewPortraitConstraints];
        [addCarView addConstraints:self.addCarViewPortraitConstraints];
        [separatorView addConstraints:self.separatorViewPortraitConstraints];
    } else {
        [self.view removeConstraints:self.rootViewPortraitConstraints];
        [addCarView removeConstraints:self.addCarViewPortraitConstraints];
        [separatorView removeConstraints:self.separatorViewPortraitConstraints];
        
        [self.view addConstraints:rootViewLandscapeConstraints];
        [addCarView addConstraints:addCarViewLandscapeConstraints];
        [separatorView addConstraints:separatorViewLandscapeConstraints];
    }

}

- (BOOL) isPortrait
{
    return UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]);
}

- (void) changeDisplayedCar : (NSInteger) displayCarIndex {
    if (displayCarIndex < 0) {
        displayCarIndex = 0;
    } else if (displayCarIndex >= [arrayOfCars count]) {
        displayCarIndex = [arrayOfCars count] - 1;
    }
    displayedCarIndex = displayCarIndex;
    self.prevCarButton.enabled = displayedCarIndex > 0;
    self.nextCarButton.enabled = displayedCarIndex < [arrayOfCars count] -1;
    self.editCarButton.enabled = [arrayOfCars count] > 0;

    [self displayCarInformation];
    
}

- (void) updateLabel :(UILabel *) label : (NSString*) withBaseString : (NSInteger) count {
    NSString* newText = [NSString stringWithFormat:@"%@: %d",withBaseString,count];
    label.text = newText;
}

- (void) displayCarInformation {
    if ([arrayOfCars count] == 0) {
        self.numberCarLabel.text = [NSString stringWithFormat:@"No Cars"];
        self.carInfoLabel.text = nil;
    } else {
        Car *currentCar = [arrayOfCars objectAtIndex:displayedCarIndex];
        self.numberCarLabel.text = [NSString stringWithFormat:@"Car Number: %d",displayedCarIndex];
        [self updateLabel:self.numberCarLabel :@"Car number" :displayedCarIndex + 1];
        self.carInfoLabel.text = [currentCar carInfo];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Segue %@",segue.identifier);
    if ([segue.identifier isEqualToString:@"EditSegue"]) {
        CarEditViewController* nextController;
        nextController = segue.destinationViewController;
        nextController.carNumber = displayedCarIndex + 1;
        nextController.currentCar = [arrayOfCars objectAtIndex:displayedCarIndex];
    }
}

- (IBAction)newCar:(id)sender {
    Car* newCar = [[Car alloc] init];
    [arrayOfCars addObject:newCar];
    [self updateLabel:self.totalCarLabel :@"Total Cars" :[arrayOfCars count]];
    [self changeDisplayedCar:[arrayOfCars count] - 1];
}

- (IBAction)nextCar:(id)sender {
    [self changeDisplayedCar:displayedCarIndex + 1];
}

- (IBAction)prevCar:(id)sender {
    [self changeDisplayedCar:displayedCarIndex - 1];
}



- (IBAction)editingDone:(UIStoryboardSegue*)segue
{
    NSLog(@"editingDone called \n");
    [self displayCarInformation];
}

- (void) setupLandscapeConstraints
{
    NSDictionary *views = NSDictionaryOfVariableBindings(addCarView,separatorView,viewCarView);
    NSMutableArray *tempRootViewConstraints = [NSMutableArray new];

    NSArray *generateConstraints = [NSLayoutConstraint
                                    constraintsWithVisualFormat:@"H:|-[addCarView]-2-[separatorView]-10-[viewCarView]-|"
                                    options:0
                                    metrics:nil
                                    views:views];
    [tempRootViewConstraints addObjectsFromArray:generateConstraints];
    generateConstraints = [NSLayoutConstraint
                           constraintsWithVisualFormat:@"V:|-[addCarView]-|"
                           options:0
                           metrics:nil
                           views:views];
    [tempRootViewConstraints addObjectsFromArray:generateConstraints];
    
    generateConstraints = [NSLayoutConstraint
                           constraintsWithVisualFormat:@"V:|-[viewCarView]"
                           options:0
                           metrics:nil
                           views:views];
    [tempRootViewConstraints addObjectsFromArray:generateConstraints];
    
    generateConstraints = [NSLayoutConstraint
                           constraintsWithVisualFormat:@"V:|-[separatorView]-|"
                           options:0
                           metrics:nil
                           views:views];
    [tempRootViewConstraints addObjectsFromArray:generateConstraints];


  
    
    rootViewLandscapeConstraints = [NSArray arrayWithArray:tempRootViewConstraints];
    addCarViewLandscapeConstraints = [NSLayoutConstraint
                                     constraintsWithVisualFormat:@"H:[addCarView(112)]"
                                     options:0
                                     metrics:nil
                                     views:views];
    separatorViewLandscapeConstraints = [NSLayoutConstraint
                                        constraintsWithVisualFormat:@"H:[separatorView(2)]"
                                        options:0
                                        metrics:nil
                                        views:views];
}


@end
