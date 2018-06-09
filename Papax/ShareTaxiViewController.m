//
//  ShareTaxiViewController.m
//  Papax
//
//  Created by Tigran on 6/9/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "ShareTaxiViewController.h"
#import "CorneredTextField.h"
#import "RidesViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "DirectionService.h"
#import "NetworkingManager.h"
#import "LoginManager.h"

@interface ShareTaxiViewController ()

@property (weak, nonatomic) IBOutlet CorneredTextField *originTextField;
@property (weak, nonatomic) IBOutlet CorneredTextField *destinationTextField;
@property (nonatomic) NSMutableArray *waypoints;
@property (weak, nonatomic) IBOutlet GMSMapView *mapContainerView;
@property (weak, nonatomic) IBOutlet UILabel *seatsCountLabel;
@property (nonatomic) BOOL firstLocationUpdate;
@property (nonatomic) NSDictionary *route;

@end

@implementation ShareTaxiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UITapGestureRecognizer* tapRecogonizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOriginTap:)];
    [self.originTextField addGestureRecognizer:tapRecogonizer1];
    
    UITapGestureRecognizer* tapRecogonizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDestinationTap:)];
    [self.destinationTextField addGestureRecognizer:tapRecogonizer2];
    
    self.waypoints = [NSMutableArray new];
    
    
    self.mapContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.mapContainerView.mapType = kGMSTypeNormal;
    self.mapContainerView.myLocationEnabled = YES;
    self.mapContainerView.settings.myLocationButton = YES;
    //    [mapContainerView setMinZoom:10 maxZoom:18];
    
    self.mapContainerView.delegate = self;
    
    // Listen to the myLocation property of GMSMapView.
    [self.mapContainerView addObserver:self
                       forKeyPath:@"myLocation"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
    
    // Ask for My Location data after the map has already been added to the UI.
    self.mapContainerView.myLocationEnabled = YES;
}

- (GMSMarker *)markerObjectInPosition:(CLLocationCoordinate2D)coordinate {
    GMSMarker *newMarker = [GMSMarker new];
    newMarker.appearAnimation = kGMSMarkerAnimationPop;
    newMarker.icon = [UIImage imageNamed:@"marker"];
    newMarker.position = coordinate;
    newMarker.map = nil;
    
    return newMarker;
}

- (void)drawMarkers {
    for (GMSMarker *marker in self.waypoints) {
        if (!marker.map) {
            marker.map = self.mapContainerView;
        }
    }
}

- (void)drawPath {
    if ([self waypointsString].count > 1) {
        NSString *sensor = @"false";
        NSArray *parameters = [NSArray arrayWithObjects:sensor, [self waypointsString], nil];
        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters forKeys:keys];
        
        DirectionService *ds = [DirectionService new];
        [ds setDirectionsQuery:query
                  withSelector:@selector(addDirections:)
                  withDelegate:self];
        
        [self showAllMarkers];
    } else if ([self waypointsString].count == 1) {
        GMSMarker *marker = self.waypoints[0];
        self.mapContainerView.camera = [GMSCameraPosition cameraWithTarget:marker.position
                                                                      zoom:14];
    }
}

- (NSArray *)waypointsString {
    NSMutableArray *waypointsString = [NSMutableArray new];
    for (GMSMarker *marker in self.waypoints) {
        NSString *positionString = [NSString stringWithFormat:@"%f,%f", marker.position.latitude, marker.position.longitude];
        [waypointsString addObject:positionString];
    }
    return waypointsString;
}

- (void)addDirections:(NSDictionary *)json {
    NSArray *arr = json[@"routes"];
    if (arr.count) {
        NSDictionary *routes = json[@"routes"][0];
        self.route = routes[@"overview_polyline"];
        NSString *overviewRoute = self.route[@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:overviewRoute];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 10;
        polyline.map = self.mapContainerView;
    }
}

- (void)showAllMarkers {
    GMSMutablePath *path = [GMSMutablePath path];
    
    for (GMSMarker *marker in self.waypoints) {
        [path addCoordinate: marker.position];
    }
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithPath:path];
    
    [self.mapContainerView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:60.0f]];
}


#pragma mark - UIGestureRecognizer

- (void)handleOriginTap:(UITapGestureRecognizer*)sender {
    RidesViewController *vc = [RidesViewController new];
    vc.closeBlock = ^(NSString *name, CLLocationCoordinate2D location) {
        
        self.originTextField.text = name;
        
        GMSMarker *marker = [self markerObjectInPosition:location];
        [self.waypoints addObject:marker];
        [self drawMarkers];
        
        [self drawPath];

    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleDestinationTap:(UITapGestureRecognizer*)sender {
    RidesViewController *vc = [RidesViewController new];
    vc.closeBlock = ^(NSString *name, CLLocationCoordinate2D location) {
        
        self.destinationTextField.text = name;
        
        GMSMarker *marker = [self markerObjectInPosition:location];
        [self.waypoints addObject:marker];
        [self drawMarkers];
        
        [self drawPath];
        
    };
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - Actions

- (IBAction)increaseButton:(UIButton *)sender {
    int number = (int)[self.seatsCountLabel.text integerValue];
    if (number + 1 < 8) {
        self.seatsCountLabel.text = [NSString stringWithFormat:@"%@", @(number + 1)];
    }
}

- (IBAction)decreaseButton:(UIButton *)sender {
    int number = (int)[self.seatsCountLabel.text integerValue];
    if (number - 1 >= 0) {
        self.seatsCountLabel.text = [NSString stringWithFormat:@"%@", @(number - 1)];
    }
}

- (IBAction)createRide:(UIButton *)sender {
    NSDictionary *body = @{@"time" : @"09/08/2018",
                           @"driver_id" : @"5b1b11a712d1ef84afbe5052",//[LoginManager sharedInstance].currentUser.userId,
                           @"tab" : @"from_work",
                           @"route": self.route
                           };
    [[NetworkingManager sharedInstance] createRideWithBody:body onSuccess:^(id result) {
        
    } onFailure:^(NSError *error) {
        
    }];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (!self.firstLocationUpdate) {
        // If the first location update has not yet been recieved, then jump to that
        // location.
        self.firstLocationUpdate = YES;
        CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
        self.mapContainerView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                                      zoom:14];
    }
}

- (void)dealloc {
    if (self.mapContainerView) {
        [self.mapContainerView removeObserver:self forKeyPath:@"myLocation"];
    }
}

@end
