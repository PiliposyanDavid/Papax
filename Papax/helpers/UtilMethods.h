//
//  UtilMethods.h
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UtilMethods : NSObject

//+ (BOOL)isNotConnected;
//
//+ (BOOL)isValidEmail:(NSString *)email;
//
//+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber;
//
//+ (BOOL)isValidHashtag:(NSString *)hashtag;
//
//+ (UIColor *)colorFromHexString:(NSString *)hexString;
//
//+ (void)showProgressHudWithText:(NSString *)text OnView:(UIView *)view;
//
//+ (NSString *)encodeToBase64String:(UIImage *)image;

+ (UIViewController *)VCFromStoryBoardWithName:(NSString *)storyBoardName viewControllerID:(NSString *)identifier;

//+ (NSString *)safeSetString:(NSString *)string;
//
//+ (NSString *)validString:(NSString *)string;
//
//+ (UIAlertController *)showAlertControllerWithMessage:(NSString *)message ViewController:(UIViewController *)ViewController;
//
//+ (UIAlertController *)showAlertControllerWithMessage:(NSString *)message title:(NSString *)title ViewController:(UIViewController *)ViewController;
//
//+ (NSArray *)interestsIndexesForInterestIds:(NSArray *)interestIds;
//
//+ (UIImageView *)addBackgroundImage:(UIImage *)image viewController:(UIViewController *)viewController;
//
//+ (UIFont *)gothemRoundedBookWithSize:(CGFloat)size;
//
//+ (UIFont *)gothemRoundedMediumWithSize:(CGFloat)size;
//
//+ (UIActivityIndicatorView *)showSpinnerInView:(UIView *)view center:(CGPoint)center;
//
//+ (NSInteger)linesCountOfTextView:(UITextView *)textView withText:(NSString *)text;
//
//+ (void)changeHeightOfView:(UIView *)view newHeight:(CGFloat)height;
//
//+ (void)changeWidthOfView:(UIView *)view newWidth:(CGFloat)width;
//
//+ (void)changeOriginXOfView:(UIView *)view newOriginX:(CGFloat)originX;
//
//+ (void)changeOriginYOfView:(UIView *)view newOriginY:(CGFloat)originY;
//
//+ (NSString *)timeZoneStringWithTimeZone:(NSInteger)timeZone;
//
//+ (NSString *)safeGetPriceStringWithData:(id)data;
//
//+ (NSString *)safeGetPriceStringWithData:(id)data decimal:(BOOL)deciaml;
//
//+ (void)getLocationWithAdress:(NSString *)address state:(NSString *)state city:(NSString *)city zipCode:(NSString *)zipCode venueName:(NSString *)venueName completionHandler:(void (^)(NSString *latitude, NSString *longitude))completionHandler;
//
//+ (NSString *)formatedUSPhoneNumberFromPhoneNumber:(NSString *)phoneNumber;
//
//+ (NSString *)phoneNumberFromFormattedUSPhoneNumber:(NSString *)formatedPhoneNumber;
//
//+ (NSData *)imageDataFromImage:(UIImage *)image;
//
//+ (NSString *)stringValueFromNumericObject:(id)numericObject;
//
//+ (NSInteger)localTimeZoneInSeconds;

@end
