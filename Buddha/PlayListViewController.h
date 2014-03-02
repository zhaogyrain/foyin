//
//  PlayListViewController.h
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *songs;
@property (weak, nonatomic) IBOutlet UITableView *songTableVIew;

@end
