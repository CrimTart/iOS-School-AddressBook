//
//  ADBPathFileJsonDataBase.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBPathFileJsonDataBase.h"
#import "ADBJsonDataBase.h"
#import "ADBContactList.h"
#import "ViewController.h"

@implementation ADBPathFileJsonDataBase

-(void) getContacts: (id<ADBViewManager>) viewManager {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mock" ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    
    NSArray * fields = @[
                         @"name",
                         @"surname",
                         @"phone",
                         @"email",
                         @""
                         ];
    
    ADBContactList *contacts = [[ADBJsonDataBase new] getContacts:JSONData forFields:fields];
    [viewManager updateContacts:contacts];
    [viewManager reloadTable];
}

@end
