//
//  UserListViewController.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/9/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@import GoogleMobileAds;

@interface UserListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;

@end
