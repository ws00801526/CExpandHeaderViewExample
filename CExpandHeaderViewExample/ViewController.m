//
//  ViewController.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-27.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import "ViewController.h"
#import "CExpandHeader.h"

@interface ViewController () <UIScrollViewDelegate>

@end

@implementation ViewController{
    CExpandHeader *_header;
    __weak IBOutlet UITableView *_tableView;
    __weak UIImageView *_expandView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [imageView setImage:[UIImage imageNamed:@"image"]];
    
    _header = [CExpandHeader expandWithScrollView:_tableView expandView:imageView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 99;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.textLabel setText:[NSString  stringWithFormat:@"this is row :%ld",(long)indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

@end
