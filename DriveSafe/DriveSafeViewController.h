//
//  DriveSafeViewController.h
//  DriveProofChat
//
//  Created by Ethan Lee on 10/3/15.
//  Copyright © 2015 Ethan Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriveSafeViewController : UIViewController {

}

- (void)setBlurredImage: (UIImage*)image;

@property (nonatomic, weak) IBOutlet UIButton *connectButton;
@property (nonatomic, weak) IBOutlet UIImageView *blurredFrame;

@end
