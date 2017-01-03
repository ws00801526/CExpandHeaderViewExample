//
//  ScrollTestViewController.m
//  CExpandHeaderViewExample
//
//  Created by cml on 14-8-28.
//  Copyright (c) 2014年 Mei_L. All rights reserved.
//

#import "ScrollTestViewController.h"
#import "CExpandHeaderViewExample-Swift.h"

@interface ScrollTestViewController ()

@end

@implementation ScrollTestViewController{
    
    __weak IBOutlet UIScrollView *scrollView;
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
    imageView.image = [UIImage imageNamed:@"image"];
    
    
    [scrollView addSubview:imageView];
    [XMNExpander expandWithHeaderView:imageView inScrollView:scrollView maxExpandHeight:300 minExpandHeight:64];
    
    
    [scrollView setContentSize:CGSizeMake(0, 999)];
    scrollView.backgroundColor = [UIColor greenColor];
}

@end
