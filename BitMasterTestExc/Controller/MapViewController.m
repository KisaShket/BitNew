//
//  MapViewController.m
//  BitMasterTestExc
//
//  Created by Kisa Shket on 21.04.2021.
//

#import <Foundation/Foundation.h>
#import "MapViewController.h"
#import <BitMasterTestExc-Swift.h>

@interface MapViewController ()
    @property (strong, nonatomic) GMSMapView *mapView;
@end

@implementation MapViewController

-(void)loadView {
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    iconView.image = [UIImage imageNamed:@"marker"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, -9,64,64)];
    label.text = [self.repo.stargazersCount stringValue];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font =[label.font fontWithSize: 11];
    [iconView addSubview:label];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(64, 64), NO, [[UIScreen mainScreen] scale]);
    [iconView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.repo.latitude
                                                            longitude:self.repo.longitude
                                                                 zoom:kGMSMinZoomLevel];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    self.view = _mapView;
   GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(self.repo.latitude, self.repo.longitude);
    marker.icon = icon;
    marker.map = _mapView;
}
@end



