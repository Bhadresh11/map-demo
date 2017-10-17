//
//  ViewController.m
//  map Demo
//
//  Created by Bhadresh on 10/16/17.
//  Copyright © 2017 Bhadresh Patoliya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //Display my current location
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:23.0225  longitude:72.5714 zoom:12];
    [_GoogleMapView setCamera:camera];

    _GoogleMapView.settings.compassButton = YES;
    _GoogleMapView.settings.myLocationButton = YES;
    _GoogleMapView.settings.compassButton = YES;

    _GoogleMapView.myLocationEnabled = YES;
    _GoogleMapView.delegate = self;

    
    //
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}
#pragma mark- CLLocation Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CurrentLocation = [locations lastObject];
    
    if (CurrentLocation != nil)
    {
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:CurrentLocation.coordinate.latitude  longitude:CurrentLocation.coordinate.longitude zoom:12];
        [_GoogleMapView setCamera:camera];
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(CurrentLocation.coordinate.latitude, CurrentLocation.coordinate.longitude);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = @"You Are Here";
    marker.map = _GoogleMapView;
    
    //set static marker
    CLLocationCoordinate2D position1 = CLLocationCoordinate2DMake(CurrentLocation.coordinate.latitude-0.01, CurrentLocation.coordinate.longitude - 0.01);
    GMSMarker *marker1 = [GMSMarker markerWithPosition:position1];
    marker1.title = @"Target 1";
    marker1.map = _GoogleMapView;
    
    CLLocationCoordinate2D position2 = CLLocationCoordinate2DMake(CurrentLocation.coordinate.latitude+0.001, CurrentLocation.coordinate.longitude+0.0001);
    GMSMarker *marker2 = [GMSMarker markerWithPosition:position2];
    marker2.title = @"Target 2";
    marker2.map = _GoogleMapView;
    }
   

}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"newLocation: %@", newLocation);
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}
#pragma mark- GoogleMap Delegate
- (void) mapView: (GMSMapView *)mapView didChangeCameraPosition: (GMSCameraPosition *)position
{    
    double latitude = mapView.camera.target.latitude;
    double longitude = mapView.camera.target.longitude;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)setTargetWhereToGO:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: @"Where to go!"
                                                             delegate: self
                                                    cancelButtonTitle: @"Cancel"
                                               destructiveButtonTitle: nil
                                                    otherButtonTitles: @"Target 1",
                                  @"Target 2",
                                  nil];
    
    [actionSheet showInView:self.view];
    
}
#pragma mark - ActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
    //Target 1
        NSLog(@"buttonIndex :%ld",(long)buttonIndex);
    }
    else if (buttonIndex == 1)
    {
    //Target 2
        NSLog(@"buttonIndex :%ld",(long)buttonIndex);
    }
}

@end
