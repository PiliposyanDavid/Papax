//
//  RegInfoObject.h
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RegInfoObject : NSObject

+ (instancetype)sharedInstance;

- (void)fillCarWithName:(NSString *)name value:(NSString *)value;

- (void)fillLocation:(CLLocationCoordinate2D)location;

@property (nonatomic) NSMutableDictionary *regInfo;

@end
