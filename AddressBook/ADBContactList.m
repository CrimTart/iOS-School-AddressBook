//
//  ADBContactList.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBContactList.h"
#import "ADBContact.h"

@interface ADBContactList()

@property (nonatomic, copy, readwrite) NSArray *contacts;

@end

@implementation ADBContactList

-(instancetype) initWithArray: (NSArray<ADBContact *> *)contacts {
    self = [super init];
    if (self) {
        _contacts = contacts;
    }
    return self;
}

-(NSUInteger) count {
    return self.contacts.count;
}

-(ADBContact*) objectAtIndexedSubscript: (NSUInteger)index {
    return self.contacts[index];
}

@end
