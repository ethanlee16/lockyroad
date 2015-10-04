
//
//  DriveSafeViewController.m
//  DriveProofChat
//
//  Created by Ethan Lee on 10/3/15.
//  Copyright © 2015 Ethan Lee. All rights reserved.
//

#import "DriveSafeViewController.h"
#import "DriveSafe.h"
#import <MyoKit/MyoKit.h>
#import <UIKit/UIKit.h>

@implementation DriveSafeViewController

- (id) init {
    self = [super initWithNibName:@"DriveSafeViewController" bundle:[NSBundle bundleWithIdentifier:@"DriveSafe"]];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.connectButton addTarget:self action:@selector(modalPresentMyoSettings:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBlurredImage: (UIImage *)image {
    NSLog(@"Setting blurred frame");
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    [self.blurredFrame setImage:image];
    visualEffectView.frame = self.blurredFrame.bounds;
    [self.blurredFrame addSubview:visualEffectView];
}

- (IBAction)modalPresentMyoSettings: (UIButton *) sender {
    UINavigationController *settings = [TLMSettingsViewController settingsInNavigationController];
    [self presentViewController:settings animated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] addObserver:[DriveSafe ly] selector:@selector(didConnectDevice:) name:TLMHubDidConnectDeviceNotification object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
