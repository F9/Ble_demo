//
//  ViewController.m
//  blenotify
//
//  Created by Francesco Novelli on 06/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startNotify:(id)sender {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    CLBeaconRegion *region = nil;
    NSUUID *_uuid = [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"];
    NSNumber *major = @2;
    NSNumber *minor = @2;
    region = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid
                                                     major:[major shortValue]
                                                     minor:[minor shortValue]
                                                identifier:@"it.runcode.blenotify"];

    region.notifyOnEntry = YES;
    region.notifyOnExit = YES;
    region.notifyEntryStateOnDisplay = YES;
    
    [_locationManager startMonitoringForRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Sei entrato nel mio negozio";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Sei uscito dal mio negozio";
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


//- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
//{
//    // A user can transition in or out of a region while the application is not running.
//    // When this happens CoreLocation will launch the application momentarily, call this delegate method
//    // and we will let the user know via a local notification.
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    
//    if(state == CLRegionStateInside)
//    {
//        notification.alertBody = @"You're inside the region";
//    }
//    else if(state == CLRegionStateOutside)
//    {
//        notification.alertBody = @"You're outside the region";
//    }
//    else
//    {
//        return;
//    }
//    
//    // If the application is in the foreground, it will get a callback to application:didReceiveLocalNotification:.
//    // If its not, iOS will display the notification to the user.
//    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
//}

@end
