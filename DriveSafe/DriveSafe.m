//
//  DriveSafe.m
//  DriveProofChat
//
//  Created by Ethan Lee on 10/3/15.
//  Copyright © 2015 Ethan Lee. All rights reserved.
//

#import "DriveSafe.h"
#import "DriveSafeViewController.h"
#import "DriveSafeLockViewController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MyoKit/MyoKit.h>

@implementation DriveSafe : NSObject

/* This variables controls activity.automotive switch when we cannot simulate */
bool IS_DEBUG = true;

+ (instancetype) ly {
    static DriveSafe *ly = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ly = [[[self class] alloc] init];
    });
    [TLMHub sharedHub];
    return ly;
}

- (void)beginApplicationLoop {
    if(![self hasConnectedDevice]) {
        [self presentSetupModal];
    } else {
        // If we already have a device connected, bypass the Setup menu
        [self centralManagerDidUpdateState:self.centralManager];
    }
    CMMotionActivityManager* motionManager = [[CMMotionActivityManager alloc] init];
    UIViewController *rootController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    DriveSafeLockViewController *lockViewController = [[DriveSafeLockViewController alloc] init];
    self->isLocked = false;
    if([CMMotionActivityManager isActivityAvailable]) {
        [motionManager startActivityUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMMotionActivity *activity) {
            if((activity.automotive || IS_DEBUG) && [self hasConnectedDevice]) {
                [self->connectedPeripheral readRSSI];
                if([self->currentRSSI integerValue] > -50 && !isLocked) {
                    UIGraphicsBeginImageContextWithOptions(rootController.view.bounds.size, NO, [UIScreen mainScreen].scale);
                    [rootController.view drawViewHierarchyInRect:rootController.view.bounds afterScreenUpdates:YES];
                    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    [lockViewController setBlurredImage: image];
                    
                    [rootController presentViewController:lockViewController animated:YES completion:nil];
                    isLocked = true;
                    NSLog(@"LOCK");
                } else if([self->currentRSSI integerValue] < -50 && isLocked) {
                    [rootController dismissViewControllerAnimated:NO completion:nil];
                    isLocked = false;
                }
            }
        }];
    }
}

- (void)toggleLockAndConfirm: (BOOL)confirmation {
    
}

- (BOOL)hasConnectedDevice {
    return self->connectedPeripheral != nil;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSLog(@"DIAGNOSTIC; CentralManager ready");
    NSArray* peripherals = [self.centralManager retrieveConnectedPeripheralsWithServices: @[[CBUUID UUIDWithString:@"D5060001-A904-DEB9-4748-2C7F4A124842"]]];
    self->connectedPeripheral = [peripherals objectAtIndex:0];
    [self.centralManager connectPeripheral:self->connectedPeripheral options:nil];
}

- (void)presentSetupModal {
    NSLog(@"test");
    UIViewController *rootController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    DriveSafeViewController *settings = [[DriveSafeViewController alloc] init];
    
    // well, it's a hackathon
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 3);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        UIViewController *visibleController = [UIApplication sharedApplication].keyWindow.rootViewController;
        UIGraphicsBeginImageContextWithOptions(visibleController.view.bounds.size, NO, [UIScreen mainScreen].scale);
        [visibleController.view drawViewHierarchyInRect:visibleController.view.bounds afterScreenUpdates:YES];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [settings setBlurredImage: image];
        [rootController presentViewController:settings animated:YES completion:^(void){
            
            NSLog(@"Presented controller");
        }];
    });
    
}

- (void)didConnectDevice:(NSNotification *)notification {
    NSLog(@"didConnectDevice: called");
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    [self centralManagerDidUpdateState:self.centralManager];
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootController dismissViewControllerAnimated:YES completion:nil];
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"RSSI: %@", [peripheral.RSSI stringValue]);
    self->currentRSSI = [[NSNumber alloc] initWithDouble:[peripheral.RSSI doubleValue]];
    if(IS_DEBUG) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Myo Connected"
                                                        message:[peripheral.RSSI stringValue]
                                                        delegate:nil
                                                        cancelButtonTitle:@"Done"
                                                        otherButtonTitles:nil];
        //[alert show];
    }
    
    if(error) {
        NSLog(@"Error: RSSI read");
    }
    NSLog(@"Got RSSI update: %4.1f", [peripheral.RSSI doubleValue]);
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"connected myo to centralManager");
    self->connectedPeripheral = peripheral;
    peripheral.delegate = self;
    [peripheral readRSSI];
}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray<CBPeripheral *> *)peripherals {

}

@end
