//
//  ADBVkontakteDataBase.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBVkontakteDataBase.h"
#import "ADBJsonDataBase.h"
#import "ADBContactList.h"
#import "ADBContact.h"
#import "VKVMainViewController.h"
#import "ViewController.h"

@implementation ADBVkontakteDataBase

-(void) getContacts: (id<ADBViewManager>) viewManager {
    NSArray * fields = @[
                         @"first_name",
                         @"last_name",
                         @"home_phone",
                         @"nickname",
                         @"photo_100"
                         ];
    NSString* accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
    NSString* userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    NSString*url = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&fields=nickname,contacts,photo_100&%@",userID,accessToken];
    NSURLRequest *nsurlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    __block NSData *responseData = [NSURLConnection sendSynchronousRequest:nsurlRequest returningResponse:nil error:nil];
    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *downloadTask = [session dataTaskWithRequest:nsurlRequest
                                                    completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error) {
                                                        responseData = data;
                                                        ADBContactList * contacts = [[ADBJsonDataBase new] getContacts:responseData
                                                                                                             forFields:fields];
                                                        [viewManager updateContacts:contacts];
                                                        [viewManager reloadTable];
                                                    }];
    
    [downloadTask resume];
}

@end
