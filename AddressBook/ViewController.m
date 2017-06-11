//
//  ViewController.m
//  AddressBook
//
//  Created by Admin on 01.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "ViewController.h"
#import "ADBCell.h"
#import "DetailInformation.h"
#import "ADBContactList.h"
#import "ADBVkontakteDataBase.h"
#import "ADBAddressBookDataBase.h"
#import "ADBFacebookDataBase.h"
#import "ADBContact.h"
#import "VKVMainViewController.h"
#import "ADBFaceBookViewController.h"
#import "ADBViewManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Masonry.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ADBViewManager>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) ADBContactList *contacts;
@property (nonatomic, strong) id<ADBDataBaseDriver> contactManager;

@end

@implementation ViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"VK", @"Facebook", @"Address Book", nil]];
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentedControl;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.contactManager getContacts:self];
    [self.tableView registerClass:[ADBCell class] forCellReuseIdentifier:ADBCellIdentifier];
}

-(NSInteger) tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return self.contacts.count;
}

-(UITableViewCell *) tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    UITableViewCell *cell = (ADBCell *)[tableView dequeueReusableCellWithIdentifier:ADBCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ADBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADBCellIdentifier];
    }
    ADBContact *contact = [self.contacts objectAtIndexedSubscript:indexPath.row];
    [(ADBCell *)cell addContact:contact];
    return cell;
}

-(void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ADBContact *cont = [self.contacts objectAtIndexedSubscript:indexPath.row];
    NSString *firstName = cont.firstName;
    NSString *lastName = cont.lastName;
    NSString *phone = cont.phone;
    NSString *url = cont.photoURL;
    DetailInformation *detailInfo = [[DetailInformation alloc] initWithName:firstName                                                                       surname:lastName andPhone:phone andUrl:url];
    detailInfo.view.backgroundColor = [UIColor whiteColor];
    detailInfo.navigationItem.title = [NSString stringWithFormat:@"%ld", indexPath.row];
    [self.navigationController pushViewController:detailInfo animated:YES];
}

-(CGFloat) tableView: (UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath {
    return 50;
}

-(instancetype) initWithContactManager: (id<ADBDataBaseDriver>)contactManager {
    self = [super init];
    if (self) {
        self.contactManager = contactManager;
    }
    return self;
}

-(void) reloadData {
    [self.contactManager getContacts:self];
}

-(void) updateContacts: (ADBContactList *)newContacts {
    self.contacts = newContacts;
}

-(void) reloadTable {
    [self.tableView reloadData];
}

-(void) goToRootViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) segmentAction: (UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    NSString* accessToken;
    switch (index) {
        case 0: //VK
            self.contactManager = [ADBVkontakteDataBase new];
            accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKAccessToken"];
            break;
        case 1: //FB
            self.contactManager = [ADBFacebookDataBase new];
            break;
        case 2: //Address Book
            self.contactManager = [ADBAddressBookDataBase new];
            break;
        default:
            break;
    }
    if((index == 0) && (accessToken == nil)) {
        VKVMainViewController *vkViewController=[[VKVMainViewController alloc] initWithViewManager:self];;
        [self.navigationController pushViewController:vkViewController animated:YES];
    }
    else if((index == 1) && !([FBSDKAccessToken currentAccessToken])) {
        ADBFaceBookViewController *fbViewController = [[ADBFaceBookViewController alloc] initWithViewManager:self];
        [self.navigationController pushViewController:fbViewController animated:YES];
    }
    else [self reloadData];
}

@end
