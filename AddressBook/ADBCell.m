//
//  Cell.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBCell.h"
#import "ADBImage.h"
#import "ADBContact.h"
#import "Masonry.h"

NSString *const ADBCellIdentifier = @"ADBCellIdentifier";

@interface ADBCell()
@property (nonatomic, strong) UILabel *Name;
@property (nonatomic, strong) UILabel *Surname;
@property (nonatomic, strong) ADBImage *Info;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ADBCell

-(instancetype) initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

-(void) createSubviews {
    self.Info = [ADBImage new];
    self.Name = [UILabel new];
    self.Surname = [UILabel new];
    
    [self addSubview:self.Name];
    [self addSubview:self.Surname];
    [self addSubview:self.Info];
    
    [self.Info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(5);
        make.top.equalTo(self.mas_top).with.offset(3);
        make.width.equalTo(@(self.frame.size.height));
        make.bottom.equalTo(self.mas_bottom).with.offset(-3);
        make.height.equalTo(@40);
    }];
    
    self.Info.layer.cornerRadius = self.frame.size.height / 2;
    self.Info.clipsToBounds = YES;
    
    [self.Name setTextAlignment:NSTextAlignmentCenter];
    [self.Surname setTextAlignment:NSTextAlignmentCenter];
    
    [self.Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Info.mas_right).with.offset(10);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.Surname.mas_top);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.width.greaterThanOrEqualTo(@100).with.priorityHigh();
    }];
    
    [self.Surname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.Info.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.Name.mas_width);
        make.right.equalTo(self.mas_right).with.offset(-20);
    }];
    
}

-(void) loadImage: (NSString *)url {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                       NSURL *imageURL = [NSURL URLWithString:url];
                       __block NSData *imageData;
                       dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                         imageData = [NSData dataWithContentsOfURL:imageURL];
                                         dispatch_sync(dispatch_get_main_queue(), ^{
                                             self.Info.image = [UIImage imageWithData:imageData];
                                         });
                                     });
                   });
}

-(instancetype) initWithName: (NSString *)name AndSurname: (NSString *)surname andURL: (NSString *)url {
    self = [super init];
    
    if (self) {
        [self createSubviews];
        NSString *initUrl = url ? url : @"https://cdn.fstoppers.com/styles/large/s3/wp-content/uploads/2014/03/Austin-Rogers_Fstoppers_Putin_Time_Man_Of_The_Year_CNN_Cover.jpg";
        
        [self loadImage:initUrl];
        self.Name.text = name;
        self.Surname.text = surname;

    }
    return self;
}

-(void) addContact: (ADBContact *)contact {
    self.Name.text = contact.firstName;
    self.Surname.text = contact.lastName;
    
    NSString *initUrl = contact.photoURL ? contact.photoURL : @"https://cdn.fstoppers.com/styles/large/s3/wp-content/uploads/2014/03/Austin-Rogers_Fstoppers_Putin_Time_Man_Of_The_Year_CNN_Cover.jpg";
    [self loadImage:initUrl];
}

@end
