//
//  ADBContactList.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADBContact;

@interface ADBContactList : NSObject

@property (nonatomic, readonly) NSUInteger count;

-(instancetype) initWithArray: (NSArray<ADBContact *> *)contacts;
-(ADBContact*) objectAtIndexedSubscript: (NSUInteger)index;

@end
