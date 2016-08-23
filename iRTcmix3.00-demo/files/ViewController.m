//
//  ViewController.m
//  RTcmix New Library
//
//  Created by Damon Holzborn on 1/10/15.
//  Copyright (c) 2015 Rustle Works. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)					RTcmixPlayer			*rtcmixManager;
@property (nonatomic, strong)	IBOutlet		UISegmentedControl	*audioSessionCategoryControl;
@property (nonatomic, strong)	IBOutlet		UISegmentedControl	*channelsControl;
@property (nonatomic, strong)	IBOutlet		UISwitch					*defaultToSpeakerSwitch;
@property (nonatomic, strong)	IBOutlet		UISwitch					*mixWithOthersSwitch;
@property (nonatomic, strong)	IBOutlet		UISwitch					*maxBangSwitch;
@property (nonatomic, strong)	IBOutlet		UISwitch					*maxMessageSwitch;
@property (nonatomic, strong)	IBOutlet		UITextView				*maxErrorTextView;
@property (nonatomic, strong)	IBOutlet		UITextView				*audioParameterWarningTextView;


@end

@implementation ViewController

#pragma mark - Audio Parameter Setup

- (IBAction)goPause:(UIButton *)sender {
	//[self.rtcmixManager parseScoreWithNSString:@"MAXMESSAGE(0, 1, 2, 4, 6, \"poopy\")"];
	[self.rtcmixManager pauseRTcmix];
}
- (IBAction)goReset:(UIButton *)sender {
	[self.rtcmixManager semiResetAudioParameters];
}
- (IBAction)goStart:(UIButton *)sender {
	[self.rtcmixManager resumeRTcmix];
}
- (IBAction)go22K:(UIButton *)sender {
	[self.rtcmixManager parseScoreWithNSString:@"rtsetparams(22050, 2)"];
}




- (IBAction)changeAudioSessionCategory:(UISegmentedControl *)sender {
	if (sender.selectedSegmentIndex == 0)
	{
		self.rtcmixManager.avAudioSessionCategory = AVAudioSessionCategoryPlayback;
	}
	else if (sender.selectedSegmentIndex == 1)
	{
		self.rtcmixManager.avAudioSessionCategory = AVAudioSessionCategoryPlayAndRecord;
	}
	else
	{
		self.rtcmixManager.avAudioSessionCategory = AVAudioSessionCategoryAmbient;
	}
	[self.rtcmixManager resetAudioParameters];
}

- (IBAction)changeAudioSessionCategoryOption:(UISwitch *)sender {
	[self.rtcmixManager.avAudioSessionCategoryOptions removeAllObjects];
	if (self.defaultToSpeakerSwitch.on)
	{
		[self.rtcmixManager.avAudioSessionCategoryOptions addObject:[NSNumber numberWithInteger:AVAudioSessionCategoryOptionDefaultToSpeaker]];
	}
	else
	{
		[self.rtcmixManager.avAudioSessionCategoryOptions addObject:[NSNumber numberWithInteger:AVAudioSessionCategoryOptionMixWithOthers]];
	}
	[self.rtcmixManager resetAudioParameters];
}

- (IBAction)changeSampleRate:(UISegmentedControl *)sender {
	if (sender.selectedSegmentIndex == 0)
	{
		self.rtcmixManager.preferredSampleRate = 22050;
	}
	else
	{
		self.rtcmixManager.preferredSampleRate = 44100;
	}
	self.audioParameterWarningTextView.text = @"";
	[self.rtcmixManager resetAudioParameters];
}

- (IBAction)changeBufferSize:(UISegmentedControl *)sender {
	if (sender.selectedSegmentIndex == 0)
	{
		self.rtcmixManager.preferredBufferSize = 256;
	}
	else if (sender.selectedSegmentIndex == 1)
	{
		self.rtcmixManager.preferredBufferSize = 512;
	}
	else
	{
		self.rtcmixManager.preferredBufferSize = 1024;
	}
	self.audioParameterWarningTextView.text = @"";
	[self.rtcmixManager resetAudioParameters];
}

- (IBAction)changeChannels:(UISegmentedControl *)sender {
	if (sender.selectedSegmentIndex == 0)
	{
		self.rtcmixManager.preferredNumberOfChannels = 1;
	}
	else if (sender.selectedSegmentIndex == 1)
	{
		self.rtcmixManager.preferredNumberOfChannels = 2;
	}
	else
	{
		self.rtcmixManager.preferredNumberOfChannels = 4;
	}
	self.audioParameterWarningTextView.text = @"";
	[self.rtcmixManager resetAudioParameters];
}

#pragma mark - Play Score Files

- (IBAction)goBeep:(UIButton *)sender {
	[self.rtcmixManager parseScoreWithNSString:@"WAVETABLE(0, 3.5, 28000, 9.0, .5)"];
}

- (IBAction)goBoop:(UIButton *)sender {
	NSString *scorePath = [[NSBundle mainBundle] pathForResource:@"Boop" ofType:@"sco"];
	[self.rtcmixManager parseScoreWithFilePath:scorePath];
}

- (IBAction)goBop:(UIButton *)sender {
	[self.rtcmixManager parseScoreWithResource:@"Bop" ofType:@"sco"];
}

- (IBAction)goFlush:(UIButton *)sender {
	[self.rtcmixManager flushAllScores];
}

#pragma mark - Process Audio Input

- (IBAction)goEcho:(UIButton *)sender {
	if ([self.rtcmixManager.avAudioSessionCategory isEqualToString:AVAudioSessionCategoryPlayAndRecord])
	{
		[self.rtcmixManager parseScoreWithNSString:@"rtinput(\"AUDIO\") DELAY(0, 0, 10, 1, .4, .401, 2, 0, .5)"];
	}
	else
	{
		UIAlertView *echoAlert = [[UIAlertView alloc] initWithTitle:@"Audio Input Not Enabled"
																				 message:@"Select 'PlayAndRecord' in the AVAudioSessionCategory section."
																				delegate:nil
																	cancelButtonTitle:@"Dismiss"
																	otherButtonTitles:nil];
		[echoAlert show];
	}
}

#pragma mark - Play Audio Files

- (IBAction)goLoochFilePath:(UIButton *)sender {
	if (self.channelsControl.selectedSegmentIndex > 0)
	{
		NSString *hammerScore = @"rtinput(\"MMBUF\", \"loocher01\") STEREO(0, 0, 3.734, 0.4, 0, 1)";
		[self.rtcmixManager parseScoreWithNSString:hammerScore];
	}
	else
	{
		UIAlertView *channelsAlert = [[UIAlertView alloc] initWithTitle:@"Audio Settings Invalid"
																			 message:@"This score requires stero output. Change \"Channels\" to 2 or more."
																			delegate:nil
																cancelButtonTitle:@"Dismiss"
																otherButtonTitles:nil];
		[channelsAlert show];
	}
}

- (IBAction)goLoochResource:(UIButton *)sender {
	if (self.channelsControl.selectedSegmentIndex > 0)
	{
		NSString *ruffScore = @"rtinput(\"MMBUF\", \"loocher02\") STEREO(0, 0, 4.192, .4, 0, 1)";
		[self.rtcmixManager parseScoreWithNSString:ruffScore];
	}
	else
	{
		UIAlertView *channelsAlert = [[UIAlertView alloc] initWithTitle:@"Audio Settings Invalid"
																				  message:@"This score requires stero output. Change \"Channels\" to 2 or more."
																				 delegate:nil
																	 cancelButtonTitle:@"Dismiss"
																	 otherButtonTitles:nil];
		[channelsAlert show];
	}
}

- (IBAction)goHammer:(UIButton *)sender {
	if (self.channelsControl.selectedSegmentIndex > 0)
	{
		NSString *hammerPath = [[NSBundle mainBundle] pathForResource:@"AdamsJackhammer" ofType:@"aif"];
		NSString *hammerScore = [NSString stringWithFormat:@"rtinput(\"%@\") STEREO(0, 0, 17.63, .4, 0, 1)", hammerPath];
		[self.rtcmixManager parseScoreWithNSString:hammerScore];
	}
	else
	{
		UIAlertView *channelsAlert = [[UIAlertView alloc] initWithTitle:@"Audio Settings Invalid"
																				  message:@"This score requires stero output. Change \"Channels\" to 2 or more."
																				 delegate:nil
																	 cancelButtonTitle:@"Dismiss"
																	 otherButtonTitles:nil];
		[channelsAlert show];
	}
}

#pragma mark - Real-time Control

- (IBAction)goPfieldVariables:(UIButton *)sender {
	[self.rtcmixManager parseScoreWithResource:@"Real-timeControl" ofType:@"sco"];
}

- (IBAction)changePfieldSlider:(UISlider *)sender {
	[self.rtcmixManager setInlet:1 withValue:sender.value];
}

#pragma mark - Delegate Methods (interaction from interface)

- (IBAction)goMaxBang:(UISwitch *)sender {
	if (self.maxBangSwitch.on)
	{
		[self.rtcmixManager parseScoreWithNSString:@"MAXBANG(0)"];
	}
}

- (IBAction)goMaxMessage:(UISwitch *)sender {
	if (self.maxMessageSwitch.on)
	{
		[self.rtcmixManager parseScoreWithNSString:@"print_on(2) MAXMESSAGE(0, 7777)"];
	}
}

- (IBAction)goMaxError:(id)sender {
	// Send a score that contains a print statement and an errror.
	[self.rtcmixManager parseScoreWithNSString:@"print_on(2) print(\"This is a print statement.\") foo = bar"];
}

-(void)setErrorTextField:(NSString *)text {
	// This method is necessary because changes to the UI have to be done on the main thread and the
	// RTcmixPlayer delegate methods are called from another thread.
	self.maxErrorTextView.text = [self.maxErrorTextView.text stringByAppendingString:text];
    // BGG - this is so that the UITextView will scroll as we add more messages to it
    [self.maxErrorTextView scrollRangeToVisible:NSMakeRange([self.maxErrorTextView.text length], 0)];
}


#pragma mark - Delegate Methods (the actual delegate methods)

- (void)maxBang {
	if (self.maxBangSwitch.on)
	{
		[self.rtcmixManager parseScoreWithNSString:@"MAXBANG(.25) WAVETABLE(.25, .2, 24000, 440, .5)"];
	}
}

- (void)maxMessage:(NSArray *)message {
	NSMutableString *maxMessageMessage = [NSMutableString stringWithString:@"I have a message:\n"];
	
	for (NSNumber *item in message)
	{
		[maxMessageMessage appendFormat:@"%@ ", item];
	}
	[maxMessageMessage appendString:@"\n"];

	[self performSelectorOnMainThread:@selector(setErrorTextField:) withObject:maxMessageMessage waitUntilDone:NO];

	if (self.maxMessageSwitch.on)
	{
		[self.rtcmixManager parseScoreWithNSString:@"freq = irand(220, 440) hardness = random() position = random() preset = irand(8) MMODALBAR(.25, .2, 24000, freq, hardness, position, preset)  MAXMESSAGE(.25, freq, hardness, position, preset)"];
	}
}

- (void)maxError:(NSString *)error {
	//[self.errorMessage appendString:error];
	[self performSelectorOnMainThread:@selector(setErrorTextField:) withObject:error waitUntilDone:NO];
}

- (void)audioSettingWarning:(NSDictionary *)warnings {
	NSMutableString *warningMessage = [NSMutableString stringWithString:@"Audio Setting Warnings:\n"];
	for (NSString *setting in warnings)
	{
		NSArray *settingsArray = warnings[setting];
		NSNumber *preferred = settingsArray[0];
		NSNumber *actual = settingsArray[1];
		[warningMessage appendFormat:@"%@:\n\tpreferred: %@\n\tactual: %@\n", setting, preferred, actual];
	}
	self.audioParameterWarningTextView.text = warningMessage;
	//NSLog(@"audioSettingWarning: %@", warnings);
}

//-(void)setAudioParameterWarningTextField:(NSString *)text {
//	// This method is necessary because changes to the UI have to be done on the main thread and the
//	// RTcmixPlayer delegate methods are called from another thread.
//	self.audioParameterWarningTextView.text = [self.maxErrorTextView.text stringByAppendingString:text];
//}

#pragma mark - Other Features


- (IBAction)destroyRTcmix:(UIButton *)sender {
	[self.rtcmixManager destroyRTcmix];
}

- (IBAction)restartRTcmix:(UIButton *)sender {
	[self.rtcmixManager startAudio];
}


#pragma mark - View Controller Default Methods


- (void)viewDidLoad {
	[super viewDidLoad];

	self.rtcmixManager = [RTcmixPlayer sharedManager];
	self.rtcmixManager.delegate = self;
	[self.rtcmixManager startAudio];
	
	// Run a score that contains some setup information that is used in some of the demo scores.
	[self.rtcmixManager parseScoreWithResource:@"Setup" ofType:@"sco"];
	
	// Load sample buffers into RAM. These are used in the "Play Audio Files - From Memory" section.
	//There are two different methods for loading sample buffers.
	// 1) Provide the full path:
	NSString *loocher01Path = [[NSBundle mainBundle] pathForResource:@"loocher01" ofType:@"aif"];
	[self.rtcmixManager setSampleBuffer:@"loocher01" withFilePath:loocher01Path];
	// Or 2) shortcut for files in the root level of the apps resources:
	[self.rtcmixManager setSampleBuffer:@"loocher02" withResource:@"loocher02" ofType:@"aif"];

    // BGG - this is so that the UITextView will scroll smoothly as we add more messages to it
    self.maxErrorTextView.layoutManager.allowsNonContiguousLayout = NO;
}


@end
