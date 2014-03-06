//
//  EbookControllerView.m
//  Buddha
//
//  Created by zhaogyrain on 14-3-6.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import "EbookControllerView.h"
#import "verticalTextView.h"

@interface EbookControllerView ()

@end

@implementation EbookControllerView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"佛说阿弥陀经" ofType:@"txt"];
    NSString* string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSInteger height = CGRectGetHeight(self.view.frame) - self.tabBarController.tabBar.frame.size.height;
    CGRect rect = CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMinY(self.view.frame), CGRectGetWidth(self.view.frame), height);
    verticalTextView *vText = [[verticalTextView alloc] initWithFrame:rect withString:string];
    
    [self.view addSubview:vText];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
