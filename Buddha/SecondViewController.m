//
//  SecondViewController.m
//  Buddha
//
//  Created by zhaogyrain on 14-2-23.
//  Copyright (c) 2014年 zhaogyrain. All rights reserved.
//

#import "SecondViewController.h"
#import "BooksTableViewCell.h"
#import "EbookControllerView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onBackButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismissViewControllerAnimated PlayListViewController");
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BooksTableViewCell";
    BooksTableViewCell *cell = (BooksTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.bookName.text = [NSString stringWithFormat:@"song name %d", indexPath.row];
    [cell.bookImageIcon setImage:[UIImage imageNamed:@"second"]];
    
    return cell;
}

#pragma mark
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"EbookControllerView"])
	{
        EbookControllerView *ebookvc = segue.destinationViewController;
        ebookvc.ebookTitle = @"佛说阿弥陀经";
//        [plvc setDelegate:self];
        
	}
}

@end
