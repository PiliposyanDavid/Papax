//
//  RegistrationCarInfo.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "RegistrationCarInfo.h"

@interface RegistrationCarInfo () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *avatarView;
@property (weak, nonatomic) IBOutlet UIImageView *cameraIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *imagePickerButton;

@end

@implementation RegistrationCarInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.avatarView bringSubviewToFront:self.cameraIconImageView];
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

@end
