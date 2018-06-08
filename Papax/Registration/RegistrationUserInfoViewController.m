//
//  RegistrationUserInfoViewController.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "RegistrationUserInfoViewController.h"
#import "CorneredTextField.h"
#import "RegInfoObject.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "GradientButton.h"
#import "UtilMethods.h"

@interface RegistrationUserInfoViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet CorneredTextField *nameField;
@property (weak, nonatomic) IBOutlet CorneredTextField *phoneField;
@property (weak, nonatomic) IBOutlet CorneredTextField *password;

@property (nonatomic) MBProgressHUD *HUD;
@property (weak, nonatomic) IBOutlet GradientButton *signupButton;

@end

@implementation RegistrationUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.delegate = self;
    self.phoneField.delegate = self;
    self.password.delegate = self;
    // Do any additional setup after loading the view.
}
- (IBAction)signUpAction:(id)sender {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.nameField) { //email
        if (![textField.text containsString:@"picsart"]) {
            [UtilMethods showMessageAlert:@"Mail is incorrect" andMessage:@"" fromViewController:self action:^{
                self.nameField.text = @"";
            }];
        } else {
            [RegInfoObject sharedInstance].regInfo[@"email"] = textField.text;
        }
    } else if(textField == self.phoneField) {
        [RegInfoObject sharedInstance].regInfo[@"phone"] = textField.text;
    } else if (textField == self.password) {
        [RegInfoObject sharedInstance].regInfo[@"password"] = textField.text;
    }
    self.signupButton.enabled = (self.nameField.text.length && self.phoneField.text.length && self.password.text.length);
    [[RegInfoObject sharedInstance] fillLocation:CLLocationCoordinate2DMake(894239408293, 4982349)];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent* )event {
    [self.view endEditing:YES];
}

@end

