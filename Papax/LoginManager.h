//
//  LoginManager.h
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkingManager.h"
#import "User.h"

@interface LoginManager : NSObject

+ (instancetype)sharedInstance;

- (void)loginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password onSuccess:(SuccessBlock)success onFailure:(FailureBlock)failure;


@property (nonatomic, readonly) User *currentUser;

- (void)saveUser:(User *)user;

@end
