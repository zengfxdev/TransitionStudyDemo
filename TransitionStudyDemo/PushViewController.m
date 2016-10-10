//
//  PushViewController.m
//  TransitionStudyDemo
//
//  Created by 曾凡旭 on 16/10/9.
//  Copyright © 2016年 zengfx. All rights reserved.
//

#import "PushViewController.h"
#import "Masonry.h"
#import "PushSecViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self setupBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{
    self.navigationItem.title = @"push & pop";
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)setupBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickPushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

-(void)clickPushAction:(id)sender{
    PushSecViewController *vc = [[PushSecViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
