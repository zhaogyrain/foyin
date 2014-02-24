//
//  BooksTableViewCell.m
//  Buddha
//
//  Created by zhaogyrain on 14-2-24.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import "BooksTableViewCell.h"

@implementation BooksTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
