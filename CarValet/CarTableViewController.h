//
//  CarTableViewController.h
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CarTableViewProtocol.h"
@interface CarTableViewController : UITableViewController <NSFetchedResultsControllerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
@property (weak, nonatomic) id<CarTableViewProtocol> delegate;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
- (IBAction)editTableView:(id)sender;
- (void) nextOrPreviousCar:(BOOL)isNext;

@end
