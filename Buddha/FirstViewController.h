//
//  FirstViewController.h
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FirstViewController : UIViewController <AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *previousPlayButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextPlayButton;
@property (weak, nonatomic) IBOutlet UISlider *playSoundSlider;
@property (weak, nonatomic) IBOutlet UISlider *currentTimeSlider;

@end
