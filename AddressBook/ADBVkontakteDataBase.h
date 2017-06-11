//
//  ADBVkontakteDataBase.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADBDataBaseDriver.h"

@interface ADBVkontakteDataBase : NSObject <ADBDataBaseDriver, NSURLSessionDelegate>

-(void) getContacts: (id<ADBViewManager>) viewManager;

@end
