//
//  ADBJsonDataBase.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBJsonDataBase.h"
#import "ADBContact.h"
#import "ADBContactList.h"

@implementation ADBJsonDataBase

-(ADBContactList *) getContacts: (NSData *)json forFields:(NSArray<NSString *>*)fields {

    NSDictionary * JSONObject = [NSJSONSerialization JSONObjectWithData:json options:0 error:nil];
    NSDictionary * contacts = [JSONObject objectForKey:@"response"];

    ADBContact* (^createContact)(NSString *, NSString *, NSString *, NSString *, NSString *);
    createContact = ^ADBContact*(NSString *firstName,
                                 NSString *lastName,
                                 NSString *phone,
                                 NSString *email,
                                 NSString *url) {
        ADBContact *contact = [ADBContact new];
        contact.firstName = firstName;
        contact.lastName = lastName;
        contact.phone = phone;
        contact.email = email;
        contact.photoURL = url;
        return contact;
    };
    
    NSMutableArray *resultContacts = [[NSMutableArray alloc] initWithCapacity:4];
    
    for (NSDictionary *contact in contacts) {
        NSString *name = [contact objectForKey:fields[0]];
        NSString *surname = [contact objectForKey:fields[1]];
        NSString *phone = [contact objectForKey:fields[2]];
        NSString *email = [contact objectForKey:fields[3]];
        NSString *url = [contact objectForKey:fields[4]];
        
        [resultContacts addObject:createContact(name,surname,phone,email,url)];
    }

    NSArray * result = resultContacts;
    return [[ADBContactList alloc] initWithArray:result];

}

@end
