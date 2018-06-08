//
//  RegistrationUserInfoViewController.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "RegistrationUserInfoViewController.h"
#import "CorneredTextField.h"

@interface RegistrationUserInfoViewController ()
@property (weak, nonatomic) IBOutlet CorneredTextField *nameField;
@property (weak, nonatomic) IBOutlet CorneredTextField *phoneField;
@property (weak, nonatomic) IBOutlet CorneredTextField *selectCompany;
@property (weak, nonatomic) IBOutlet CorneredTextField *companyKey;

@end

@implementation RegistrationUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
@end

