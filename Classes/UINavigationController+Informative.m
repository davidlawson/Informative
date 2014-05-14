//
// Created by David Lawson on 13/05/2014.
// Copyright (c) 2014 Livestock Exchange. All rights reserved.
//

#import <objc/runtime.h>
#import "UINavigationController+Informative.h"
#import "JRSwizzle.h"
#import "Informative.h"

@interface UINavigationController ()

@property (nonatomic, strong) UIView *informationView;

@end

@implementation UINavigationController (Informative)

+ (void)load
{
    // Add code into all UINavigationControllers to show an information view when necessary

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self jr_swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(informative_viewWillAppear:) error:nil];
        [self jr_swizzleMethod:@selector(viewDidDisappear:) withMethod:@selector(informative_viewDidDisappear:) error:nil];
    });
}

- (void)informative_viewWillAppear:(BOOL)animated
{
    [self informative_viewWillAppear:animated];

    [[Informative singleton] addObserver:self forKeyPath:@"showInformation" options:0 context:NULL];
    [self displayInformative:[Informative singleton].showInformation animated:NO];
}

- (void)informative_viewDidDisappear:(BOOL)animated
{
    [self informative_viewDidDisappear:animated];

    [[Informative singleton] removeObserver:self forKeyPath:@"showInformation"];

    UIView *informationView = self._informationView;
    if (informationView)
    {
        [[Informative singleton] removeInformationView:informationView];
        [informationView removeFromSuperview];
        self.informationView = nil;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self displayInformative:[Informative singleton].showInformation animated:YES];
}

- (void)displayInformative:(BOOL)showInformation animated:(BOOL)animated
{
    // Update information view

    if (showInformation)
    {
        [self.navigationBar addSubview:self.informationView];
        [Informative singleton].showInformationView(self.informationView, animated);
    }
    else if (self.informationViewLoaded)
    {
        [Informative singleton].hideInformationView(self.informationView, animated);
    }

    // Update navigation bar height

    [self.view setNeedsLayout];

    if (animated)
    {
        [UIView animateWithDuration:1.0f
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                                        [self.navigationBar sizeToFit];
                                        [self.view layoutIfNeeded];
                                    }
                         completion:nil];
    }
    else
    {
        [self.navigationBar sizeToFit];
        [self.view layoutIfNeeded];
    }
}

- (void)setInformationView:(UIView *)informationView
{
    objc_setAssociatedObject(self, @selector(informationView), informationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)_informationView
{
    return objc_getAssociatedObject(self, @selector(informationView));
}

- (BOOL)informationViewLoaded
{
    return self._informationView != nil;
}

- (UIView *)informationView
{
    UIView *informationView = self._informationView;

    if (!informationView)
    {
        informationView = [[Informative singleton] newInformationView];
        [self setInformationView:informationView];
    }

    return informationView;
}

@end