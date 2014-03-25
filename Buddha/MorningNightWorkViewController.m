//
//  MorningNightWorkViewController.m
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import "MorningNightWorkViewController.h"
#import "PlayListTableViewCell.h"
#import "DeviceInformation.h"
#import "EbookControllerView.h"

@interface MorningNightWorkViewController ()

@property (nonatomic, strong) NSArray *lessons;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation MorningNightWorkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (iPhone5) {
        [_backgroundImage setImage:[UIImage imageNamed:@"bg_l.jpg"]];
    } else {
        [_backgroundImage setImage:[UIImage imageNamed:@"bg.jpg"]];
    }

    _lessons = [NSArray arrayWithObjects:@"佛说阿弥陀经", @"大悲咒", @"大悲咒", @"大悲咒", @"大悲咒", @"大悲咒", @"大悲咒", @"大悲咒", @"大悲咒", @"大悲咒", @"大悲咒", @"大悲咒", @"大悲咒", nil];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initPlayer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lessons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LessonListTableViewCell";
    PlayListTableViewCell *cell = (PlayListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.songName.text = [NSString stringWithFormat:@"song name %@", [_lessons objectAtIndex:indexPath.row]];    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [v setBackgroundColor:[UIColor colorWithRed:100.0f/255.0f green:165.0f/255.0f blue:215.0f/255.0f alpha:1]];
    _playButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 4, 42, 42)];
    [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_playButton setImage:[UIImage imageNamed:@"play2"] forState:UIControlStateHighlighted];
    [_playButton addTarget:self action:@selector(onPlayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:_playButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, 320, 21)];
    label.text = @"早/晚课";
    [label setFont:[UIFont systemFontOfSize:21]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [v addSubview:label];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    EbookControllerView *ebookCv = [self.storyboard instantiateViewControllerWithIdentifier:@"EbookControllerView"];
    ebookCv.ebookFileName = [_lessons objectAtIndex:row];
    [self.navigationController pushViewController:ebookCv animated:YES];
//    [self presentViewController:ebookCv animated:YES completion:^{
//        
//    }];
}

- (void)onPlayButtonClicked:(id)sender {
    if (_player.isPlaying) { // 本想根据button的selected来判断，但是当播放完一首音乐时，播放停止，而selected未更新
        [self.player pause];
    } else {
        [self.player play];
    }
    [self changePlayButtonImage:_player.isPlaying];

}

#pragma mark - 


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

- (void)initPlayer
{
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"sjdqnl" withExtension:@"mp3"];
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

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self initPlayer];
    NSLog(@"%s successfully=%@", __PRETTY_FUNCTION__, flag ? @"YES"  : @"NO");
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"%s error=%@", __PRETTY_FUNCTION__, error);
}

@end
