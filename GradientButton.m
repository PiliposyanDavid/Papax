//
//  GradientButton.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "GradientButton.h"
#import "GradientView.h"
#import "UtilMethods.h"

@interface GradientButton ()

@property (nonatomic) NSArray *colors;

@end

@implementation GradientButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.darkBlueVariant) {
        self.colors = @[(id)([UtilMethods colorFromHexString:@"#303D99"]).CGColor, (id)([UtilMethods colorFromHexString:@"#3478B9"]).CGColor];
    } else {
        self.colors = @[(id)([UtilMethods colorFromHexString:@"#42BFEA"]).CGColor, (id)([UtilMethods colorFromHexString:@"#77E1F6"]).CGColor];
    }
    
    GradientView *gradientView = [[GradientView alloc] initWithFrame:self.bounds];
    gradientView.userInteractionEnabled = NO;
    gradientView.locations = @[@0, @1];
    gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [gradientView setStartPoint:CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMidY(self.bounds))
                         andEndPoint:CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds))];
    gradientView.colors = self.colors;
    [self addSubview:gradientView];
    
    self.titleLabel.layer.zPosition = 100;
}

@end
