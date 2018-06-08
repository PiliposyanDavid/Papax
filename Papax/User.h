//
//  User.h
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import <CoreLocation/CoreLocation.h>


@interface User : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSString *userId;
@property (nonatomic, readonly) NSString *phone;
@property (nonatomic, readonly) NSString *email;
@property (nonatomic, readonly) NSURL *photoUrl;
@property (nonatomic, readonly) CLLocationCoordinate2D homeLocation;
@property (nonatomic, readonly) BOOL isActive;
@property (nonatomic, readonly) Car *car;
@property (nonatomic) NSString *type;
@property (nonatomic) BOOL isDriver;

@end
