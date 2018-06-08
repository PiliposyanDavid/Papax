//
//  NetworkingManager.h
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASE_URL @"http://api.picsartstage.com/consume/"

@interface NetworkingManager : NSObject

+ (instancetype)sharedInstance;

@end
