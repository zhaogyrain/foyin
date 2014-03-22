//
//  PlayListViewController.h
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayListViewControllerDelegate <NSObject>

- (void)onTableViewCellSelected:(NSIndexPath *)indexPath;

@end

@interface PlayListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *songs;
@property (weak, nonatomic) IBOutlet UITableView *songTableVIew;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (nonatomic, weak) id<PlayListViewControllerDelegate> delegate;

@end
