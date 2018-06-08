//
//  GradientView.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "GradientView.h"

@interface GradientView ()

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;

@end

@implementation GradientView

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initGradientView];
    }
    return self;
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initGradientView];
    }
    return self;
}

-(void)initGradientView {
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGGradientRef gradient = [self newGradientWithColors:_colors locations:_locations];
    if (CGPointEqualToPoint(self.startPoint, CGPointZero) &&
        CGPointEqualToPoint(self.endPoint, CGPointZero)) {
        self.startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
        self.endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    }
    CGContextDrawLinearGradient(context, gradient, self.startPoint, self.endPoint, 0);
    CGGradientRelease(gradient);
}

- (CGGradientRef)newGradientWithColors:(NSArray*)colorsArray locations:(NSArray*)locationsArray {
    
    NSInteger count = [colorsArray count];
    
    CGFloat* components = malloc(sizeof(CGFloat)*4*count);
    CGFloat* locations = malloc(sizeof(CGFloat)*count);
    
    for (int i = 0; i < count; ++i) {
        CGColorRef color = (__bridge CGColorRef)[colorsArray objectAtIndex:i];
        NSNumber* location = (NSNumber*)[locationsArray objectAtIndex:i];
        size_t n = CGColorGetNumberOfComponents(color);
        const CGFloat* rgba = CGColorGetComponents(color);
        if (n == 2) {
            components[i*4] = rgba[0];
            components[i*4+1] = rgba[0];
            components[i*4+2] = rgba[0];
            components[i*4+3] = rgba[1];
        } else if (n == 4) {
            components[i*4] = rgba[0];
            components[i*4+1] = rgba[1];
            components[i*4+2] = rgba[2];
            components[i*4+3] = rgba[3];
        }
        locations[i] = [location floatValue];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef space = CGBitmapContextGetColorSpace(context);
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, count);
    free(components);
    free(locations);
    return gradient;
}

- (void)setStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint {
    self.startPoint = startPoint;
    self.endPoint = endPoint;
}

@end
