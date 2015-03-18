//
//  User.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/15/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Production;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSSet *prodCompany;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addProdCompanyObject:(Production *)value;
- (void)removeProdCompanyObject:(Production *)value;
- (void)addProdCompany:(NSSet *)values;
- (void)removeProdCompany:(NSSet *)values;

@end
