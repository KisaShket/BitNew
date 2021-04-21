//
//  MapViewController.h
//  BitMasterTestExc
//
//  Created by Kisa Shket on 21.04.2021.
//

#ifndef MapViewController_h
#define MapViewController_h
#import <GoogleMaps/GoogleMaps.h>
@class RepoModel;
@interface MapViewController : UIViewController<GMSMapViewDelegate>
@property (strong, nonatomic) RepoModel* repo;
@end

#endif /* MapViewController_h */
