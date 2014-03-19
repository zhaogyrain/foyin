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
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom)];
    singleRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleRecognizer];
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = _ebookTitle;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"佛说阿弥陀经" ofType:@"txt"];
    NSString* string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSInteger height = CGRectGetHeight(self.view.frame) - self.tabBarController.tabBar.frame.size.height;
    CGRect rect = CGRectMake(CGRectGetMinX(self.view.frame), CGRectGetMinY(self.view.frame) + 20, CGRectGetWidth(self.view.frame), height - self.navigationController.navigationBar.frame.size.height);
    verticalTextView *vText = [[verticalTextView alloc] initWithFrame:rect withString:string];
    
    [self.view addSubview:vText];
    [self performSelector:@selector(hiddenNavigationBar:) withObject:[NSNumber numberWithBool:!self.navigationController.navigationBar.isHidden] afterDelay:.3];
}

- (void)hiddenNavigationBar:(NSNumber *)hidden
{
    [UIView animateWithDuration:.3 animations:^{
        self.navigationController.navigationBarHidden = [hidden boolValue];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSingleTapFrom
{
    [self hiddenNavigationBar:[NSNumber numberWithBool:!self.navigationController.navigationBar.hidden]];
}

@end
