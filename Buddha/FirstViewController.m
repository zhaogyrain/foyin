//
//  FirstViewController.m
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import "FirstViewController.h"
#import "iToast.h"

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
    
    [self changeAudioAndTitle];
    _currentTimeSlider.minimumValue = 0.0f;
    _currentTimeSlider.maximumValue = self.player.duration;
    
    // TODO: 本地存储播放状态，随机，单曲循环，顺序等
    [_circleButton setImage:[UIImage imageNamed:@"sequential"] forState:UIControlStateNormal];
    [_circleButton setImage:[UIImage imageNamed:@"sequential2"] forState:UIControlStateHighlighted];
    
    [_currentTimeSlider setThumbImage:[UIImage imageNamed:@"slider_thumb"] forState:UIControlStateNormal];
    [_currentTimeSlider setThumbImage:[UIImage imageNamed:@"slider_thumb2"] forState:UIControlStateHighlighted];
    UIImage *imgMin = [UIImage imageNamed:@"slider_track"];
    UIImage *imgMax = [UIImage imageNamed:@"slider_track_bg"];
    if ([imgMin respondsToSelector:@selector(resizableImageWithCapInsets:resizingMode:)]) {
        imgMin = [imgMin resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch];
        imgMax = [imgMax resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10) resizingMode:UIImageResizingModeStretch];
    } else {
        imgMin = [imgMin stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
        imgMax = [imgMax stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    }
    [_currentTimeSlider setMinimumTrackImage:imgMin forState:UIControlStateNormal];
    [_currentTimeSlider setMaximumTrackImage:imgMax forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button click action
- (IBAction)onPlayListButtonClicked:(id)sender {
    NSLog(@"onPlayListButtonClicked");
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
//    PlayListViewController *vc = (PlayListViewController *)[storyboard instantiateViewControllerWithIdentifier:@"PlayListViewController"];
//    vc.songs = [NSMutableArray arrayWithArray:self.songs];
//    [vc.songTableVIew reloadData];
}

#pragma mark
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"FirstViewControllerToPlayListViewController"])
	{
        PlayListViewController *plvc = segue.destinationViewController;
        plvc.songs = [NSMutableArray arrayWithArray:self.songs];
        [plvc setDelegate:self];
	}
}
#pragma mark -

- (void)changeAudioAndTitle
{
    [self changeTitle];
    [self changeAudioPlay];
}

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

- (void)changeTitle
{
    _titleLable.text = [_songs objectAtIndex:_playSongCount % _songs.count];
}

- (void)changePlayButtonImage:(BOOL)isPlay
{
    if (isPlay) { // 本想根据button的selected来判断，但是当播放完一首音乐时，播放停止，而selected未更新
        [_playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"pause2"] forState:UIControlStateHighlighted];
    } else {
        [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"play2"] forState:UIControlStateHighlighted];
    }
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
    [self changePlayButtonImage:_player.isPlaying];

    IDZTrace();
}

- (IBAction)onNextButtonClicked:(id)sender {
    [self changePlaySountCount:1];
    [self changeAudioAndTitle];
    [self play];
    [self changePlayButtonImage:_player.isPlaying];
//    _player.url = [[NSBundle mainBundle] URLForResource:song withExtension:@"mp3"];
}

- (IBAction)onPreviousButtonClicked:(id)sender {
    [self changePlaySountCount:-1];
    [self changeAudioAndTitle];
    [self play];
    [self changePlayButtonImage:_player.isPlaying];
}

- (IBAction)onCircleButtonClicked:(id)sender {
    _circleButtonClickCount += 1;
    NSString *strNotification;
     if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeOrder) {
         [_circleButton setImage:[UIImage imageNamed:@"sequential"] forState:UIControlStateNormal];
         [_circleButton setImage:[UIImage imageNamed:@"sequential2"] forState:UIControlStateHighlighted];
         strNotification = @"顺序播放";
    } else if(_circleButtonClickCount % kPlaySongModeCount == PlaySongModeCirculateOne) {
        [_circleButton setImage:[UIImage imageNamed:@"repeated"] forState:UIControlStateNormal];
        [_circleButton setImage:[UIImage imageNamed:@"repeated2"] forState:UIControlStateHighlighted];
         strNotification = @"单曲循环";
    } else if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeRandom) {
        [_circleButton setImage:[UIImage imageNamed:@"random"] forState:UIControlStateNormal];
        [_circleButton setImage:[UIImage imageNamed:@"random2"] forState:UIControlStateHighlighted];
         strNotification = @"随机播放";
    }
    
    [_circleButton setTitle:strNotification forState:UIControlStateNormal];
    //TODO: toast 类似百度的样子 好看些，
    [[[[iToast makeText:strNotification]
       setGravity:iToastGravityCenter] setDuration:iToastDurationNormal] show];
}

#pragma mark - PlayListViewControllerDelegate
- (void)onTableViewCellSelected:(NSIndexPath *)indexPath
{
    _circleButtonClickCount = indexPath.row;
    _playSongCount = _circleButtonClickCount;
    [self changeAudioAndTitle];
    [self play];
    [self changePlayButtonImage:_player.isPlaying];
}

#pragma mark - Display Update
- (void)updateDisplay
{
    NSTimeInterval currentTime = _player.currentTime;
    if (!_currentTimeSlider.isTracking)
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
    if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeOrder) {
        [self changePlaySountCount:1];
    } else if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeCirculateOne) {
        [self changePlaySountCount:0];
    } else if (_circleButtonClickCount % kPlaySongModeCount == PlaySongModeRandom) {
        [self changePlaySountCount:rand()];
    }
    [self stopTimer];
    [self updateDisplay];
    [self changeAudioAndTitle];
    [self play];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"%s error=%@", __PRETTY_FUNCTION__, error);
    [self stopTimer];
    [self updateDisplay];
}

- (IBAction)onSliderTouchUpInside:(id)sender {
    // TODO:类似百度音乐的音乐播放时长表示
    UISlider *slider = (UISlider *)sender;
    _player.currentTime = slider.value;
}

@end
