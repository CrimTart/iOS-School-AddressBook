//
//  ADBAddressBookDataBase.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBAddressBookDataBase.h"
#import "ADBContactList.h"
#import "ADBContact.h"
#import <AddressBook/ABAddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ViewController.h"

@implementation ADBAddressBookDataBase

-(void) getContacts: (id<ADBViewManager>)viewManager {
    ADBContactList *contacts = [[ADBContactList alloc] initWithArray:[self getContactsWithAddressBook]];
    [viewManager updateContacts:contacts];
    [viewManager reloadTable];
}

-(NSMutableArray *) getContactsWithAddressBook {
    __block NSMutableArray *finalContactList = [[NSMutableArray alloc] init];
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    switch(authorizationStatus) {
        case kABAuthorizationStatusNotDetermined: {
            ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    // First time access has been granted, add the contact
                    finalContactList = [self getCBContacts];
                }
                else {
                    // User denied access
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                                    message:@"Access denied to address book."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
            });
        }
        break;
    
        case kABAuthorizationStatusAuthorized:
            // The user has previously given access, add the contact
            finalContactList = [self getCBContacts];
            break;
            
        case kABAuthorizationStatusRestricted:
        case kABAuthorizationStatusDenied: {
            // The user has previously denied access or can't give permission
            // Send an alert telling user to change privacy settings
                UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Warning!"
                                                                 message:@"Please allow the app to access address book."
                                                                delegate:nil
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
                [alert1 show];
            }
            break;
    }
    return finalContactList;
}

-(NSMutableArray *) getCBContacts {
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
    
    NSMutableArray *newContactArray = [[NSMutableArray alloc] init];
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    NSArray *arrayOfAllPeople = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSUInteger peopleCounter = 0;
    for (peopleCounter = 0; peopleCounter<arrayOfAllPeople.count; peopleCounter++) {
        ABRecordRef thisPerson = (__bridge ABRecordRef) arrayOfAllPeople[peopleCounter];
        NSString *name = (__bridge NSString *)(ABRecordCopyValue(thisPerson, kABPersonFirstNameProperty));
        NSString *surname = (__bridge NSString *)(ABRecordCopyValue(thisPerson, kABPersonLastNameProperty));
        ABMultiValueRef number = ABRecordCopyValue(thisPerson, kABPersonPhoneProperty);
        NSString *numbers = [self getItemStringFromABMultiValueRef:number];
        ABMultiValueRef email = ABRecordCopyValue(thisPerson, kABPersonEmailProperty);
        NSString *mails = [self getItemStringFromABMultiValueRef:email];
        [newContactArray addObject:createContact(name,surname,numbers,mails,@"")];
    }
    return newContactArray;
}

-(NSString *) getItemStringFromABMultiValueRef: (ABMultiValueRef)ref {
    NSString *items = @"";
    for (NSUInteger itemCounter = 0; itemCounter < ABMultiValueGetCount(ref); itemCounter++) {
        NSString *currentItem = (__bridge NSString *)ABMultiValueCopyValueAtIndex(ref, itemCounter);
        if ([currentItem length]!=0) {
            items = [items stringByAppendingString:[currentItem stringByAppendingString:@" "]];
        }
    }
    return items;
}

@end
