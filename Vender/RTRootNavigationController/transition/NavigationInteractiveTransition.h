//
//  NavigationInteractiveTransition.h
//  InteractiveTransitionTest
//
//  Created by 曾凡旭 on 16/9/28.
//  Copyright © 2016年 youpin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIViewController;
@interface NavigationInteractiveTransition : NSObject<UINavigationControllerDelegate>

- (instancetype)initWithViewController:(UIViewController *)vc;
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;

@end
