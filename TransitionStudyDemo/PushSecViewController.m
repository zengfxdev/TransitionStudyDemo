//
//  PushSecViewController.m
//  TransitionStudyDemo
//
//  Created by 曾凡旭 on 16/10/9.
//  Copyright © 2016年 zengfx. All rights reserved.
//

#import "PushSecViewController.h"

@interface PushSecViewController ()

@end

@implementation PushSecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setup{
    self.navigationItem.title = @"push second";
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
