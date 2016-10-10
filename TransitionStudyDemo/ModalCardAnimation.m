//
//  ModalCardAnimation.m
//  TransitionStudyDemo
//
//  Created by 曾凡旭 on 16/10/9.
//  Copyright © 2016年 zengfx. All rights reserved.
//

#import "ModalCardAnimation.h"

@implementation ModalCardAnimation

#pragma mark - delegate
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    // Modal 转场⚠️:presentingView 并非 containerView 的子视图，这时通过viewForKey:方法来获取 presentingView 得到的是 nil
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    CGRect initframe = [transitionContext initialFrameForViewController:fromVC];
    CGRect offScreenFrame = initframe;
    offScreenFrame.origin.y = initframe.size.height;
    
    CATransform3D t1 = [self firstTransform];
    CATransform3D t2 = [self secondTransformWithView:toView];
    
    NSTimeInterval time = [self transitionDuration:transitionContext];
    if( toVC.isBeingPresented ){
        
        toView.frame = offScreenFrame;
        
        [containerView insertSubview:toView aboveSubview:fromView];
        
        [UIView animateKeyframesWithDuration:time delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
            
            // 1. 把fromView 推到 后面
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.4 animations:^{
                fromView.layer.transform = t1;
                fromView.alpha = 0.6;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.4 animations:^{
                fromView.layer.transform = t2;
            }];
            
            // 2. toView起来
            [UIView addKeyframeWithRelativeStartTime:0.6f relativeDuration:0.2 animations:^
             {
                 toView.frame = initframe;
             }];
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    if( fromVC.isBeingDismissed ){
        CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
        toView.frame = initFrame;
        CATransform3D scale = CATransform3DIdentity;
        scale = CATransform3DScale(scale, 0.6, 0.6, 1);
        toView.layer.transform = scale;
        toView.alpha = 0.6;
        
        [containerView insertSubview:toView belowSubview:fromView];
        
        CATransform3D t1 = [self firstTransform];
        
        [UIView animateKeyframesWithDuration:time delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
            
            // 1. fromView 下沉消失
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                fromView.frame = offScreenFrame;
            }];
            
            // 2. toView 还原
            [UIView addKeyframeWithRelativeStartTime:0.35f relativeDuration:0.35 animations:^{
                toView.layer.transform = t1;
                toView.alpha = 1.0f;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
                toView.layer.transform = CATransform3DIdentity;
            }];
        
        } completion:^(BOOL finished) {
            if ([transitionContext transitionWasCancelled]) {
                toView.layer.transform = CATransform3DIdentity;
                toView.alpha = 1.0;
            }
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

-(CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = -1/900.0;
    t1 = CATransform3DScale(t1, 0.9, 0.9, 1);
    t1 = CATransform3DRotate(t1, 30*M_PI/180.0, 1, 0, 0);
    return t1;
}

-(CATransform3D)secondTransformWithView:(UIView*)view{
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    t2 = CATransform3DTranslate(t2, 0, view.frame.size.height*-0.08, 0);
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    return t2;
}


@end
