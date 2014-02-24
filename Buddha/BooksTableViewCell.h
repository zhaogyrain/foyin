//
//  BooksTableViewCell.h
//  Buddha
//
//  Created by zhaogyrain on 14-2-24.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BooksTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageIcon;

@end
