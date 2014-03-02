//
//  FirstViewController.h
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PlayListViewController.h"

typedef enum {
    PlaySongModeOrder,
    PlaySongModeCirculateOne,
    PlaySongModeRandom,
} PlaySongModeType;

#define kPlaySongModeCount 3

@interface FirstViewController : UIViewController <AVAudioPlayerDelegate, PlayListViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *previousPlayButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextPlayButton;
@property (weak, nonatomic) IBOutlet UISlider *playSoundSlider;
@property (weak, nonatomic) IBOutlet UISlider *currentTimeSlider;
@property (weak, nonatomic) IBOutlet UIButton *circleButton;

@property (assign, nonatomic) PlaySongModeType *playSongModeType;

@end
