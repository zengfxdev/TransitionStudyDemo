//
//  ModalSecViewController.m
//  TransitionStudyDemo
//
//  Created by 曾凡旭 on 16/10/9.
//  Copyright © 2016年 zengfx. All rights reserved.
//

#import "ModalSecViewController.h"

@interface ModalSecViewController ()

@end

@implementation ModalSecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    [self setupNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{
    self.navigationItem.title = @"modal second";
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)setupNav{
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backbtn.frame = CGRectMake(0, 0, 44, 44);
    [backbtn setTitle:@"back" forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(clickBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backbtn];
}

-(void)clickBackAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
