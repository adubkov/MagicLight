//
//  ViewController.m
//  MagicLight
//
//  Created by Alexey Dubkov on 1/6/18.
//  Copyright © 2018 Alexey Dubkov. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.lightIsOn = false;

    int height = self.view.frame.size.height;
    int width = self.view.frame.size.width;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Light Label
    self.lightLabel = [[UILabel alloc] initWithFrame:CGRectMake(-150, -24, 150, 24)];
    [self.lightLabel setCenter:CGPointMake(width / 2, height / 2 - 80)];
    self.lightLabel.backgroundColor = [UIColor clearColor];
    self.lightLabel.font = [UIFont fontWithName:@"Helvetica" size:21];
    self.lightLabel.textColor = [UIColor blackColor];
    self.lightLabel.textAlignment = NSTextAlignmentCenter;
    self.lightLabel.text = @"Magic Light";
    [self.view addSubview:self.lightLabel];
    
    // Light Button
    self.lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lightButton.frame = CGRectMake(-150, -150, 150, 150);
    [self.lightButton setCenter:CGPointMake(width / 2, height / 2)];
    [self.lightButton setImage:[UIImage imageNamed:@"button_on"] forState:UIControlStateNormal];
    [self.view addSubview:self.lightButton];
    [self.lightButton addTarget:self
                         action:@selector(lightButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id _Nonnull context) {
        int height = self.view.frame.size.height;
        int width = self.view.frame.size.width;
        
        [self.lightLabel setCenter:CGPointMake(width / 2, height / 2 - 80)];
        [self.lightButton setCenter:CGPointMake(width / 2, height / 2)];
    } completion:^(id _Nonnull context) {
        // after rotation
    }];
}

- (void) lightButtonPressed:(UIButton *)sender {
    self.lightIsOn = ! self.lightIsOn;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (self.lightIsOn) {
            device.torchMode = AVCaptureTorchModeOn;
            [self.lightButton setImage:[UIImage imageNamed:@"button_off"] forState:UIControlStateNormal];
        } else {
            device.torchMode = AVCaptureTorchModeOff;
            [self.lightButton setImage:[UIImage imageNamed:@"button_on"] forState:UIControlStateNormal];
        }
        [device unlockForConfiguration];
    }
    
    NSLog(@"Light is %@.", self.lightIsOn ? @"ON" : @"OFF");
}

@end
