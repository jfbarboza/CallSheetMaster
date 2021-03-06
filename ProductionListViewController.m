//
//  ProductionListViewController.m
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/17/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import "ProductionListViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "Production.h"
#import "ProductionOffice.h"
#import "ProductionViewController.h"

@interface ProductionListViewController()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *path;
@property (strong, nonatomic) User *selectedUser;
@property (strong, nonatomic) Production *selectedProduction;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation ProductionListViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:0.80
                                                green:0.80
                                                blue:0.80
                                                alpha:1.0];
    //self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
//    UIImage *navigationBarBackgroung = [[UIImage imageNamed:@"NavBar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake( 0, 0, 0, 0)];
//    [[UINavigationBar appearance] setBackgroundImage:navigationBarBackgroung forBarMetrics:UIBarMetricsDefault];
    
    // Call AppDelegate to work on its context
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.managedObjectContext = app.document.managedObjectContext;
        
    // Initialize Fetch request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"User"];
        
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES]]];
        
    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:app.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
        
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
        
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
        
    // Do any additional setup after loading the view.
    

    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSSet *prodRecords = [self.mainUser valueForKey:@"prodCompany"];
    NSArray *prodList = [prodRecords allObjects];
    return [prodList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleCellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleCellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    //NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //NSSet *prodRecords = [record valueForKey:@"prodCompany"];
    NSSet *prodRecords = [self.mainUser valueForKey:@"prodCompany"];
    NSArray *prodList = [prodRecords allObjects];
    Production *prod = [prodList objectAtIndex:indexPath.row];
    cell.textLabel.text = [prod valueForKey:@"prodTitle"];
    //NSLog(@"Production Title: %@", [prod valueForKey:@"prodTitle"]);
}


#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}



- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
            //REVISAR
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.path = indexPath;
    // Deselect the user from tableView
    [self performSegueWithIdentifier:@"toProductionOffice" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toProductionOffice"]) {
        ProductionOffice *pvc = segue.destinationViewController;
        pvc.mainUser = self.selectedUser;
        NSSet *prodRecords = [self.mainUser valueForKey:@"prodCompany"];
        NSArray *prodList = [prodRecords allObjects];
        Production *prod = [prodList objectAtIndex:self.path.row];
        pvc.thisProduction = prod;
        NSLog(@"This is mainUser in prepare for segue: %@", pvc.mainUser);
    }
    
    if ([segue.identifier isEqualToString:@"newProdSegue2"]) {
        ProductionViewController *pvc = segue.destinationViewController;
        NSLog(@"This is selected User in prepare for segue %@", self.selectedUser);
        pvc.mainUser = self.mainUser;
        NSLog(@"This is mainUser in prepare for segue: %@", pvc.mainUser);
    }
}





@end
