//
//  Scenes.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/20/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Locations, Production;

@interface Scenes : NSManagedObject

@property (nonatomic, retain) NSString * sceneDescription;
@property (nonatomic, retain) NSNumber * sceneDN;
@property (nonatomic, retain) NSNumber * sceneINTEXT;
@property (nonatomic, retain) NSString * sceneNumber;
@property (nonatomic, retain) Locations *toLocations;
@property (nonatomic, retain) Production *toProduction;

@end
