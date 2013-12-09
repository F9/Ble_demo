//
//  ViewController.h
//  cardioble
//
//  Created by Francesco Novelli on 04/12/13.
//  Copyright (c) 2013 runcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController <CBCentralManagerDelegate, CBPeripheralDelegate> {
    CBCentralManager *myCentralManager;
}

@property (weak, nonatomic) IBOutlet UILabel *rpmLabel;

/* strong, to avoid dealloc */
@property (strong) CBPeripheral *connectingPeripheral;
@end
