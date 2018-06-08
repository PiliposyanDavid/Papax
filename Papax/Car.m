//
//  Car.m
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "Car.h"

@interface Car ()

@property (nonatomic) NSString *model;
@property (nonatomic) NSString *color;
@property (nonatomic) NSString *number;
@property (nonatomic) NSInteger seatsCount;

@end

@implementation Car

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if(dictionary[@"model"]) {
            self.model = [dictionary[@"model"] description];
        }
        if(dictionary[@"color"]) {
            self.color = [dictionary[@"color"] description];
        }
        if(dictionary[@"number"]) {
            self.number = [dictionary[@"number"] description];
        }
        if(dictionary[@"seatsCount"]) {
            self.seatsCount = [[dictionary[@"seatsCount"] description] integerValue];
        }
    }
    return self;
}



#pragma mark - Coding

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.model forKey:@"model"];
    [encoder encodeObject:self.color forKey:@"color"];
    [encoder encodeObject:self.number forKey:@"number"];
    [encoder encodeObject:@(self.seatsCount) forKey:@"seatsCount"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.model = [decoder decodeObjectForKey:@"model"];
        self.color = [decoder decodeObjectForKey:@"color"];
        self.number = [decoder decodeObjectForKey:@"number"];
        self.seatsCount = [[decoder decodeObjectForKey:@"seatsCount"] integerValue];
    }
    return self;
}

@end
