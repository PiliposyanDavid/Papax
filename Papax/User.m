//
//  User.m
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "User.h"

@interface User ()

@property (nonatomic) NSString *userId;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *email;
@property (nonatomic) NSURL *photoUrl;
@property (nonatomic) CLLocationCoordinate2D homeLocation;
@property (nonatomic) BOOL isActive;
@property (nonatomic) Car *car;

@end

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if(dictionary[@"_id"]) {
            self.userId = [dictionary[@"_id"] description];
        }
        if(dictionary[@"phone"]) {
            self.phone = [dictionary[@"phone"] description];
        }
        if(dictionary[@"email"]) {
            self.email = [dictionary[@"email"] description];
        }
        if(dictionary[@"photo"]) {
            self.photoUrl = [NSURL URLWithString:[dictionary[@"photo"] description]];
        }
        if(dictionary[@"home_location"]) {
            NSDictionary *loc = dictionary[@"home_location"];
            self.homeLocation = CLLocationCoordinate2DMake([loc[@"latitude"] integerValue], [loc[@"longitude"] integerValue]);
        }
        if(dictionary[@"isActive"]) {
            self.isActive = [dictionary[@"isActive"] boolValue];
        }
        if(dictionary[@"car"]) {
            self.car = [[Car alloc] initWithDictionary:dictionary[@"car"]];
        }
        if (dictionary[@"type"]) {
            self.type = [dictionary[@"type"] description];
        }
    }
    return self;
}


#pragma mark - Coding

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.photoUrl forKey:@"photoUrl"];
    [encoder encodeObject:@(self.homeLocation.latitude) forKey:@"homeLocation.latitude"];
    [encoder encodeObject:@(self.homeLocation.longitude) forKey:@"homeLocation.longitude"];
    [encoder encodeObject:@(self.isActive) forKey:@"isActive"];
    [encoder encodeObject:self.car forKey:@"car"];
    [encoder encodeObject:self.type forKey:@"type"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.photoUrl = [decoder decodeObjectForKey:@"photoUrl"];
        double latitude = [[decoder decodeObjectForKey:@"homeLocation.latitude"] doubleValue];
        double longitude = [[decoder decodeObjectForKey:@"homeLocation.longitude"] doubleValue];
        self.homeLocation = CLLocationCoordinate2DMake(latitude, longitude);
        self.isActive = [[decoder decodeObjectForKey:@"isActive"] boolValue];
        self.car = [decoder decodeObjectForKey:@"car"];
        self.type = [decoder decodeObjectForKey:@"type"];
    }
    return self;
}

- (BOOL)isDriver {
    return [self.type isEqualToString:@"driver"];
}

@end
