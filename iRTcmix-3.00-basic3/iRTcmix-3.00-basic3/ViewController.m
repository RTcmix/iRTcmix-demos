//
//  ViewController.m
//  iRTcmix-3.00-basic3
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

- (IBAction)goEcho:(UIButton *)sender {
    [self.rtcmixManager parseScoreWithNSString:@"rtinput(\"AUDIO\") \
        PANECHO(0, 0, 7.8, 1, 0.2, 0.3, 0.7, 2.0, 0)"];
}

- (IBAction)flush:(UIButton *)sender {
    [self.rtcmixManager flushAllScores];
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
    
    self.rtcmixManager.avAudioSessionCategory = AVAudioSessionCategoryPlayAndRecord;
    [self.rtcmixManager resetAudioParameters];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
