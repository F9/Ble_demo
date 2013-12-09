//
//  MasterViewController.h
//  bleranging
//
//  Created by Francesco Novelli on 06/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface MasterViewController : UITableViewController <CLLocationManagerDelegate> {
    CLLocationManager * _locationManager;
}

@property (strong) NSMutableArray *dataList;

@end
