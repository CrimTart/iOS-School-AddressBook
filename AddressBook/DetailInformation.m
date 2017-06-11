//
//  DetailInformation.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "DetailInformation.h"
#import "ADBCell.h"
#import "Masonry.h"


@interface DetailInformation()

@property (nonatomic, strong) ADBCell *cell;
@property (nonatomic, strong) UILabel *phone;

@end

@implementation DetailInformation

-(instancetype)initWithName: (NSString *) name surname: (NSString *)surname andPhone: (NSString *) phone andUrl: (NSString *)url {
    self = [super init];
    
    if (self) {
        self.cell = [[ADBCell alloc] initWithName:name AndSurname:surname andURL:url];
        self.phone = [UILabel new];
        
        [self.view addSubview:self.cell];
        [self.view addSubview:self.phone];
        
        [self.cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(100);
            make.left.equalTo(self.view.mas_left).with.offset(20);
            make.right.equalTo(self.view.mas_right).with.offset(-20);
        }];
        
        [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cell.mas_bottom).with.offset(10);
            make.left.equalTo(self.view.mas_left).with.offset(20);
            make.right.equalTo(self.view.mas_right).with.offset(-20);
        }];
        
        self.phone.text = phone;
        [self.phone setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}

-(instancetype)init {
    self = [super init];
    return self;
}

@end
