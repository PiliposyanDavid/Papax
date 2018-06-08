//
//  CorneredTextField.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "CorneredTextField.h"

@implementation CorneredTextField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderColor:[UIColor colorWithRed:168.f/255.f green:182.f/255.f blue:200.f/255.f alpha:1].CGColor];
        [self.layer setBorderWidth:1.0];
        [self.layer setCornerRadius:25.0f];
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        self.borderStyle = UITextBorderStyleRoundedRect;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 50, 10);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 50, 10);
}

@end
