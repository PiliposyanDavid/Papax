//
//  DirectionService.h
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectionService : NSObject

- (void)setDirectionsQuery:(NSDictionary *)query withSelector:(SEL)selector withDelegate:(id)delegate;

@end
