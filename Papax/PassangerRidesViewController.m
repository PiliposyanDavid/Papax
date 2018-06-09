//
//  PassangerRidesViewController.m
//  Papax
//
//  Created by VA on 6/9/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "PassangerRidesViewController.h"
#import "LoginManager.h"
#import "DriverRidesViewController.h"

@interface PassangerRidesViewController ()

@end

@implementation PassangerRidesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DriverRidesViewController *vc1 = [[DriverRidesViewController alloc] init];
    vc1.view.backgroundColor = [UIColor orangeColor];
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor greenColor];
    UIViewController *vc3 = [[UIViewController alloc] init];
    
    vc1.title = @"To work";
    vc2.title = @"From lunch";
    vc3.title = @"From work";
    
    NSArray *controllers = @[vc1, vc2, vc3];
    
    // populate our tab bar controller with the above
    [self setViewControllers:controllers animated:YES];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -10)];
    
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"Share a Taxi";
    
    // Do any additional setup after loading the view.
}

@end
