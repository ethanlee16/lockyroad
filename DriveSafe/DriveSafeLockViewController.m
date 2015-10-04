//
//  DriveSafeLockViewController.m
//  DriveProofChat
//
//  Created by Ethan Lee on 10/4/15.
//  Copyright © 2015 Ethan Lee. All rights reserved.
//

#import "DriveSafeLockViewController.h"

@implementation DriveSafeLockViewController

- (id) init {
    self = [super initWithNibName:@"DriveSafeLockViewController" bundle:[NSBundle bundleWithIdentifier:@"DriveSafe"]];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    return self;
}

- (void)setBlurredImage: (UIImage *)image {
    NSLog(@"Setting blurred frame");
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    [self.blurredFrame setImage:image];
    visualEffectView.frame = self.blurredFrame.bounds;
    [self.blurredFrame addSubview:visualEffectView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
