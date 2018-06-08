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
    regInfo = [[NSMutableDictionary alloc] init];
    // Do any additional setup after loading the view.
}
- (IBAction)signUpAction:(id)sender {
    if (self.nameField.text.length && self.phoneField.text.length && self.password.text.length) {
        
    } else {
        [RegistrationUserInfoViewController showMessageAlert:@"Fill the fields" andMessage:@"" fromViewController:self action:^{
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.nameField) { //email
        if (![textField.text containsString:@"picsart"]) {
            [RegistrationUserInfoViewController showMessageAlert:@"Mail is incorrect" andMessage:@"" fromViewController:self action:^{
                self.nameField.text = @"";
            }];
        } else {
            regInfo[@"email"] = textField.text;
        }
    } else if(textField == self.phoneField) {
        regInfo[@"phone"] = textField.text;
    } else if (textField == self.password) {
        regInfo[@"password"] = textField.text;
    }
    self.signupButton.enabled = (self.nameField.text.length && self.phoneField.text.length && self.password.text.length);
}

+(void) showMessageAlert:(NSString *) title andMessage:(NSString*) msg fromViewController: (UIViewController*)viewController action:(void(^)(void))callback{
    
    UIAlertController *showMsgAlertController = [UIAlertController alertControllerWithTitle: title message: msg preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *showMsgAlertControllerOkAction = [UIAlertAction actionWithTitle:@"OK"  style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                                               if (callback) {
                                                                                   callback();
                                                                               }
                                                                           }];
    [showMsgAlertController addAction:showMsgAlertControllerOkAction];
        [viewController presentViewController:showMsgAlertController animated:YES completion:nil];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent* )event {
    [self.view endEditing:YES];
}

@end

