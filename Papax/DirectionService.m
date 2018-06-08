//
//  DirectionService.m
//  Papax
//
//  Created by Tigran on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "DirectionService.h"

static NSString *kDirectionsURL = @"https://maps.googleapis.com/maps/api/directions/json?";

@interface DirectionService ()

@property (nonatomic) BOOL sensor;
@property (nonatomic) BOOL alternatives;
@property (nonatomic) NSURL *directionsURL;
@property (nonatomic) NSArray *waypoints;

@end

@implementation DirectionService

- (void)setDirectionsQuery:(NSDictionary *)query withSelector:(SEL)selector withDelegate:(id)delegate {
    NSArray *waypoints = query[@"waypoints"];
    NSString *origin = waypoints[0];
    int waypointsCount = (int)waypoints.count;
    int destinationPosition = waypointsCount - 1;
    NSString *destination = waypoints[destinationPosition];
    NSString *sensor = query[@"sensor"];
    NSMutableString *url =
    [NSMutableString stringWithFormat:@"%@origin=%@&destination=%@&sensor=%@",
     kDirectionsURL, origin, destination, sensor];
    if (waypointsCount > 2) {
  //      [url appendString:@"&waypoints=optimize:false"];
        int wpCount = waypointsCount - 2;
        for (int i = 1; i < wpCount; i ++) {
            [url appendString:@"|"];
            [url appendString:waypoints[i]];
        }
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    self.directionsURL = [NSURL URLWithString:url];
    [self retrieveDirections:selector withDelegate:delegate];
}

- (void)retrieveDirections:(SEL)selector withDelegate:(id)delegate {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *data = [NSData dataWithContentsOfURL:self.directionsURL];
        [self fetchedData:data withSelector:selector withDelegate:delegate];
    });
}

- (void)fetchedData:(NSData *)data withSelector:(SEL)selector withDelegate:(id)delegate {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    [delegate performSelector:selector withObject:json];
}

@end
