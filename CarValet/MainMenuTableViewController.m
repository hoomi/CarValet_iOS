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

@interface MainMenuTableViewController ()

@end

@implementation MainMenuTableViewController

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
        default:
            nextController = nil;
            break;
    }
    [DetailController sharedDetailController].currDetailController= nextController;
    
}

@end
