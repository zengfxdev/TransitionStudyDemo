//
//  ModalViewController.m
//  TransitionStudyDemo
//
//  Created by 曾凡旭 on 16/10/9.
//  Copyright © 2016年 zengfx. All rights reserved.
//

#import "ModalViewController.h"
#import "ModalCardAnimation.h"
#import "ModalSecViewController.h"
#import "Masonry.h"
#import "RTRootNavigationController.h"

@interface ModalViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self setupBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setup{
    self.navigationItem.title = @"modal";
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)setupBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"modal" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickPushAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

-(void)clickPushAction:(id)sender{
    ModalSecViewController *vc = [[ModalSecViewController alloc] init];
    UINavigationController *nav = [[RTContainerNavigationController alloc] initWithRootViewController:vc];
    nav.transitioningDelegate = self;
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

#pragma mark - delegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [ModalCardAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [ModalCardAnimation new];
}

@end
