//
//  Production.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/20/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CrewMember, Locations, Scenes, User;

@interface Production : NSManagedObject

@property (nonatomic, retain) NSString * prodCompany;
@property (nonatomic, retain) NSString * prodDescription;
@property (nonatomic, retain) NSDate * prodGeneralCall;
@property (nonatomic, retain) NSString * prodTitle;
@property (nonatomic, retain) User *email;
@property (nonatomic, retain) NSSet *toCrewMember;
@property (nonatomic, retain) NSSet *toLocations;
@property (nonatomic, retain) NSSet *toScenes;
@end

@interface Production (CoreDataGeneratedAccessors)

- (void)addToCrewMemberObject:(CrewMember *)value;
- (void)removeToCrewMemberObject:(CrewMember *)value;
- (void)addToCrewMember:(NSSet *)values;
- (void)removeToCrewMember:(NSSet *)values;

- (void)addToLocationsObject:(Locations *)value;
- (void)removeToLocationsObject:(Locations *)value;
- (void)addToLocations:(NSSet *)values;
- (void)removeToLocations:(NSSet *)values;

- (void)addToScenesObject:(Scenes *)value;
- (void)removeToScenesObject:(Scenes *)value;
- (void)addToScenes:(NSSet *)values;
- (void)removeToScenes:(NSSet *)values;

@end
