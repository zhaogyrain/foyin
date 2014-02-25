//
//  FirstViewController.m
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import "FirstViewController.h"

#define IDZTrace() NSLog(@"%s", __PRETTY_FUNCTION__)

@interface FirstViewController ()

@property (nonatomic, strong) AVAudioPlayer* player;
@property (nonatomic, strong) NSTimer* timer;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL* url = [[NSBundle mainBundle] URLForResource:@"Rondo_Alla_Turka_Short" withExtension:@"aiff"];
    NSAssert(url, @"URL is valid.");
    NSError* error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if(!self.player)
    {
        NSLog(@"Error creating player: %@", error);
    }
    self.player.delegate = self;
    [self.player prepareToPlay];
    self.currentTimeSlider.minimumValue = 0.0f;
    self.currentTimeSlider.maximumValue = self.player.duration;

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPlayListButtonClicked:(id)sender {
    NSLog(@"onPlayListButtonClicked");
}

#pragma mark - Actions

- (IBAction)onPlayButtonclicked:(id)sender {
    if (_player.isPlaying) { // 本想根据button的selected来判断，但是当播放完一首音乐时，播放停止，而selected未更新
        [self pause];
    } else {
        [self play];
    }
    IDZTrace();
}


- (void)play {
    [self.player play];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

- (void)pause {
    IDZTrace();
    [self.player pause];
    [self stopTimer];
    [self updateDisplay];
}

- (IBAction)onNextButtonClicked:(id)sender {
}

- (IBAction)onPreviousButtonClicked:(id)sender {
}

- (IBAction)onCircleButtonClicked:(id)sender {
}
#pragma mark - Display Update
- (void)updateDisplay
{
    NSTimeInterval currentTime = self.player.currentTime;
    self.currentTimeSlider.value = currentTime;
}

#pragma mark - Timer
- (void)timerFired:(NSTimer*)timer
{
    [self updateDisplay];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
    [self updateDisplay];
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"%s successfully=%@", __PRETTY_FUNCTION__, flag ? @"YES"  : @"NO");
    [self stopTimer];
    [self updateDisplay];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"%s error=%@", __PRETTY_FUNCTION__, error);
    [self stopTimer];
    [self updateDisplay];
}


@end
