//
// Created by David Lawson on 14/05/2014.
// Copyright (c) 2014 Livestock Exchange. All rights reserved.
//

#import "UIResponder+Informative.h"

NSString * const kStatusBarTappedNotification = @"statusBarTappedNotification";

@implementation UIResponder (Informative)

- (void)informative_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self informative_touchesBegan:touches withEvent:event];

    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:[(id<UIApplicationDelegate>)self window]];
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    if (touch.window.windowLevel == UIWindowLevelStatusBar && CGRectContainsPoint(statusBarFrame, location)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kStatusBarTappedNotification object:nil];
    }
}

@end