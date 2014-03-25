//
//  MorningNightWorkViewController.h
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MorningNightWorkViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *lessonTableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@end
