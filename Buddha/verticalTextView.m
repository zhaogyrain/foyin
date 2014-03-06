//
//  verticalTextView.m
//  PageDemo
//
//  Created by zhaogyrain on 14-3-6.
//  Copyright (c) 2014年 4DTECH. All rights reserved.
//

#import "verticalTextView.h"

@implementation verticalTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initInstant];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withString:(NSString *)textContent
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _textContent = textContent;
        [self initInstant];
        [self createTextLabel];
        [self setScroolViewContentFrame];
    }
    return self;
}

- (void)initInstant
{
    _fontSize = 18;
}

- (void)createTextLabel
{
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 22)];
    _textLabel.font = [UIFont systemFontOfSize:_fontSize];
    _textLabel.text = _textContent;
    _textLabel.numberOfLines = 0;
    CGSize fitSize = [_textLabel sizeThatFits:CGSizeMake(CGRectGetWidth(_textLabel.frame), 0)];
    _textLabel.frame = CGRectMake(CGRectGetMinX(_textLabel.frame), CGRectGetMinY(_textLabel.frame), fitSize.width, fitSize.height);
    [self addSubview:_textLabel];
}

- (void)setScroolViewContentFrame
{
    self.contentSize = CGSizeMake(CGRectGetWidth(_textLabel.frame), CGRectGetHeight(_textLabel.frame));
}
@end
