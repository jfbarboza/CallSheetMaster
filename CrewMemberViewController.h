//
//  CrewMemberViewController.h
//  CallSheetMaster
//
//  Created by Jorge Barboza on 3/19/15.
//  Copyright (c) 2015 Jorge Barboza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface CrewMemberViewController : UIViewController {

ABPeoplePickerNavigationController *picker;
IBOutlet UILabel *phoneNo;
IBOutlet UILabel *email;
IBOutlet UILabel *name;

}

- (IBAction)chooseContact:(id)sender;


@end
