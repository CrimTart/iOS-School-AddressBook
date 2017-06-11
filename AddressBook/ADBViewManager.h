//
//  ADBViewManager.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADBContactList;

@protocol ADBViewManager <NSObject>

-(void) reloadData;
-(void) goToRootViewController;
-(void) updateContacts: (ADBContactList *)newContacts;
-(void) reloadTable;

@end
