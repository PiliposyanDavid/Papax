//
//  NetworkingManager.m
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "NetworkingManager.h"
#import <AFNetworking.h>

@interface NetworkingManager ()

@property (nonatomic) AFURLSessionManager *sessionManager;
@property (nonatomic) AFHTTPSessionManager *httpSessionManager;

@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end


@implementation NetworkingManager

+ (instancetype)sharedInstance {
    static NetworkingManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        self.httpSessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        self.activityIndicatorView.center = keyWindow.center;
        [keyWindow addSubview:self.activityIndicatorView];
        
    }
    return self;
}

- (void)requestToPath:(NSString *)path method:(NSString *)method params:(NSDictionary *)params completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler {
    if (!path) {
        return;
    }
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method
                                                                                 URLString:[BASE_URL stringByAppendingString:path]
                                                                                parameters:params error:NULL];
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = NO;

    [[self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

        self.activityIndicatorView.hidden = YES;
        [self.activityIndicatorView stopAnimating];
        [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
 
        if (completionHandler) {
            completionHandler(response, responseObject, error);
        }

    }] resume];
}

- (void)loginWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password onSuccess:(SuccessBlock)success onFailure:(FailureBlock)failure {
    [self requestToPath:@"login"
                 method:@"POST"
                 params:@{@"phone" : phoneNumber,
                          @"password" : password}
      completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
          if(!error) {
//              NSDictionary * userData = [responseObject[@"data"] dictionaryByReplacingNullsWithStrings];
//              User *user = nil;
//              if([userId isEqualToString:[PSUser sharedInstance].userId]) {
//                  [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"user"];
//                  [[NSUserDefaults standardUserDefaults] synchronize];
//                  [PSUser loadUser];
//                  user = [PSUser sharedInstance];
//              } else {
//                  user = [MTLJSONAdapter modelOfClass:PSUser.class fromJSONDictionary:userData error:NULL];
//              }
              if(success) {
                  success(responseObject);
              }
          } else {
              if(failure) {
                  failure(error);
              }
          }
      }];
}

- (void)registerDriverWithBody:(NSDictionary *)body onSuccess:(SuccessBlock)success onFailure:(FailureBlock)failure {
    [self requestToPath:@"driver/signup"
                 method:@"POST"
                 params:body
      completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
          if(!error) {
              if(success) {
                  success(responseObject);
              }
          } else {
              if(failure) {
                  failure(error);
              }
          }
      }];
}

- (void)registerPassengerWithBody:(NSDictionary *)body onSuccess:(SuccessBlock)success onFailure:(FailureBlock)failure {
    [self requestToPath:@"passenger/signup"
                 method:@"POST"
                 params:body
      completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
          if(!error) {
              if(success) {
                  success(responseObject);
              }
          } else {
              if(failure) {
                  failure(error);
              }
          }
      }];
}

- (void)createRideWithBody:(NSDictionary *)body onSuccess:(SuccessBlock)success onFailure:(FailureBlock)failure {
    [self requestToPath:@"driver/ride"
                 method:@"POST"
                 params:body
      completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
          if(!error) {
              if(success) {
                  success(responseObject);
              }
          } else {
              if(failure) {
                  failure(error);
              }
          }
      }];
}

@end
