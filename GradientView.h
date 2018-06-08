//
//  GradientView.h
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *locations;

- (void)setStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint;

@end
