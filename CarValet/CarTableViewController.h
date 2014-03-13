//
//  CarTableViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ViewCarProtocol.h"
#import "CarTableViewProtocol.h"
@interface CarTableViewController : UITableViewController <ViewCarProtocol, NSFetchedResultsControllerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
@property (weak, nonatomic) id<CarTableViewProtocol> delegate;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
- (IBAction)editTableView:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;

@end
