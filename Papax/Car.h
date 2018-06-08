//
//  Car.h
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSString *model;
@property (nonatomic, readonly) NSString *color;
@property (nonatomic, readonly) NSString *number;
@property (nonatomic, readonly) NSInteger seatsCount;

@end
