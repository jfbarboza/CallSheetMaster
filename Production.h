//
//  Production.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/15/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Production : NSManagedObject

@property (nonatomic, retain) NSString * prodCompany;
@property (nonatomic, retain) NSString * prodDescription;
@property (nonatomic, retain) NSString * prodTitle;
@property (nonatomic, retain) User *email;

@end
