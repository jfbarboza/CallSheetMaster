//
//  CrewMember.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/20/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Production;

@interface CrewMember : NSManagedObject

@property (nonatomic, retain) NSDate * callTime;
@property (nonatomic, retain) NSNumber * castNumber;
@property (nonatomic, retain) NSString * crewEmail;
@property (nonatomic, retain) NSString * crewFirstName;
@property (nonatomic, retain) NSString * crewLastName;
@property (nonatomic, retain) NSString * crewPosition;
@property (nonatomic, retain) NSString * crewTelephone;
@property (nonatomic, retain) NSNumber * isCast;
@property (nonatomic, retain) Production *toProduction;

@end
