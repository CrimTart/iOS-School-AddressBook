//
//  ADBDataBaseDriver.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ADBContactList;
@protocol ADBViewManager;

@protocol ADBDataBaseDriver <NSObject>

-(void) getContacts: (id<ADBViewManager>)viewManager;

@end
