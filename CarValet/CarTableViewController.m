//
//  CarTableViewController.m
//  CarValet
//
//  Created by Hooman Ostovari on 06/03/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import "CarTableViewController.h"
#import "CDCar.h"
#import "AppDelegate.h"
#import "CarTableViewCell.h"
#import "ViewCarViewController.h"

@interface CarTableViewController ()

@end

@implementation CarTableViewController
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultController;
    NSFetchRequest *fetchRequest;
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
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = appDelegate.managedObjectContext;
    
    NSError *error = nil;
    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CDCar"];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    fetchedResultController = [[NSFetchedResultsController alloc]
                               initWithFetchRequest:fetchRequest
                               managedObjectContext:managedObjectContext
                               sectionNameKeyPath:nil
                               cacheName:nil];
    
    [fetchedResultController performFetch:&error];
    
    if (error != nil) {
        NSLog(@"Unresolved error %@, %@",error, [error userInfo]);
        abort();
    }
    fetchedResultController.delegate = self;
    self.navigationItem.leftBarButtonItem = self.editButton;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newCar:(id)sender {
    CDCar *newCar = [NSEntityDescription insertNewObjectForEntityForName:@"CDCar" inManagedObjectContext:managedObjectContext];
    newCar.createdAt = [NSDate date];
    NSError *error = nil;
    
    [managedObjectContext save:&error];
    
    if (error != nil) {
        NSLog(@"Unresolved error %@, %@",error, [error userInfo]);
        abort();
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[fetchedResultController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [fetchedResultController sections][section];
    // Return the number of rows in the section.
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CarCell";
    CarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.displayedCar = [fetchedResultController objectAtIndexPath:indexPath];
    [cell configureCell];
    
    // Configure the cell...
    
    return cell;
}


- (void) editTableView:(id)sender
{
    BOOL startEdit = (sender == self.editButton);
    
    UIBarButtonItem *nextButton = startEdit ? self.doneButton : self.editButton;
    
    [self.navigationItem setLeftBarButtonItem:nextButton animated:YES];
    [self.tableView setEditing:startEdit animated:YES];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return  YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewCarSegue"]) {
        ViewCarViewController *nextController = segue.destinationViewController;
        nextController.delegate = self;
    }
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSError *error;
        [managedObjectContext deleteObject:[fetchedResultController objectAtIndexPath:indexPath]];
        [managedObjectContext save:&error];
        
        if (error != nil) {
            NSLog(@"Unresolved error %@, %@",error, [error userInfo]);
            abort();
        }
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (NSInteger) carToView
{
    return [self.tableView indexPathForSelectedRow].row;
}

- (void) carViewDone:(BOOL) dataUpdated
{
    if (dataUpdated) {
        [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows]  withRowAnimation:UITableViewRowAnimationMiddle];
    }
}

#pragma - NSFetchResultControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller
  didChangeObject:(id)anObject
      atIndexPath:(NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type
     newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView* tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationRight];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        default:
            break;
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */
@end
