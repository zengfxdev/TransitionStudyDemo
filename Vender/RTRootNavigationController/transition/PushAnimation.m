//
//  PushAnimation.m
//  InteractiveTransitionTest
//
//  Created by 曾凡旭 on 16/9/29.
//  Copyright © 2016年 youpin. All rights reserved.
//

#import "PushAnimation.h"

@implementation PushAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    //这个方法返回动画执行的时间
    return 0.3;
}

/**
 *  transitionContext你可以看作是一个工具，用来获取一系列动画执行相关的对象，并且通知系统动画是否完成等功能。
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    /**
     *  获取动画来自的那个控制器
     */
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    /**
     *  获取转场到的那个控制器
     */
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
  
    UIView *fromView = nil;
    UIView *toView = nil;
    
    if( [transitionContext respondsToSelector:@selector(viewForKey:)] ){
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    else{
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    [containerView addSubview:toView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    toView.layer.transform = CATransform3DMakeTranslation(screenWidth,0,0);
    
    [UIView animateWithDuration:duration animations:^{
        
        fromView.layer.transform = CATransform3DMakeScale(0.94,0.94,1);
        toView.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            fromView.layer.transform = CATransform3DIdentity;
        }else{
            [transitionContext completeTransition:YES];
            fromView.layer.transform = CATransform3DIdentity;
        }
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    
}


@end
