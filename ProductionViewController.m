//
//  ProductionViewController.m
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/16/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import "ProductionViewController.h"
#import "User.h"
#import "Production.h"
#import "AppDelegate.h"

@interface ProductionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *prodName;
@property (weak, nonatomic) IBOutlet UITextField *prodCompany;
@property (weak, nonatomic) IBOutlet UITextField *prodDescription;
@property (strong, nonatomic) Production *production;
@property (strong, nonatomic) AppDelegate *app;

@end

@implementation ProductionViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithRed:0.00
                                                green:0.00
                                                 blue:0.00
                                                alpha:1.0];
    
    NSLog(@"%@", self.mainUser);
    // Set title for view controller
    self.title = [NSString stringWithFormat:@"New production for %@", self.mainUser.firstName];
    
    // Set right navigation button to call save production
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveProductionInfo)];
    
    // Style Text fields
    self.prodName.layer.cornerRadius=8.0f;
    self.prodName.layer.masksToBounds=YES;
    self.prodName.layer.borderColor=[[UIColor colorWithRed:159.00/255 green:248.00/255 blue:251.00/255 alpha:1.00]CGColor];
    self.prodName.layer.borderWidth= 0.5f;
    
    self.prodCompany.layer.cornerRadius=8.0f;
    self.prodCompany.layer.masksToBounds=YES;
    self.prodCompany.layer.borderColor=[[UIColor colorWithRed:159.00/255 green:248.00/255 blue:251.00/255 alpha:1.00]CGColor];
    self.prodCompany.layer.borderWidth= 0.5f;
    
    self.prodDescription.layer.cornerRadius=8.0f;
    self.prodDescription.layer.masksToBounds=YES;
    self.prodDescription.layer.borderColor=[[UIColor colorWithRed:159.00/255 green:248.00/255 blue:251.00/255 alpha:1.00]CGColor];
    self.prodDescription.layer.borderWidth= 0.5f;
    
    [super viewDidLoad];
    // Do view setup here.
}
- (IBAction)creatProd:(id)sender {
    [self saveProductionInfo];
}

- (id) initWithUser:(User *)user{
    if (self = [super init]){
        _mainUser = user;
    }
    return self;
}

- (void) saveProductionInfo {
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.managedObjectContext = app.document.managedObjectContext;
    self.production = [[Production alloc] initWithEntity:[NSEntityDescription entityForName:@"Production" inManagedObjectContext:app.managedObjectContext] insertIntoManagedObjectContext:app.managedObjectContext];
    self.production.prodTitle = self.prodName.text;
    self.production.prodCompany = self.prodCompany.text;
    self.production.prodDescription = self.prodDescription.text;
    [self.mainUser addProdCompanyObject:(self.production)];
    [app.document saveToURL:app.document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
        if(success == YES){
            NSLog(@"Awesome it's save!");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved!" message:@"Added a new production!!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:app.managedObjectContext];
            [request setEntity:entity];
            NSError *error = nil;
            [request setResultType:NSDictionaryResultType];
            [request setReturnsDistinctResults:YES];
            [request setPropertiesToFetch:@[@"firstName"]];
            NSArray *users = [app.managedObjectContext executeFetchRequest:request error:&error];
            NSLog(@"This is what you just save: %@", users);
            [self performSegueWithIdentifier:@"creatingToOffice" sender:self];
        } else {
            NSLog(@"Data not save :( ");
        }
    }];

    
    
}

@end
