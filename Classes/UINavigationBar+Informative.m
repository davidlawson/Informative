//
// Created by David Lawson on 13/05/2014.
// Copyright (c) 2014 Livestock Exchange. All rights reserved.
//

#import "UINavigationBar+Informative.h"
#import "Informative.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation UINavigationBar (Informative)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self jr_swizzleMethod:@selector(sizeThatFits:) withMethod:@selector(informative_sizeThatFits:) error:nil];
    });
}

- (CGSize)informative_sizeThatFits:(CGSize)size
{
    CGSize normalSize = [self informative_sizeThatFits:size];

    return CGSizeMake(
            normalSize.width,
            [Informative singleton].showInformation ? [Informative singleton].newStatusBarHeight : 40
    );
}

@end