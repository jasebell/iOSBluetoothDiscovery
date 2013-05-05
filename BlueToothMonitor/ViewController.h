//
//  ViewController.h
//  BlueToothMonitor
//
//  Created by Jason Bell on 05/05/2013.
//  Copyright (c) 2013 Jason Bell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController<CBCentralManagerDelegate> {
    
}
@property (nonatomic, strong) CBCentralManager *cBCM;
@property (nonatomic, retain) IBOutlet UILabel *statusLabel;
- (void) updateDeviceCheck;
@end
