//
//  ADBPathFileJsonDataBase.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADBDataBaseDriver.h"
#import "ADBViewManager.h"

@interface ADBPathFileJsonDataBase : UIImageView <ADBDataBaseDriver>
-(void) getContacts: (id<ADBViewManager>) viewManager;

@end
