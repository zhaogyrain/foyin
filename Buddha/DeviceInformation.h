//
//  DeviceInformation.h
//  Buddha
//
//  Created by zhaogyrain on 14-3-22.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import <Foundation/Foundation.h>

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface DeviceInformation : NSObject

@end
