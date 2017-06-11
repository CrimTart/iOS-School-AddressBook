//
//  ADBFaceBookViewController.h
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADBViewManager.h"

@interface ADBFaceBookViewController : UIViewController
-(instancetype) initWithViewManager: (id<ADBViewManager>)viewManager;
@end
