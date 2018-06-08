//
//  RegistrationCarInfo.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "RegistrationCarInfo.h"
#import "CorneredTextField.h"

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
    // Do any additional setup after loading the view.
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
    
}

@end
