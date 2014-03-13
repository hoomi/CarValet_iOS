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
#import "DetailController.h"

@interface CarTableViewController ()

@end

@implementation CarTableViewController
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultController;
    NSFetchRequest *fetchRequest;
    NSIndexPath *currentIndexPath;
    UITableView *currentTableView;
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
    
    fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CDCar"];
    [self changeCarSort:kCarsTableSortDateCreated];
//    self.navigationItem.leftBarButtonItem = self.editButton;
    
    
    UIColor *magnesium = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    self.tableView.sectionIndexColor = magnesium;
    
    UIColor *mercuryWithAlpha = [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:230.0/255.0 alpha:0.1];
    
    self.tableView.sectionIndexBackgroundColor = mercuryWithAlpha;
    
    UIColor *mercury = [UIColor colorWithRed:230.0/255.0 green:233.0/255.0 blue:230.0/255.0 alpha:1.0];
    self.tableView.sectionIndexTrackingBackgroundColor = mercury;
    if (!self.delegate) {
        self.title = NSLocalizedStringWithDefaultValue(
                                                       @"AddViewScreenTitle",
                                                       nil,
                                                       [NSBundle mainBundle],
                                                       @"CarValet",
                                                       @"Title for the main app screen");
    }
    currentTableView = self.tableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
    [self.mySearchBar setShowsScopeBar:YES];
    
    if (self.delegate == nil) {                                             // 1
        self.navigationItem.leftBarButtonItem = self.editButton;            // 2
    } else {                                                                // 3
        UIBarButtonItem *addButton = self.navigationItem.rightBarButtonItem;
        self.navigationItem.rightBarButtonItems = @[addButton, self.editButton];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"ViewCarSegue"]) {                        // 1
        if (self.delegate != nil) {                                         // 2
            return NO;                                                      // 3
        }
    }
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ViewCarSegue"] && self.delegate == nil) {
        ViewCarViewController *nextController = segue.destinationViewController;
        nextController.fetchRequest = fetchRequest;
        nextController.delegate = self;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[fetchedResultController sections] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [fetchedResultController sections][section];
    return [sectionInfo name];
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
    CarTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.displayedCar = [fetchedResultController objectAtIndexPath:indexPath];
    [cell configureCell];
    
    // Configure the cell...
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return  YES;
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

-(NSArray *)sectioIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexes;                                                     // 1
    if (self.mySearchBar.selectedScopeButtonIndex == kCarsTableSortYear) {        // 2
        indexes = [NSMutableArray new];
        
        for (id <NSFetchedResultsSectionInfo> sectionInfo in
             fetchedResultController.sections) {
            [indexes insertObject:[sectionInfo name]
                          atIndex:[indexes count]];
        }
    } else {
        indexes = [fetchedResultController sectionIndexTitles].mutableCopy;     // 3
    }
    
    if (!self.searchDisplayController.active)
        [indexes insertObject:UITableViewIndexSearch atIndex:0];                 // 4
    
    return indexes;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    if (!self.searchDisplayController.active) {
        if (index == 0) {                                                        // 1
            [tableView setContentOffset:CGPointZero animated:YES];               // 2
            return NSNotFound;                                                   // 3
        } else {
            index = index - 1;                                                   // 4
        }
    }
    
    return [fetchedResultController sectionForSectionIndexTitle:title           // 5
                                                        atIndex:index];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate) {
        
        NSIndexPath *previousPath = currentIndexPath;
        
        [self.delegate selectCar:[fetchedResultController objectAtIndexPath:indexPath]];
        if (previousPath != nil) {
            [self.tableView reloadRowsAtIndexPaths:@[previousPath]
                             withRowAnimation:NO];
        }
        currentIndexPath = indexPath;
        [[DetailController sharedDetailController] hidePopover];
    }
}

#pragma mark - UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self changeCarSort:selectedScope];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    [self searchBar:searchBar textDidChange:@""];
    [searchBar setShowsCancelButton:NO animated:YES];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText && ([searchText length] > 0)) {                      // 1
        fetchRequest.predicate = [NSPredicate predicateWithFormat:          // 2
                                  @"%K contains[cd] %@",                    // 3
                                  [[fetchRequest.sortDescriptors            // 4
                                    objectAtIndex:0] key],
                                  searchText];                            // 5
    } else {
        fetchRequest.predicate = nil;                                       // 6
    }
    
    NSError *error = nil;
    [fetchedResultController performFetch:&error];                         // 7
    
    if (error != nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.tableView reloadData];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller
 willShowSearchResultsTableView:(UITableView *)tableView
{
    currentTableView = tableView;
}

#pragma mark - UISearchDisplayDelegate


- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)
controller {
    [self searchDisplayController:controller
 shouldReloadTableForSearchString:@""];
    currentTableView = self.tableView;
    [self.tableView reloadData];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    if (searchString && ([searchString length] > 0)) {
        fetchRequest.predicate = [NSPredicate predicateWithFormat:
                                  @"%K contains[cd] %@",
                                  [[fetchRequest.sortDescriptors
                                    objectAtIndex:0] key],
                                  searchString];
    } else {
        fetchRequest.predicate = nil;
    }
    
    NSError *error = nil;
    [fetchedResultController performFetch:&error];
    
    if (error != nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return YES;
}


- (void)searchDisplayController:(UISearchDisplayController *)controller
  didLoadSearchResultsTableView:(UITableView *)tableView {
    tableView.rowHeight = self.tableView.rowHeight;
}



#pragma mark - ViewCarProtocol

- (NSInteger) carToView
{
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    NSInteger selectedCarIndexTableView = 0;
    for (NSInteger i = 0; i < selectedIndexPath.section; i++) {
        selectedCarIndexTableView += [self tableView:currentTableView numberOfRowsInSection:i];
    }
    selectedCarIndexTableView += selectedIndexPath.row;
    NSLog(@"selected row: %ld",(long)selectedCarIndexTableView);
    return selectedCarIndexTableView;
}

- (void) carViewDone:(BOOL) dataUpdated
{
    if (dataUpdated) {
        [currentTableView reloadRowsAtIndexPaths:[currentTableView indexPathsForVisibleRows]  withRowAnimation:UITableViewRowAnimationMiddle];
    }
}

#pragma mark - NSFetchResultControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [currentTableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [currentTableView endUpdates];
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
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sectionIndex];
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [currentTableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationRight];
            break;
        case NSFetchedResultsChangeDelete:
            [currentTableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationLeft];
            break;
        default:
            break;
    }
}

#pragma mark - Utility Methods

- (void)changeCarSort:(NSInteger)toSort
{
    NSString *sortKey;
    NSString *keyPath;
    BOOL isAscending;
    SEL compareSelector = nil;

    if ((self.delegate != nil) &&
        (self.tableView.indexPathForSelectedRow != nil)) {
        currentIndexPath = nil;
        [self.delegate selectCar:nil];
    }

    
    switch (toSort) {
        case kCarsTableSortMake:
            sortKey = @"make";
            keyPath = sortKey;
            isAscending = YES;
            compareSelector = @selector(localizedCaseInsensitiveCompare:);
            break;
            
        case kCarsTableSortModel:
            sortKey = @"model";
            keyPath = sortKey;
            isAscending = YES;
            compareSelector = @selector(localizedCaseInsensitiveCompare:);
            break;
            
        case kCarsTableSortYear:
            sortKey = @"year";
            keyPath = sortKey;
            isAscending = NO;
            break;
            
        default:
            sortKey = @"createdAt";
            keyPath = nil;
            isAscending = NO;
            break;
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:sortKey
                                        ascending:isAscending
                                        selector:compareSelector];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    fetchedResultController = [[NSFetchedResultsController alloc]
                               initWithFetchRequest:fetchRequest
                               managedObjectContext:managedObjectContext
                               sectionNameKeyPath:keyPath
                               cacheName:nil];
    fetchedResultController.delegate = self;
    
    NSError *error = nil;
    [fetchedResultController performFetch:&error];
    
    if (error != nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.tableView reloadData];
}


#pragma mark - Actions

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

- (IBAction) editTableView:(id)sender
{
    BOOL startEdit = (sender == self.editButton);
    
    UIBarButtonItem *nextButton = startEdit ? self.doneButton : self.editButton;
    if (self.delegate == nil) {
        [self.navigationItem setLeftBarButtonItem:nextButton animated:YES];
    } else {
        UIBarButtonItem *addButton = self.navigationItem.rightBarButtonItems[0];
        
        [self.navigationItem setRightBarButtonItems:@[addButton, nextButton]
                                           animated:YES];
    }
    [self.tableView setEditing:startEdit animated:YES];
}

@end
