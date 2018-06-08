//
//  RegistrationCarInfo.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "RegistrationCarInfo.h"
#import "CorneredTextField.h"
#import "RegInfoObject.h"
#import "GradientButton.h"
#import "NetworkingManager.h"
#import "UtilMethods.h"
#import "RidesViewController.h"

@interface RegistrationCarInfo () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *avatarView;
@property (weak, nonatomic) IBOutlet UIImageView *cameraIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *imagePickerButton;
@property (weak, nonatomic) IBOutlet UIButton *imDriverButton;
@property (weak, nonatomic) IBOutlet UIButton *imPassangerButton;

@property (weak, nonatomic) IBOutlet UIView *passangerContainer;
@property (weak, nonatomic) IBOutlet UIView *driverContainer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CorneredTextField *nameField;
@property (weak, nonatomic) IBOutlet CorneredTextField *numberField;
@property (weak, nonatomic) IBOutlet CorneredTextField *colorField;
@property (weak, nonatomic) IBOutlet CorneredTextField *modelField;
@property (weak, nonatomic) IBOutlet CorneredTextField *seatsCountField;

@property (weak, nonatomic) IBOutlet CorneredTextField *passangerNameField;
@property (weak, nonatomic) IBOutlet GradientButton *passangerStartCarpoolButton;


@property (weak, nonatomic) IBOutlet GradientButton *startCarpoolButton;

@end

@implementation RegistrationCarInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.avatarView bringSubviewToFront:self.cameraIconImageView];
    self.nameField.delegate = self;
    self.numberField.delegate = self;
    self.colorField.delegate = self;
    self.modelField.delegate = self;
    self.seatsCountField.delegate = self;
    self.passangerNameField.delegate = self;
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (IBAction)imagePicker:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 0.5);
    NSString* imageStr = [[NSString alloc] initWithData:imageData encoding:NSASCIIStringEncoding];
    if (imageStr) {
        [RegInfoObject sharedInstance].regInfo[@"photo"] = imageStr;
    }

    [self.imagePickerButton setImage:chosenImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)imDriverAction:(id)sender {
    self.imDriverButton.selected = !self.imDriverButton.selected;
    self.imPassangerButton.selected = !self.imPassangerButton.selected;
    self.passangerContainer.hidden = YES;
    self.driverContainer.hidden = NO;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 867);
}

- (IBAction)im_passanger_action:(id)sender {
    self.imDriverButton.selected = !self.imDriverButton.selected;
    self.imPassangerButton.selected = !self.imPassangerButton.selected;
    self.passangerContainer.hidden = NO;
    self.driverContainer.hidden = YES;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 700);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.nameField.delegate = self;
    self.numberField.delegate = self;
    self.colorField.delegate = self;
    self.modelField.delegate = self;
    self.seatsCountField.delegate = self;
    
    if (textField == self.nameField) { //email
        [RegInfoObject sharedInstance].regInfo[@"name"] = textField.text;
    } else if(textField == self.numberField) {
        [[RegInfoObject sharedInstance] fillCarWithName:@"number" value:textField.text];
    } else if (textField == self.colorField) {
        [[RegInfoObject sharedInstance] fillCarWithName:@"color" value:textField.text];
    } else if (textField == self.modelField) {
        [[RegInfoObject sharedInstance] fillCarWithName:@"model" value:textField.text];
    } else if (textField == self.seatsCountField) {
        [[RegInfoObject sharedInstance] fillCarWithName:@"seats_count" value:textField.text];
    } else if (textField == self.passangerNameField) {
        [RegInfoObject sharedInstance].regInfo[@"name"] = textField.text;
    }
    
    if (self.imDriverButton.selected) {
        self.startCarpoolButton.enabled = (self.nameField.text.length && self.numberField.text.length &&  self.modelField.text.length && self.seatsCountField.text.length);
    } else {
        self.passangerStartCarpoolButton.enabled = self.passangerNameField.text.length;
    }
}

-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self.view endEditing:YES];
}

- (IBAction)startCarpoolAction:(id)sender {
        [[NetworkingManager sharedInstance] registerDriverWithBody:[RegInfoObject sharedInstance].regInfo onSuccess:^(id result) {
            if ([result[@"status"] isEqualToString:@"error"]) {
                [UtilMethods showMessageAlert:result[@"message"] andMessage:@"" fromViewController:self action:^{
                    
                }];
            } else {
                RidesViewController *activeViewController = [[RidesViewController alloc] init];
                self.navigationController.viewControllers = @[activeViewController];
                self.navigationController.navigationBar.hidden = NO;
            }
        } onFailure:^(NSError *error) {
            
        }];
}
- (IBAction)passangerCarpoolAction:(id)sender {
    [[NetworkingManager sharedInstance] registerPassengerWithBody:[RegInfoObject sharedInstance].regInfo onSuccess:^(id result) {
        if ([result[@"status"] isEqualToString:@"error"]) {
            [UtilMethods showMessageAlert:result[@"message"] andMessage:@"" fromViewController:self action:^{
                
            }];
        } else {
            RidesViewController *activeViewController = [[RidesViewController alloc] init];
            self.navigationController.viewControllers = @[activeViewController];
        }
    } onFailure:^(NSError *error) {
        
    }];
}

@end
