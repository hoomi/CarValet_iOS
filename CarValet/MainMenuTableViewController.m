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
    
    
    self.aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
    if (IsIpad()) {
        self.aboutViewController.navigationItem.hidesBackButton = YES;
        self.aboutViewController.navigationItem.title = @"About";
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
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    UIWindow *mainWindow = appDelegate.window;
    UISplitViewController *splitViewController = (UISplitViewController*)mainWindow.rootViewController;
    UINavigationController *detailController = [splitViewController viewControllers].lastObject;
    
    UIViewController *nextController;
    
    switch (indexPath.row) {
        case kPadMenuAboutItem:
            nextController = self.aboutViewController;
            if (![[detailController topViewController] isMemberOfClass:nextController.class]) {
                [detailController pushViewController:nextController animated:YES];
            }
            break;
        case kPadMenuCarsItem:
        default:
            [detailController popToRootViewControllerAnimated:YES];
            break;
    }
    
}

@end
