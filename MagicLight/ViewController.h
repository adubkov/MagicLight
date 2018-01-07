//
//  ViewController.h
//  MagicLight
//
//  Created by Alexey Dubkov on 1/6/18.
//  Copyright © 2018 Alexey Dubkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) BOOL lightIsOn;
@property (strong, nonatomic) UIButton *lightButton;
@property (strong, nonatomic) UILabel *lightLabel;

- (void) lightButtonPressed:(UIButton *)sender;

@end

