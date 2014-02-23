//
//  ViewController.h
//  Contatos
//
//  Created by Daniel Arndt Alves on 2/23/14.
//  Copyright (c) 2014 ProgDan Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController : UIViewController <ABNewPersonViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

@end
