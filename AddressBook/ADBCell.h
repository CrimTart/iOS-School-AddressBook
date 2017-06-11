//
//  Cell.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADBContact.h"

extern NSString *const ADBCellIdentifier;

@interface ADBCell : UITableViewCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)reuseIdentifier;
-(instancetype) initWithName: (NSString *)name AndSurname: (NSString *)surname andURL: (NSString *)url;
-(void) addContact: (ADBContact *)contact;
@end
