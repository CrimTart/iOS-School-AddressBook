//
//  ADBContact.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBContact.h"

@implementation ADBContact

-(BOOL) checkString: (NSString *)string withRegularExpression: (NSString *)regExp {
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regExp options:0 error:nil];
    NSTextCheckingResult *result = [expression firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    return (result.range.length == string.length);
}

-(BOOL) checkName: (NSString *)name {
    return [self checkString:name withRegularExpression:@"[A-Z][a-z]*"];
}

@end
