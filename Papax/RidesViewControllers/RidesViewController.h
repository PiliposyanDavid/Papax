//
//  RidesViewController.h
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RidesViewController : UIViewController

@property (nonatomic, copy) void (^closeBlock)(NSString *name, CLLocationCoordinate2D location);

@end
