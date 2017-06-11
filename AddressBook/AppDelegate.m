//
//  AppDelegate.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "AppDelegate.h"
#import "ADBPathFileJsonDataBase.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "ViewController.h"

@implementation AppDelegate

-(BOOL) application: (UIApplication *)application didFinishLaunchingWithOptions: (NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    ViewController *vc = [[ViewController alloc] initWithContactManager:[ADBPathFileJsonDataBase new]];
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    window.rootViewController = navigationController;
    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

-(BOOL) application: (UIApplication *)application openURL: (NSURL *)url
            options: (NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance]
                    application:application
                    openURL:url
                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                    annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    return handled;
}

-(void) applicationDidBecomeActive: (UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

@end
