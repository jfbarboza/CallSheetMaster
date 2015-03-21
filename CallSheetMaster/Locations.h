//
//  Locations.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/20/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Production, Scenes;

@interface Locations : NSManagedObject

@property (nonatomic, retain) NSString * locAddress;
@property (nonatomic, retain) NSString * locCity;
@property (nonatomic, retain) NSString * locContaEmail;
@property (nonatomic, retain) NSString * locContaName;
@property (nonatomic, retain) NSString * locContaPhone;
@property (nonatomic, retain) NSString * locState;
@property (nonatomic, retain) NSString * locTitle;
@property (nonatomic, retain) NSNumber * locZIP;
@property (nonatomic, retain) Production *toProduction;
@property (nonatomic, retain) NSSet *toScenes;
@end

@interface Locations (CoreDataGeneratedAccessors)

- (void)addToScenesObject:(Scenes *)value;
- (void)removeToScenesObject:(Scenes *)value;
- (void)addToScenes:(NSSet *)values;
- (void)removeToScenes:(NSSet *)values;

@end
