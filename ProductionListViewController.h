//
//  ProductionListViewController.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/17/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "User.h"

@interface ProductionListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) User *mainUser;

@end
