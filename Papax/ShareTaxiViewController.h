//
//  ShareTaxiViewController.h
//  Papax
//
//  Created by Tigran on 6/9/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareTaxiViewController : UIViewController

- (instancetype)initWithBlock:(void (^)(GMSMapView *mapContainerView))mapViewBlock;

@end
