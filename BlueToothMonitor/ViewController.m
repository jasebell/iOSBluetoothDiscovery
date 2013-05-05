//
//  ViewController.m
//  BlueToothMonitor
//
//  Created by Jason Bell on 05/05/2013.
//  Copyright (c) 2013 Jason Bell. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize cBCM;
@synthesize statusLabel;

bool cBReady = false;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Setup a quick NSTimer to trigger the checking of bluetooth devices.
    NSLog(@"Setting the up the timer for every 30 seconds");
    [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(updateDeviceCheck) userInfo:nil repeats:YES];
    
    NSLog(@"Initialising the Bluetooth mananger.");
    self.cBCM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ** Timer method **

- (void) updateDeviceCheck {
    NSLog(@"Checking for Bluetooth devices");
    statusLabel.text = @"Checking.....";
    [self.cBCM scanForPeripheralsWithServices:nil options:nil];
}



// ** Bluetooth delegate methods **


- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
   cBReady = false;
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CoreBluetooth BLE hardware is powered off");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
            cBReady = true;
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CoreBluetooth BLE hardware is resetting");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"CoreBluetooth BLE state is unauthorized");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CoreBluetooth BLE state is unknown");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"Did discover peripheral. peripheral: %@ rssi: %@, UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.UUID, advertisementData);
    NSString *message = [[NSString alloc] initWithFormat:@"Did discover peripheral. peripheral: %@ rssi: %@, UUID: %@ advertisementData: %@ ", peripheral, RSSI, peripheral.UUID, advertisementData];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bluetooth" message:message delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert show];
    //Do something when a peripheral is discovered.
}



@end
