//
//  ProductionViewController.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/16/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProductionViewController : UIViewController

@property (strong, nonatomic) User *mainUser;

- (id) initWithUser:(User *)user;

@end
