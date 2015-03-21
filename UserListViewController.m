//
//  UserListViewController.m
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/9/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import "UserListViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "ProductionViewController.h"
#import "ProductionListViewController.h"
@import GoogleMobileAds;

@interface UserListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSIndexPath *path;
@property (strong, nonatomic) User *selectedUser;

@end


@implementation UserListViewController


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:0.00
                                                green:0.00
                                                 blue:0.00
                                                alpha:1.0];
    
    //self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    // Set Navegation Bar Background
    UIImage *navigationBarBackgroung = [[UIImage imageNamed:@"NavBar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake( 0, 0, 0, 0)];
    [self.navigationController.navigationBar setBackgroundImage:navigationBarBackgroung forBarMetrics:UIBarMetricsDefault];

    
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
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    self.bannerView.adUnitID =@"ca-app-pub-3940256099942544/2934735716";
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];

    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{
    UIImage *navigationBarBackgroung = [[UIImage imageNamed:@"NavBar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake( 0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:navigationBarBackgroung forBarMetrics:UIBarMetricsDefault];
}
#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sections = [self.fetchedResultsController sections];
    id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
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
    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [record valueForKey:@"firstName"];
    cell.textLabel.font = [UIFont fontWithName:@"RODUSreg300" size:12];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = (indexPath.row%2)?[UIColor colorWithRed:159.00/255 green:248.00/255 blue:251.00/255 alpha:1.00]:[UIColor colorWithRed: 27.00 /255 green:247.00 / 255 blue:255.00/255 alpha:1.00];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deleting User" message:@"Are you sure you want to delete this user?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    self.path = indexPath;
    alert.tag = 1;
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:self.path];
            [app.managedObjectContext deleteObject:object];
            NSLog(@"%@",object);
            NSError *error;
            if([app.managedObjectContext save:&error]== NO){
                NSLog(@"%@", error.localizedDescription);
            }
            if (error) {
                NSLog(@"%@", error.localizedDescription);
            }
            [self.tableView reloadData];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else if (alertView.tag == 2){
        if (buttonIndex == 0){
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        } else {
            NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:self.path];
            self.selectedUser = (User *)object;
            NSLog(@"%@", object);
            UITextField *passTF = [alertView textFieldAtIndex:0];
            NSString *savedPass = [NSString stringWithFormat:@"%@", [object valueForKey:@"password"]];
            
            // Verficando la clave
           
            if ([passTF.text isEqualToString:savedPass]) {
                
                // Chequeando que el usuario elegido tenga producciones asociadas
                
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                app.managedObjectContext = app.document.managedObjectContext;

                NSFetchRequest *request = [[NSFetchRequest alloc] init];
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:app.managedObjectContext];
                [request setEntity:entity];
                NSError *error = nil;
                NSArray *user = [app.managedObjectContext executeFetchRequest:request error:&error];
                NSLog(@"This is what we retrieve: %@", user);
                //If there are no productions call the ProductionViewController to add a new one
                NSSet *prod = [[NSSet alloc]initWithSet:self.selectedUser.prodCompany];
                if ([prod count] == 0) {
                    //ProductionViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"addProduction"];
                    //[self.navigationController pushViewController:vc1 animated:YES];
                    [self performSegueWithIdentifier:@"newProdSegue" sender:self];
                    NSLog(@"On your way!");
                } else {
                    NSLog(@"You have productions!!!");
                    [self performSegueWithIdentifier:@"userToProdList" sender:self];
                    //Present List of productions
                }
            } else {
                UIAlertView *wrongPass = [[UIAlertView alloc]initWithTitle:@"Try again" message:@"Verify user or password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [wrongPass show];
            }
        }
    }
}

// Selected USER from Tableview

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.path = indexPath;
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Once selected call UIAlertView to check for password
    UIAlertView *passView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@",[object valueForKey:@"firstName"]] message:@"Please write your password:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    
    // Set the style to get secure text
    passView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    passView.tag = 2;
    [passView show];
    
    // Deselect the user from tableView
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"newProdSegue"]) {
        ProductionViewController *pvc = segue.destinationViewController;
        NSLog(@"This is selected User in prepare for segue %@", self.selectedUser);
        pvc.mainUser = self.selectedUser;
        NSLog(@"This is mainUser in prepare for segue: %@", pvc.mainUser);
    }
    if ([segue.identifier isEqualToString:@"userToProdList"]) {
        ProductionListViewController *pvc = segue.destinationViewController;
        NSLog(@"This is selected User in prepare for segue to Prod List: %@", self.selectedUser);
        pvc.mainUser = self.selectedUser;
        NSLog(@"This is mainUser in prepare for segue  to Prod List: %@", pvc.mainUser);
    }
}



@end
