//
//  ViewController.h
//  map Demo
//
//  Created by Bhadresh on 10/16/17.
//  Copyright © 2017 Bhadresh Patoliya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate>
{
    CLLocationManager *locationManager;
    CLLocation* CurrentLocation;
}
@property (strong, nonatomic) IBOutlet GMSMapView *GoogleMapView;


@end

