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
    
    
    // Light Button
    self.lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lightButton.frame = CGRectMake(-150, -150, 150, 150);
    [self.lightButton setCenter:CGPointMake(width / 2, height / 2)];
    [self.lightButton setImage:[UIImage imageNamed:@"button_on"] forState:UIControlStateNormal];
    [self.lightButton setImage:[UIImage imageNamed:@"button_off"] forState:UIControlStateHighlighted];
    [self.view addSubview:self.lightButton];
    [self.lightButton addTarget:self
                         action:@selector(lightButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    
    // Light Lable
    self.lightLabel = [[UILabel alloc] initWithFrame:CGRectMake(-100, -22, 100, 22)];
    [self.lightLabel setCenter:CGPointMake(width / 2, height / 2 - 100)];
    self.lightLabel.backgroundColor = [UIColor clearColor];
    self.lightLabel.textColor = [UIColor blackColor];
    self.lightLabel.text = @"Magic Light";
    [self.view addSubview:self.lightLabel];
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
        
        [self.lightButton setCenter:CGPointMake(width / 2, height / 2)];
        [self.lightLabel setCenter:CGPointMake(width / 2, height / 2 - 100)];
        
    } completion:^(id  _Nonnull context) {
        
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
        } else {
            device.torchMode = AVCaptureTorchModeOff;
        }
        [device unlockForConfiguration];
    }
    
    NSLog(@"Light is %@.", self.lightIsOn ? @"ON" : @"OFF");
}

@end
