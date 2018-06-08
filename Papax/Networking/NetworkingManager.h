//
//  NetworkingManager.h
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASE_URL @"http://api.picsartstage.com/consume/"

typedef void (^SuccessBlock)(id result);
typedef void (^FailureBlock)(NSError *error);

@interface NetworkingManager : NSObject

+ (instancetype)sharedInstance;
- (void)requestToPath:(NSString *)path method:(NSString *)method params:(NSDictionary *)params completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;


- (void)loginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password onSuccess:(SuccessBlock)success onFailure:(FailureBlock)failure;

@end
