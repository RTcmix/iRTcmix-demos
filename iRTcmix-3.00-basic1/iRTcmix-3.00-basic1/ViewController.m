//
//  ViewController.m
//  iRTcmix-3.00-basic1
//
//  Created by Brad Garton on 7/19/16.
//  Copyright © 2016 Brad Garton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    @property (nonatomic, strong)       RTcmixPlayer			*rtcmixManager;

@end

@implementation ViewController


#pragma mark - the Action

- (IBAction)goButton:(UIButton *)sender {
    [self.rtcmixManager parseScoreWithNSString:@"WAVETABLE(0, 3.5, 28000, 8.05, .5)"];
}



#pragma mark - Delegate Methods (the actual delegate methods)

- (void)maxBang {
}

- (void)maxMessage:(NSArray *)message {

}

- (void)maxError:(NSString *)error {
}


#pragma mark - View Controller Default Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rtcmixManager = [RTcmixPlayer sharedManager];
    self.rtcmixManager.delegate = self;
    [self.rtcmixManager startAudio];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
