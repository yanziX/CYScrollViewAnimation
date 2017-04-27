//
//  ViewController.m
//  CYScrollViewAnimation
//
//  Created by storm on 17/4/27.
//  Copyright © 2017年 strom. All rights reserved.
//

#import "ViewController.h"
#import "CYNonCarouselView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轮播Demo";
    
    CYNonCarouselView *nonView = [[CYNonCarouselView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    nonView.imagesArr = @[@"1.jpg",@"placeholderImage.jpg",@"1.jpg",@"placeholderImage.jpg"];
    nonView.cornerNum = 10;
    [self.view addSubview:nonView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
