//
//  RegInfoObject.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "RegInfoObject.h"

@interface RegInfoObject ()

@property (nonatomic) NSMutableDictionary *car;

@end

@implementation RegInfoObject

+ (instancetype)sharedInstance {
    static RegInfoObject *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.regInfo = [[NSMutableDictionary alloc] init];
        sharedMyManager.regInfo[@"photo"] = @"blank";
        sharedMyManager.car = [[NSMutableDictionary alloc] init];
    });
    return sharedMyManager;
}

- (void)fillCarWithName:(NSString *)name value:(NSString *)value {
    self.car[name] = value;
    self.regInfo[@"car"] = self.car;
}

- (void)fillLocation:(CLLocationCoordinate2D)location {
    self.regInfo[@"home_location"] = @{@"latitude" : [NSString stringWithFormat:@"%@",@(location.latitude)], @"longitude": [NSString stringWithFormat:@"%@",@(location.longitude)]};
}


@end
