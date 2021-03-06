//
//  LoginManager.m
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "LoginManager.h"
#import "UtilMethods.h"

#define kSavedUser @"kSavedUser"


@interface LoginManager ()

@property (nonatomic) User *currentUser;

@end

@implementation LoginManager

static LoginManager *sharedMyManager = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"kSavedUser"];
        sharedMyManager.currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    });
    return sharedMyManager;
}

- (void)loginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password onSuccess:(SuccessBlock)success onFailure:(FailureBlock)failure {
    [[NetworkingManager sharedInstance] loginWithPhoneNumber:phoneNumber password:password onSuccess:^(id result) {
        if (![result[@"status"] isEqualToString:@"error"]) {
            self.currentUser = [[User alloc] initWithDictionary:result[@"data"]];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if (self.currentUser) {
                NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.currentUser];
                [defaults setObject:encodedObject forKey:kSavedUser];
            } else {
                [defaults removeObjectForKey:kSavedUser];
            }
        }
            
            if (success) {
                success(result);
            }
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)saveUser:(User *)user {
    sharedMyManager.currentUser = user;
}

@end
