//
//  ViewController.m
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/7/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "ProductionViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassTF;
@property (weak, nonatomic) IBOutlet UITextField *telephoneTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;


@end

@implementation ViewController

- (void)viewDidLoad {
  //  [self isCoreDataLoaded];
    self.view.backgroundColor = [UIColor colorWithRed:0.00
                                                green:0.00
                                                 blue:0.00
                                                alpha:1.0];
    [super viewDidLoad];
    

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void) isCoreDataLoaded{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(app.managedObjectContext == nil){
        [self performSelector:@selector(isCoreDataLoaded) withObject:nil afterDelay:0.2];
    } else {
        [self coreDataLoaded];
    }
}
- (void) coreDataLoaded{

} */
- (IBAction)submitUserInfo:(id)sender {

    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.managedObjectContext = app.document.managedObjectContext;
    
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:app.managedObjectContext];
    user.firstName = self.firstNameTF.text;
    user.lastName = self.lastNameTF.text;
    if ([self.passTF.text isEqualToString:self.confirmPassTF.text]) {
        user.password = self.passTF.text;
    }
    user.telephone = self.telephoneTF.text;
    user.email = self.emailTF.text;
    self.createdUser = user;
    [app.document saveToURL:app.document.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
        if(success == YES){
            NSLog(@"Awesome it's save!");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved!" message:@"New user saved!!!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:app.managedObjectContext];
            [request setEntity:entity];
            NSError *error = nil;
            [request setResultType:NSDictionaryResultType];
            [request setReturnsDistinctResults:YES];
            NSArray *prod = [app.managedObjectContext executeFetchRequest:request error:&error];
            NSLog(@"This is what you just save: %@", prod);
            [self performSegueWithIdentifier:@"userToProdSegue" sender:self];
            // Else present the list of productions associated with the user
    } else {
        NSLog(@"Data not save :( ");
    }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"userToProdSegue"]) {
        ProductionViewController *pvc = segue.destinationViewController;
        NSLog(@"This is selected User in prepare for segue %@", self.createdUser);
        pvc.mainUser = self.createdUser;
        NSLog(@"This is mainUser in prepare for segue: %@", pvc.mainUser);
    }
}




@end
