//
//  MainMenuTableViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 12/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "MainMenuTableViewController.h"
#import "AppDelegate.h"
#import "AboutViewController.h"
#import "DetailController.h"
#import "CarDetailsViewController.h"
#import "CarTableViewController.h"
#import "ReturnGestureRecognizer.h"

@interface MainMenuTableViewController ()

@end

@implementation MainMenuTableViewController {
    CarDetailsViewController *currentCarDetailsController;
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
    
    for (UIImageView *iv in self.menuImages) {
        iv.image = [iv.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        iv.highlightedImage = [iv.highlightedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    ReturnGestureRecognizer *returnGesture = [[ReturnGestureRecognizer alloc]initWithTarget:self action:@selector(returnHome:)];
    [DetailController sharedDetailController].returnGesture = returnGesture;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (currentCarDetailsController != nil) {                                // 1
        [DetailController sharedDetailController].currDetailController = nil;
        currentCarDetailsController = nil;                                   // 2
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *iPhoneStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:[NSBundle mainBundle]];
    UIViewController *nextController;
    CarTableViewController *carTable;
    BOOL newDetail = YES;
    
    switch (indexPath.row) {
        case kPadMenuAboutItem:
            nextController = [iPhoneStoryBoard instantiateViewControllerWithIdentifier:@"AboutViewController"];
            nextController.navigationItem.hidesBackButton = YES;
            nextController.navigationItem.title = @"About";
            break;
        case kPadMenuImagesItem:
            nextController = [iPhoneStoryBoard instantiateViewControllerWithIdentifier:@"CarImagesViewController"];
            nextController.navigationItem.hidesBackButton = YES;
            nextController.navigationItem.rightBarButtonItem = nil;
            break;
        case kPadMenuCarsItem:
        {
            carTable = [iPhoneStoryBoard instantiateViewControllerWithIdentifier:
                        @"CarTableViewController"];
            
            carTable.navigationItem.title = @"Cars";
            carTable.delegate = self;
            
            nextController = carTable;
            [self.navigationController pushViewController:nextController   // 2
                                                 animated:YES];
            nextController.navigationItem.title = @"Cars";
            ((CarTableViewController*)nextController).delegate = self;
            
            if (currentCarDetailsController == nil) {                                  // 1
                currentCarDetailsController = [[self storyboard]
                                              instantiateViewControllerWithIdentifier:
                                              @"CarDetailViewController"];
                
                [[DetailController sharedDetailController] setCurrDetailController:currentCarDetailsController
                                              hidePopover:NO];
            }
            currentCarDetailsController.nextOrPreviousCar = ^(BOOL isNext){
                [carTable nextOrPreviousCar:isNext];
            };
            nextController = currentCarDetailsController;
            newDetail = NO;
            break;
        }
        default:
            nextController = nil;
            break;
    }
    if (newDetail) {
        [DetailController sharedDetailController].currDetailController= nextController;
    }
    
}

#pragma mark - CarTableViewProtocol
- (void)editMode:(BOOL)isEdit
{
    [currentCarDetailsController updateEditableState:isEdit];
}
-(void)selectCar:(CDCar *)selectedCar
{
    currentCarDetailsController.displayedCar = selectedCar;

}

-(IBAction)returnHome:(UIGestureRecognizer*)sender
{
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    if (currentCarDetailsController != nil) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        currentCarDetailsController = nil;
    }
    
    [DetailController sharedDetailController].currDetailController = nil;
}


@end
