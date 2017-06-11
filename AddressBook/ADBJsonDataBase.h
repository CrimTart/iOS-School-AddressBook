//
//  ADBJsonDataBase.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADBDataBaseDriver.h"

@interface ADBJsonDataBase : NSObject
-(ADBContactList *) getContacts: (NSData *)json forFields:(NSArray<NSString *>*)fields;
@end
