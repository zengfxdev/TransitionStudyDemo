//
//  PopAnimation.m
//  InteractiveTransitionTest
//
//  Created by 曾凡旭 on 16/9/28.
//  Copyright © 2016年 youpin. All rights reserved.
//

#import "PopAnimation.h"

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

@implementation PopAnimation

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
    
    /**
     *  转场动画是两个控制器视图时间的动画，需要一个containerView来作为一个“舞台”，让动画执行。
     */
    UIView *containerView = [transitionContext containerView];
    // ❗️1.
    [containerView insertSubview:toView belowSubview:fromView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // tofromvc
    CGAffineTransform transf = CGAffineTransformIdentity;
    toView.transform = CGAffineTransformScale(transf, 0.94, 0.94);
    
    /**
     *  执行动画，我们让fromVC的视图移动到屏幕最右侧
     */
    [UIView animateWithDuration:duration animations:^{
        toView.transform = CGAffineTransformIdentity;
        
        fromView.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
    }completion:^(BOOL finished) {
        // 转场结束后，恢复视图状态
        toView.layer.transform = CATransform3DIdentity;
        /**
         *  当你的动画执行完成，这个方法必须要调用，否则系统会认为你的其余任何操作都在动画执行过程中。
         */
        // ❗️2.
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


@end
