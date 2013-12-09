//
//  ViewController.h
//  blenotify
//
//  Created by Francesco Novelli on 06/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate> {
     CLLocationManager *_locationManager;
}

@end
