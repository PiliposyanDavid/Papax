//
//  RegistrationViewController.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "RegistrationViewController.h"
#import "CorneredTextField.h"
#import "LoginManager.h"
#import "RidesViewController.h"
#import "ShareTaxiViewController.h"

@interface RegistrationViewController ()

@property (weak, nonatomic) IBOutlet CorneredTextField *emailTextField;
@property (weak, nonatomic) IBOutlet CorneredTextField *passwordTextField;

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}

#pragma mark - Actions

- (IBAction)loginButtonPressed:(UIButton *)sender {
    
    ShareTaxiViewController *vc = [ShareTaxiViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
    
    
    
    [[LoginManager sharedInstance] loginWithPhoneNumber:self.emailTextField.text password:self.passwordTextField.text onSuccess:^(id result) {
        UIViewController *vc = [RidesViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } onFailure:^(NSError *error) {
        
    }];
}


#pragma mark - Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
