//
//  ProductionOffice.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/18/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Production.h"

@interface ProductionOffice : UITabBarController

@property (strong, nonatomic) User *mainUser;
@property (strong, nonatomic) Production *thisProduction;

@end
