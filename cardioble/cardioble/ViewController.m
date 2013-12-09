//
//  ViewController.m
//  cardioble
//
//  Created by Francesco Novelli on 04/12/13.
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
    myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    

}
- (IBAction)searchDevices:(id)sender {
    [myCentralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI {
    
    NSLog(@"Discovered %@",peripheral.name);
    [myCentralManager connectPeripheral:peripheral options:nil];
    
    /* avoid peripheral de-alloc */
    self.connectingPeripheral = peripheral;

}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    peripheral.delegate = self;
    NSLog(@"Connect");
    [self.connectingPeripheral discoverServices:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *service in peripheral.services) {
        NSLog(@"Service discovered %@", service);
        /* Heart rate service discovered */
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180D"]])
        {
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}



- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180D"]])
    {
        for (CBCharacteristic *aChar in service.characteristics)
        {
            /* Set notification on heart rate measurement */
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A37"]])
            {
                [peripheral setNotifyValue:YES forCharacteristic:aChar];
                NSLog(@"Found a Heart Rate Measurement Characteristic");
            }
        }
    }

}

- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {

    
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A37"]])
    {
        if( (characteristic.value)  || !error )
        {
            /* Update UI with heart rate data */
            NSData *data = characteristic.value;
            const uint8_t *reportData = [data bytes];
            uint16_t bpm = 0;
            
            if ((reportData[0] & 0x01) == 0)
            {
                /* uint8 bpm */
                bpm = reportData[1];
            }
            else
            {
                /* uint16 bpm */
                bpm = CFSwapInt16LittleToHost(*(uint16_t *)(&reportData[1]));
            }
            if(data != NULL) {
             
                self.rpmLabel.text = [NSString stringWithFormat:@"%d", bpm];
            }
        }
    }
    
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
