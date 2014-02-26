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
@property (nonatomic, strong) NSArray *songs;
@property (nonatomic, assign) NSInteger playSongCount;
@property (nonatomic, assign) NSInteger circleButtonClickCount;
@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.songs = [NSArray arrayWithObjects:@"jzl", @"sjdqnl", @"wmhxznjg", nil];
    
    [self changeAudioPlay];
    _currentTimeSlider.minimumValue = 0.0f;
    _currentTimeSlider.maximumValue = self.player.duration;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPlayListButtonClicked:(id)sender {
    NSLog(@"onPlayListButtonClicked");
}

#pragma mark -
- (void)changeAudioPlay
{
    //TODO: mp3 format not constant
    NSString *song = [_songs objectAtIndex:_playSongCount % _songs.count];
    NSURL* url = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];
    NSAssert(url, @"URL is valid.");
    NSError* error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if(!self.player)
    {
        NSLog(@"Error creating player: %@", error);
    }
    _player.delegate = self;
    [_player prepareToPlay];

}

#pragma mark - method

- (void)changePlaySountCount:(NSInteger)itemCount
{
    _playSongCount += itemCount;
}

#pragma mark - Actions

- (IBAction)onPlayOrPauseButtonclicked:(id)sender {
    if (_player.isPlaying) { // 本想根据button的selected来判断，但是当播放完一首音乐时，播放停止，而selected未更新
        [self pause];
    } else {
        [self play];
    }
    IDZTrace();
}

- (IBAction)onNextButtonClicked:(id)sender {
    [self changePlaySountCount:1];
    [self changeAudioPlay];
    [self play];
//    _player.url = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];
}

- (IBAction)onPreviousButtonClicked:(id)sender {
    [self changePlaySountCount:-1];
    [self changeAudioPlay];
    [self play];
}

- (IBAction)onCircleButtonClicked:(id)sender {
    _circleButtonClickCount += 1;
    if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeCirculateOne) {
        [_circleButton setTitle:@"单曲循环" forState:UIControlStateNormal];
    } else if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeOrder) {
        [_circleButton setTitle:@"顺序播放" forState:UIControlStateNormal];
    } else if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeRandom) {
        [_circleButton setTitle:@"随机播放" forState:UIControlStateNormal];
    }
}
#pragma mark - Display Update
- (void)updateDisplay
{
    NSTimeInterval currentTime = _player.currentTime;
    _currentTimeSlider.value = currentTime;
}

#pragma mark - avaudioplay operation
- (void)play {
    IDZTrace();
    // TODO: play in background
    [_player play];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

- (void)pause {
    IDZTrace();
    [self.player pause];
    [self stopTimer];
    [self updateDisplay];
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
    if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeCirculateOne) {
        [self changePlaySountCount:0];
    } else if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeOrder) {
        [self changePlaySountCount:1];
    } else if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeRandom) {
        [self changePlaySountCount:rand()];
    }
    [self stopTimer];
    [self updateDisplay];
    [self changeAudioPlay];
    [self play];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"%s error=%@", __PRETTY_FUNCTION__, error);
    [self stopTimer];
    [self updateDisplay];
}


@end
