//
//  ADBFacebookDataBase.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBFacebookDataBase.h"
#import "ADBContactList.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "ADBJsonDataBase.h"
#import "ADBContact.h"
#import "ViewController.h"
#import "ADBViewManager.h"

@interface ADBFacebookDataBase()

@property (nonatomic, strong) id<ADBViewManager> viewManager;

@end

@implementation ADBFacebookDataBase


-(void) getContacts: (id<ADBViewManager>)viewManager {
    NSArray *fields = @[
                         @"first_name",
                         @"last_name",
                         @"",
                         @"id",
                         @"picture"
                         ];
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
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc]
          initWithGraphPath:@"/me"
          parameters:@{ @"fields": @"id,name,taggable_friends{first_name,last_name,picture}",}
          HTTPMethod:@"GET"] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                NSDictionary *contacts = [[result objectForKey:@"taggable_friends"] objectForKey:@"data"];
                NSMutableArray *resultContacts = [NSMutableArray new];
                for (NSDictionary *contact in contacts) {
                    NSString *name = [contact objectForKey:fields[0]];
                    NSString *surname = [contact objectForKey:fields[1]];
                    NSString *phone = [contact objectForKey:fields[2]];
                    NSString *email = [contact objectForKey:fields[3]];
                    
                    NSDictionary *url1 = [contact objectForKey:fields[4]];
                    NSDictionary *url2 = [url1 objectForKey:@"data"];
                    NSString *url = [ url2 objectForKey:@"url"];
                    
                    [resultContacts addObject:createContact(name,surname,phone,email,url)];
                }
                [viewManager updateContacts:[[ADBContactList alloc] initWithArray:resultContacts]];
                [viewManager reloadTable];
            }
        }];
    }
}

@end
