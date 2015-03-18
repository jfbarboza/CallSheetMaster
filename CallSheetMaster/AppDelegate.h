//
//  AppDelegate.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/7/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UIManagedDocument *document;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

