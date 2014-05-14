//
// Created by David Lawson on 13/05/2014.
// Copyright (c) 2014 Livestock Exchange. All rights reserved.
//

#import "UINavigationBar+Informative.h"
#import "Informative.h"

@implementation UINavigationBar (Informative)

- (CGSize)sizeThatFits:(CGSize)size
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds]; // portrait bounds
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        screenBounds.size = CGSizeMake(screenBounds.size.height, screenBounds.size.width);
    }
    
    return CGSizeMake(
            screenBounds.size.width,
            [Informative singleton].showInformation ? [Informative singleton].newStatusBarHeight : 40
    );
}

@end