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
#import "ShareTaxiViewController.h"

@interface PassangerRidesViewController ()

@property (nonatomic) GMSMapView *mapContainerView;

@end

@implementation PassangerRidesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self recreateViewController];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -10)];
    
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"Share a Taxi";
    
    // Do any additional setup after loading the view.
}

- (void)recreateViewController {
    UIViewController *vc1 = nil;
    UIViewController *vc2 = nil;
    UIViewController *vc3 = nil;
    
    if ([LoginManager sharedInstance].currentUser.isDriver) {
        //DriverRidesViewController *vc1 = [[DriverRidesViewController alloc] init];
        if (self.mapContainerView) {
            vc1 = [[DriverRidesViewController alloc] init];
        } else {
            vc1 = [[ShareTaxiViewController alloc] initWithBlock:^(GMSMapView *mapContainerView) {
                self.mapContainerView = mapContainerView;
                [self recreateViewController];
            }];
        }
        vc2 = [[DriverRidesViewController alloc] init];
        vc3 = [ShareTaxiViewController new];
    } else {
        //DriverRidesViewController *vc1 = [[DriverRidesViewController alloc] init];
        vc1 = [DriverRidesViewController new];
        vc2 = [[DriverRidesViewController alloc] init];
        vc3 = [ShareTaxiViewController new];
    }
    
    vc1.title = @"To work";
    vc2.title = @"From lunch";
    vc3.title = @"From work";
    
    NSArray *controllers = @[vc1, vc2, vc3];
    
    // populate our tab bar controller with the above
    [self setViewControllers:controllers animated:YES];
}

@end
