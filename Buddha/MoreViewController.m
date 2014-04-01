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
    
    WebViewController *ebookCv = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    [self presentViewController:ebookCv animated:YES completion:^{
    }];
}


@end
