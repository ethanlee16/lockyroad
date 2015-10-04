//
//  DriveSafeLockViewController.h
//  DriveProofChat
//
//  Created by Ethan Lee on 10/4/15.
//  Copyright © 2015 Ethan Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriveSafeLockViewController : UIViewController

-(void) setBlurredImage: (UIImage*)image;

@property (nonatomic, weak) IBOutlet UIImageView *blurredFrame;

@end
