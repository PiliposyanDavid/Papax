//
//  AppDelegate.m
//  Papax
//
//  Created by VA on 6/7/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "AppDelegate.h"
#import "RidesViewController.h"
#import "UtilMethods.h"
#import <GooglePlaces/GooglePlaces.h>
#import "LoginManager.h"
#import "User.h"
#import "PassangerRidesViewController.h"

#define GOOGLE_API_KEY @"AIzaSyB6MZ5v0Kj6KdncBGeROfidNs-bWYub4_E"

@import GoogleMaps;

@interface AppDelegate ()

@property (nonatomic) UINavigationController *rootNavigationController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:GOOGLE_API_KEY];
    [GMSPlacesClient provideAPIKey:GOOGLE_API_KEY];
    
    [self updateRootNavigationController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.rootNavigationController;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    
    return YES;
}

- (void)updateRootNavigationController {
    BOOL isLogedIn = [LoginManager sharedInstance].currentUser;
    
    UIViewController *activeViewController = nil;
        if (isLogedIn) {
            activeViewController = [[PassangerRidesViewController alloc] init];
        } else {
            activeViewController = [UtilMethods VCFromStoryBoardWithName:@"Registration" viewControllerID:@"Registration"];
        }
        
        if (!self.rootNavigationController) {
            self.rootNavigationController = [[UINavigationController alloc]initWithRootViewController:activeViewController];
        } else {
            //logout case
            NSArray *vcs = self.rootNavigationController.viewControllers;
                NSMutableArray *newVcs = [NSMutableArray arrayWithArray:vcs];
                [newVcs insertObject:activeViewController atIndex:0];
                self.rootNavigationController.viewControllers = newVcs;
        }
    
//        [self.rootNavigationController popToRootViewControllerAnimated:YES];
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"]) {
//            [self.rootNavigationController setNavigationBarHidden:YES animated:NO];
//        } else {
//            [self.rootNavigationController setNavigationBarHidden:NO animated:NO];
//        }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
