//
//  ScrollTestViewController.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-28.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import "ScrollTestViewController.h"
#import "CExpandHeader.h"
@interface ScrollTestViewController ()

@end

@implementation ScrollTestViewController{
    
    __weak IBOutlet UIScrollView *scrollView;
    CExpandHeader *_header;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [imageView setImage:[UIImage imageNamed:@"image"]];
    [scrollView setContentSize:CGSizeMake(0, 800)];
    _header = [CExpandHeader expandWithScrollView:scrollView expandView:imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
