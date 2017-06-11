//
//  ADBImage.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBImage.h"

@implementation ADBImage

-(instancetype) initWithURL: (NSURL *)url {
    self = [super init];
    CIImage *img = [[CIImage alloc] initWithContentsOfURL:url];
    self.image = [[UIImage alloc] initWithCIImage:img scale:1.0 orientation:UIImageOrientationUp];
    return self;
}

@end
