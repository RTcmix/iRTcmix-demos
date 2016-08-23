//
//  ViewController.m
//  iRTcmix-3.00-basic2
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
    [self.rtcmixManager parseScoreWithNSString:@"srand() \
        ampenv = maketable(\"line\", 1000, 0,0, 1,1, 2,0) \
        amp = 7000 \
        wave = maketable(\"wave\", 1000, 1, 0.3, 0.01, 0.1) \
     \
        st = 0 \
        for (i = 0; i < 4; i += 1) { \
            freq = irand(200, 1100) \
            WAVETABLE(st, 2.1, amp*ampenv, freq, random(), wave) \
            WAVETABLE(st, 2.1, amp*ampenv, freq + irand(-10, 10), random(), wave) \
            st += irand(0.1, 0.7) \
        } \
     \
        MAXBANG(irand(1.0, 2.0))"];
}

- (IBAction)mbSwitch:(UISwitch *)sender {
    if ([sender isOn]) bangit = 1;
    else bangit = 0;
}


#pragma mark - Delegate Methods (the actual delegate methods)

- (void)maxBang {
    if (bangit == 1) {
        [self.rtcmixManager parseScoreWithNSString:@"st = 0 \
         for (i = 0; i < 4; i += 1) { \
                freq = irand(200, 1100) \
                WAVETABLE(st, 2.1, amp*ampenv, freq, random(), wave) \
                WAVETABLE(st, 2.1, amp*ampenv, freq + irand(-10, 10), random(), wave) \
                st += irand(0.1, 0.7) \
         } \
         \
        MAXBANG(irand(1.0, 2.0))"];
    }
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
