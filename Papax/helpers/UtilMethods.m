//
//  UtilMethods.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "UtilMethods.h"

@implementation UtilMethods

//+ (BOOL)isValidEmail:(NSString *)email {
//    NSString *emailRegex =
//    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
//    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
//    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
//    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
//    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
//    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
//    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
//
//    return [emailTest evaluateWithObject:email];
//}
//
//+ (BOOL)isValidPhoneNumber:(NSString *)phoneNumber {
//    NSString *phoneRegex = @"^([\\(]{1}[0-9]{3}[\\)]{1}[ ]{1}[0-9]{3}[\\-]{1}[0-9]{4})$";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
//    return[phoneTest evaluateWithObject:phoneNumber];
//}
//
//+ (BOOL)isValidHashtag:(NSString *)hashtag {
//    NSString *hashtagRegex = @"((?:#){1}[a-zA-Z]{1}[0-9a-zA-Z]{0,97})";
//    NSPredicate *hashtagTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", hashtagRegex];
//    return [hashtagTest evaluateWithObject:hashtag];
//}
//
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
//
//+ (void)showProgressHudWithText:(NSString *)text OnView:(UIView *)view {
//    if ([UIScreen mainScreen].bounds.size.height <= 568.0) {
//        UIView *hudSubview = [UIView new];
//        [view addSubview:hudSubview];
//        hudSubview.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height / 2.0);
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:hudSubview animated:YES];
//        hud.detailsLabelText = text;
//        hud.mode = MBProgressHUDModeText;
//        hud.detailsLabelFont = [UIFont fontWithName:@"GothamRounded-Book" size:14];
//        [hud hide:YES afterDelay:3];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [hudSubview removeFromSuperview];
//        });
//    } else {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//        hud.detailsLabelText = text;
//        hud.mode = MBProgressHUDModeText;
//        hud.detailsLabelFont = [UIFont fontWithName:@"GothamRounded-Book" size:14];
//        [hud hide:YES afterDelay:2];
//    }
//}
//
//+ (BOOL)isNotConnected {
//    return ![[AFNetworkReachabilityManager sharedManager] isReachable];
//}
//
//+ (NSData *)imageDataFromImage:(UIImage *)image {
//    return UIImageJPEGRepresentation(image, 0.7);
//}
//
//+ (NSString *)encodeToBase64String:(UIImage *)image {
//    NSData *jpegImageData = UIImageJPEGRepresentation(image, 0.7);
//    return [NSString stringWithFormat:@"data:image/jpeg;base64,%@",[jpegImageData base64EncodedStringWithOptions:0]];
//}


+ (UIViewController *)VCFromStoryBoardWithName:(NSString *)storyBoardName viewControllerID:(NSString *)identifier {
    UIStoryboard *profileSettingsStoryBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    return [profileSettingsStoryBoard instantiateViewControllerWithIdentifier:identifier];
}

//
//+ (NSString *)safeSetString:(NSString *)string {
//    if (!string) {
//        return @"";
//    }
//    return string;
//}
//
//+ (NSString *)validString:(NSString *)string {
//    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//}
//
//+ (UIAlertController *)showAlertControllerWithMessage:(NSString *)message ViewController:(UIViewController *)ViewController {
//    return [PSUtilMethods showAlertControllerWithMessage:message title:nil ViewController:ViewController];
//}
//
//+ (UIAlertController *)showAlertControllerWithMessage:(NSString *)message title:(NSString *)title ViewController:(UIViewController *)ViewController {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//    [ViewController presentViewController:alertController animated:YES completion:nil];
//    return alertController;
//}
//
//+ (NSArray *)interestsIndexesForInterestIds:(NSArray *)interestIds {
//    NSMutableArray *interstsIndexes = [[NSMutableArray alloc]initWithCapacity:interestIds.count];
//    for (NSString *interestId in interestIds) {
//        for (int i = 0; i <  [PSInterest interests].count; i++) {
//            PSInterest *interest = [PSInterest interests][i];
//            if ([interest.interestId isEqualToString:interestId]) {
//                [interstsIndexes addObject:@(i)];
//                break;
//            }
//        }
//    }
//    return [interstsIndexes copy];
//}
//
//+ (UIImageView *)addBackgroundImage:(UIImage *)image viewController:(UIViewController *)viewController {
//    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:image];
//    backgroundView.frame = viewController.view.bounds;
//    [viewController.view addSubview:backgroundView];
//    [viewController.view sendSubviewToBack:backgroundView];
//
//    return backgroundView;
//}
//
//+ (UIFont *)gothemRoundedBookWithSize:(CGFloat)size {
//    return [UIFont fontWithName:@"GothamRounded-Book" size:size];
//}
//
//+ (UIFont *)gothemRoundedMediumWithSize:(CGFloat)size {
//    return [UIFont fontWithName:@"GothamRounded-Medium" size:size];
//}
//
//+ (UIActivityIndicatorView *)showSpinnerInView:(UIView *)view center:(CGPoint)center {
//    UIActivityIndicatorView *indicatorView = [UIActivityIndicatorView new];
//    [view addSubview:indicatorView];
//    indicatorView.frame = CGRectMake(0, 0, 50, 50);
//    indicatorView.center = center;
//    indicatorView.hidesWhenStopped = YES;
//    [indicatorView startAnimating];
//    return indicatorView;
//}
//
//+ (NSInteger)linesCountOfTextView:(UITextView *)textView withText:(NSString *)text {
//    CGFloat textWidth = CGRectGetWidth(UIEdgeInsetsInsetRect(textView.frame, textView.textContainerInset));
//    textWidth -= 2.0 * textView.textContainer.lineFragmentPadding;
//    CGSize boundingRect = [text boundingRectWithSize:CGSizeMake(textWidth, DBL_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textView.font}  context:nil].size;
//    return boundingRect.height / textView.font.lineHeight;
//}
//
//+ (void)changeHeightOfView:(UIView *)view newHeight:(CGFloat)height {
//    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height);
//}
//
//+ (void)changeWidthOfView:(UIView *)view newWidth:(CGFloat)width {
//    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, width, view.frame.size.height);
//}
//
//+ (void)changeOriginXOfView:(UIView *)view newOriginX:(CGFloat)originX {
//    view.frame = CGRectMake(originX, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
//}
//
//+ (void)changeOriginYOfView:(UIView *)view newOriginY:(CGFloat)originY {
//    view.frame = CGRectMake(view.frame.origin.x, originY, view.frame.size.width, view.frame.size.height);
//}
//
//+ (NSString *)timeZoneStringWithTimeZone:(NSInteger)timeZone {
//    if (timeZone > 0) {
//        return [NSString stringWithFormat:@"(UTC +%ld)", (long)timeZone];
//    } else if (timeZone < 0) {
//        return [NSString stringWithFormat:@"(UTC %ld)", (long)timeZone];
//    } else {
//        return @"(UTC)";
//    }
//}
//
//+ (NSString *)safeGetPriceStringWithData:(id)data {
//    return [self safeGetPriceStringWithData:data decimal:YES];
//}
//
//+ (NSString *)safeGetPriceStringWithData:(id)data decimal:(BOOL)deciaml {
//    if (!data || data == [NSNull null]) {
//        return @"$0";
//    }
//    NSString *price = nil;
//    if ([data isKindOfClass:[NSString class]]) {
//        price = data;
//    } else {
//        price = [(NSNumber *)data stringValue];
//    }
//    if (deciaml) {
//        price = [NSString stringWithFormat:@"%.2f",[price doubleValue]];
//    }
//    return [@"$" stringByAppendingString:price];
//}
//
//+ (void)getLocationWithAdress:(NSString *)address state:(NSString *)state city:(NSString *)city zipCode:(NSString *)zipCode venueName:(NSString *)venueName completionHandler:(void (^)(NSString *latitude, NSString *longitude))completionHandler {
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSString *components = [NSString stringWithFormat:@"administrative_area_level_1:%@|locality:%@|postal_code:%@|premise:%@", state, city, zipCode,venueName];
//
//    NSDictionary *params = @{@"address" : @"address", @"components" :  components, @"key" : @"AIzaSyBy9hLJMNBOczqhydgT4wubBlFEvwdRKmA"};
//
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET"
//                                                                                 URLString:@"https://maps.googleapis.com/maps/api/geocode/json"
//                                                                                parameters:params error:NULL];
//
//    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (!error) {
//            if (![responseObject[@"results"] count]) {
//                completionHandler(@"",@"");
//            } else {
//                NSDictionary *geometry = responseObject[@"results"][0][@"geometry"];
//                NSDictionary *location = geometry[@"location"];
//                completionHandler([location[@"lat"] stringValue], [location[@"lng"] stringValue]);
//            }
//        }
//    }] resume];
//}
//
//+ (NSString *)formatedUSPhoneNumberFromPhoneNumber:(NSString *)phoneNumber {
//    if (phoneNumber.length == 10) {
//        NSString *first3Digit = [phoneNumber substringWithRange:NSMakeRange(0, 3)];
//        NSString *second3Digit = [phoneNumber substringWithRange:NSMakeRange(3, 3)];
//        NSString *thirthPath = [phoneNumber substringWithRange:NSMakeRange(6, 4)];
//        return [NSString stringWithFormat:@"(%@) %@-%@", first3Digit, second3Digit, thirthPath];
//    }
//
//    return phoneNumber;
//}
//
//+ (NSString *)phoneNumberFromFormattedUSPhoneNumber:(NSString *)formatedPhoneNumber {
//    if (formatedPhoneNumber.length == 14) {
//        return [[[formatedPhoneNumber substringWithRange:NSMakeRange(1, 3)] stringByAppendingString:[formatedPhoneNumber substringWithRange:NSMakeRange(6, 3)]] stringByAppendingString:[formatedPhoneNumber substringWithRange:NSMakeRange(10, 4)]];
//    }
//
//    return formatedPhoneNumber;
//}
//
//+ (NSString *)stringValueFromNumericObject:(id)numericObject {
//    if ([numericObject isKindOfClass:[NSString class]]) {
//        return numericObject;
//    } else {
//        return [numericObject stringValue];
//    }
//}
//
//+ (NSInteger)localTimeZoneInSeconds {
//    return [NSTimeZone localTimeZone].secondsFromGMT / 3600;
//}
//

+(void) showMessageAlert:(NSString *) title andMessage:(NSString*) msg fromViewController: (UIViewController*)viewController action:(void(^)(void))callback{
    
    UIAlertController *showMsgAlertController = [UIAlertController alertControllerWithTitle: title message: msg preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *showMsgAlertControllerOkAction = [UIAlertAction actionWithTitle:@"OK"  style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                                               if (callback) {
                                                                                   callback();
                                                                               }
                                                                           }];
    [showMsgAlertController addAction:showMsgAlertControllerOkAction];
    [viewController presentViewController:showMsgAlertController animated:YES completion:nil];
    
}

@end
