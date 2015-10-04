//
//  DriveSafe.h
//  DriveSafe
//
//  Created by Ethan Lee on 10/3/15.
//  Copyright © 2015 Ethan Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>

//! Project version number for DriveSafe.
FOUNDATION_EXPORT double DriveSafeVersionNumber;

//! Project version string for DriveSafe.
FOUNDATION_EXPORT const unsigned char DriveSafeVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <DriveSafe/PublicHeader.h>

@interface DriveSafe : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate> {
    CBPeripheral *connectedPeripheral;
    NSNumber *currentRSSI;
    bool isLocked;
}

+(instancetype) ly;
- (BOOL)hasConnectedDevice;
- (void)beginApplicationLoop;
- (void)didConnectDevice:(NSNotification *)notification;
- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray<CBPeripheral *> *)peripherals;

@property (strong, nonatomic) CBCentralManager *centralManager;

@end