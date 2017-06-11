//
//  ADBContact.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADBContact : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *photoURL;

-(BOOL) checkString: (NSString *)string withRegularExpression: (NSString *)regExp;
-(BOOL) checkName: (NSString *)name;

@end
