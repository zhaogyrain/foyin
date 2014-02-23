//
//  PlayListTableViewCell.h
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@end
