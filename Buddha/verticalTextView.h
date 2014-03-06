//
//  verticalTextView.h
//  PageDemo
//
//  Created by zhaogyrain on 14-3-6.
//  Copyright (c) 2014年 4DTECH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface verticalTextView : UIScrollView

@property (nonatomic, strong) UILabel   *textLabel;
@property (nonatomic, strong) NSString  *textContent;
@property (nonatomic, assign) NSInteger fontSize;

- (id)initWithFrame:(CGRect)frame withString:(NSString *)textContent;

@end
