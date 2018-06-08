//
//  RidesViewController.m
//  Papax
//
//  Created by VA on 6/8/18.
//  Copyright © 2018 VA. All rights reserved.
//

#import "RidesViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "NetworkingManager.h"
#import "DirectionService.h"
#import "GradientButton.h"


#define GOOGLE_API_KEY @"AIzaSyB6MZ5v0Kj6KdncBGeROfidNs-bWYub4_E"




@interface RidesViewController () <CLLocationManagerDelegate, GMSMapViewDelegate>

@property (nonatomic) GMSMapView *mapContainerView;
@property (nonatomic) NSMutableArray *waypoints;
@property (nonatomic) BOOL firstLocationUpdate;
@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) UIImageView *markerImageView;

@end

@implementation RidesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];


    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    [self.locationManager startUpdatingLocation];
    
    
    
    self.mapContainerView = [self createMapContainerView];
    [self.view addSubview:self.mapContainerView];

    GradientButton *gradientButton = [self createGradientButton];
    [self.view addSubview:gradientButton];

    
    self.waypoints = [NSMutableArray new];
    
    self.markerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    self.markerImageView.image = [UIImage imageNamed:@"marker"];
    self.markerImageView.center = self.view.center;
    [self.view addSubview:self.markerImageView];
    
}

- (GMSMapView *)createMapContainerView {
    GMSMapView *mapContainerView = [[GMSMapView alloc] initWithFrame:self.view.bounds];
    mapContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    mapContainerView.mapType = kGMSTypeNormal;
    mapContainerView.myLocationEnabled = YES;
    mapContainerView.settings.myLocationButton = YES;
//    [mapContainerView setMinZoom:10 maxZoom:18];
    
    mapContainerView.delegate = self;
    
    // Listen to the myLocation property of GMSMapView.
    [mapContainerView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    
    // Ask for My Location data after the map has already been added to the UI.
    mapContainerView.myLocationEnabled = YES;
    
    return mapContainerView;
}

- (GradientButton *)createGradientButton {
    GradientButton *gradientButton = [[GradientButton alloc] initWithFrame:CGRectMake(0, 0, 284, 50)];
    gradientButton.center = self.view.center;
    CGRect frame = gradientButton.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height - 25;
    gradientButton.frame = frame;
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]};
    [gradientButton setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:@"Add Address"attributes:attributes] forState:UIControlStateNormal];
    gradientButton.darkBlueVariant = YES;
    [gradientButton addTarget:self action:@selector(gradientButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    
    return gradientButton;
}

- (void)dealloc {
    if (self.mapContainerView) {
        [self.mapContainerView removeObserver:self forKeyPath:@"myLocation"];
    }
}

- (GMSMarker *)markerObjectInPosition:(CLLocationCoordinate2D)coordinate {
    GMSMarker *newMarker = [GMSMarker new];
    newMarker.appearAnimation = kGMSMarkerAnimationPop;
    newMarker.icon = [UIImage imageNamed:@"marker"];
    newMarker.position = coordinate;
    newMarker.map = nil;
    
    return newMarker;
}

#pragma mark - Map

- (void)drawMarkers {
    for (GMSMarker *marker in self.waypoints) {
        if (!marker.map) {
            marker.map = self.mapContainerView;
        }
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


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *locationsLocation = locations.lastObject;
    NSLog(@"NewLocation %f %f", locationsLocation.coordinate.latitude, locationsLocation.coordinate.longitude);
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

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
//    CLLocationCoordinate2D position = [mapView.projection coordinateForPoint:CGPointMake(self.view.center.x, self.view.center.y + 20) ];
//
//    GMSMarker *marker = [self markerObjectInPosition:position];
//    [self.waypoints addObject:marker];
//    [self drawMarkers];
//
//
//    if ([self waypointsString].count > 1) {
//        NSString *sensor = @"false";
//        NSArray *parameters = [NSArray arrayWithObjects:sensor, [self waypointsString], nil];
//        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
//        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters forKeys:keys];
//
//        DirectionService *ds = [DirectionService new];
//        [ds setDirectionsQuery:query
//                  withSelector:@selector(addDirections:)
//                  withDelegate:self];
//
//    }
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
        NSDictionary *route = routes[@"overview_polyline"];
        NSString *overviewRoute = route[@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:overviewRoute];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 10;
        polyline.map = self.mapContainerView;
    }
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    for (GMSMarker *marker in self.waypoints) {
        if ([self directMetersFromCoordinate:marker.position toCoordinate:coordinate] < 300) {
            marker.map = nil;
            [self.waypoints removeObject:marker];
            break;
        }
    }
    [self drawMarkers];
}

- (CGFloat)directMetersFromCoordinate:(CLLocationCoordinate2D)from toCoordinate:(CLLocationCoordinate2D)to {
    static const double DEG_TO_RAD = 0.017453292519943295769236907684886;
    static const double EARTH_RADIUS_IN_METERS = 6372797.560856;
    
    double latitudeArc  = (from.latitude - to.latitude) * DEG_TO_RAD;
    double longitudeArc = (from.longitude - to.longitude) * DEG_TO_RAD;
    double latitudeH = sin(latitudeArc * 0.5);
    latitudeH *= latitudeH;
    double lontitudeH = sin(longitudeArc * 0.5);
    lontitudeH *= lontitudeH;
    double tmp = cos(from.latitude*DEG_TO_RAD) * cos(to.latitude*DEG_TO_RAD);
    return EARTH_RADIUS_IN_METERS * 2.0 * asin(sqrt(latitudeH + tmp*lontitudeH));
}

#pragma mark - Actions

- (void)gradientButtonPressed:(UIButton *)sender {
    CLLocationCoordinate2D position = [self.mapContainerView.projection coordinateForPoint:CGPointMake(self.view.center.x, self.view.center.y + 20) ];
    
    GMSMarker *marker = [self markerObjectInPosition:position];
    [self.waypoints addObject:marker];
    [self drawMarkers];
    
    
    if ([self waypointsString].count > 1) {
        NSString *sensor = @"false";
        NSArray *parameters = [NSArray arrayWithObjects:sensor, [self waypointsString], nil];
        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters forKeys:keys];
        
        DirectionService *ds = [DirectionService new];
        [ds setDirectionsQuery:query
                  withSelector:@selector(addDirections:)
                  withDelegate:self];
        
    }
}

@end
