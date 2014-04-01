//
//  MoreViewController.m
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import "MoreViewController.h"
#import "WebViewController.h"

@interface MoreViewController ()

@property (nonatomic, strong) NSArray *settingTexts;
@property (nonatomic, strong) NSArray *configure;

@end

@implementation MoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _settingTexts = [NSArray arrayWithObjects:@"关于我们",@"关于我们",@"关于我们",@"关于我们",@"意见反馈", nil];
    _configure = [NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2], nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _configure.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_configure objectAtIndex:section] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    int sum = 0;
    for (int i = 0; i < _configure.count; i++) {
        if (i < indexPath.section) {
            sum += [[_configure objectAtIndex:i] integerValue];
        }
    }
    sum += indexPath.row;
    NSLog(@"sum is %d", sum);
    cell.textLabel.text = [_settingTexts objectAtIndex:sum];
//    cell.songName.text = [NSString stringWithFormat:@"song name %@", [_songs objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int sum = 0;
    for (int i = 0; i < _configure.count; i++) {
        if (i < indexPath.section) {
            sum += [[_configure objectAtIndex:i] integerValue];
        }
    }
    sum += indexPath.row;
    NSLog(@"sum is %d str is %@", sum, [_settingTexts objectAtIndex:sum]);
    
    switch (sum) {
        case 0:
        {
            WebViewController *webViewVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
            [self.navigationController pushViewController:webViewVC animated:YES];
            webViewVC.title = [_settingTexts objectAtIndex:sum];
        }
            break;
         case 4:
        {
            // http://blog.csdn.net/yhawaii/article/details/7587355
//            NSString *stringURL = @"mailto:test@example.com";
//            NSURL *url = [NSURL URLWithString:stringURL];
//            [[UIApplication sharedApplication] openURL:url];
//            You can also provide more information, for a customized subject and body texts:
            NSString *subject = @"意见反馈";
            NSString *body = @"";
            NSString *address = @"zhaogyrain@gmail.com";
//            NSString *cc = @"test2@akosma.com";
            NSString *path = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", address, subject, body];
            NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            if (![[UIApplication sharedApplication] openURL:url]) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请在设置中登录您的邮箱账户" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
                [alertView show];

            }
        }
            
        default:
            break;
    }
}


@end
