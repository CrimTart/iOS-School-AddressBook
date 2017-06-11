//
//  ViewController.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADBDataBaseDriver.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

-(void) updateContacts: (ADBContactList *)newContacts;
-(instancetype) initWithContactManager: (id<ADBDataBaseDriver>)contactManager;

@end

