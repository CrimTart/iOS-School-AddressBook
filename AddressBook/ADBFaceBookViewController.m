//
//  ADBFaceBookViewController.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ADBFaceBookViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ADBFaceBookViewController () <FBSDKLoginButtonDelegate>

@property (nonatomic, strong) FBSDKLoginButton *loginButton;
@property (nonatomic, strong) id<ADBViewManager> viewManager;

@end

@implementation ADBFaceBookViewController

-(instancetype) initWithViewManager: (id<ADBViewManager>)viewManager {
    self = [super init];
    if (self) {
        _viewManager = viewManager;
    }
    return self;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _loginButton = [[FBSDKLoginButton alloc] init];
    _loginButton.readPermissions = @[@"user_relationships", @"read_custom_friendlists", @"user_friends"];
    _loginButton.center = self.view.center;
    [self.view addSubview:_loginButton];
    _loginButton.delegate = self;
    
    
}

-(void) loginButton: (FBSDKLoginButton *)loginButton didCompleteWithResult: (FBSDKLoginManagerLoginResult *)result error: (NSError *)error {
    [self.viewManager reloadData];
    [self.viewManager goToRootViewController];
}

-(void) loginButtonDidLogOut: (FBSDKLoginButton *)loginButton {
    NSLog(@"loginButtonDidLogOut");
}


@end
