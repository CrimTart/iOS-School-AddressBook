//
//  ADBAddressBookDataBase.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADBDataBaseDriver.h"
#import "ADBViewManager.h"

@interface ADBAddressBookDataBase : NSObject <ADBDataBaseDriver>

-(void) getContacts: (id<ADBViewManager>)viewManager;

@end
