//
// Created by David Lawson on 13/05/2014.
// Copyright (c) 2014 Livestock Exchange. All rights reserved.
//

#import "Informative.h"
#import "InformationView.h"
#import "JRSwizzle.h"
#import "UIResponder+Informative.h"

@interface Informative()

// Set of all information views in existence
@property (nonatomic, strong) NSMutableSet *informationViews;

@end

@implementation Informative

+ (instancetype)singleton
{
    static Informative *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];

        Class delegateClass = [UIApplication sharedApplication].delegate.class;
        [delegateClass jr_swizzleMethod:@selector(touchesBegan:withEvent:) withMethod:@selector(informative_touchesBegan:withEvent:) error:nil];
    });
    return singleton;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.showInformation = NO;

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(statusBarTappedAction)
                                                     name:kStatusBarTappedNotification
                                                   object:nil];

        [self setupDefaults];
    }

    return self;
}

- (void)tappedInformationView
{
    self.tapInformationView();
}

- (void)statusBarTappedAction
{
    if (self.showInformation)
        self.tapInformationView();
}

- (void)setupDefaults
{
    self.newStatusBarHeight = 60;

    self.createInformationView = ^UIView*
    {
        return [[InformationView alloc] initWithScreenBounds];
    };

    self.showInformationView = ^(UIView *view, BOOL animated)
    {
        if ([view isKindOfClass:[InformationView class]])
            return [(InformationView *)view showView:animated];

        void (^animateTo)() = ^{
            view.frame = CGRectMake(0, -20, 320, 40);
            view.alpha = 1.0f;
        };

        if (animated)
        {
            view.frame = CGRectMake(0, -40, 320, 20);
            view.alpha = 0.0f;

            [UIView animateWithDuration:1.0f
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:animateTo
                             completion:nil];
        }
        else
        {
            animateTo();
        }
    };

    self.hideInformationView = ^(UIView *view, BOOL animated)
    {
        if ([view isKindOfClass:[InformationView class]])
            return [(InformationView *)view hideView:animated];

        void (^animateTo)() = ^{
            view.frame = CGRectMake(0, -40, 320, 20);
            view.alpha = 0.0f;
        };

        if (animated)
        {
            [UIView animateWithDuration:1.0f
                                  delay:0
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:animateTo
                             completion:nil];
        }
        else
        {
            animateTo();
        }
    };
}

- (NSMutableSet *)informationViews
{
    if (!_informationViews)
    {
        _informationViews = [[NSMutableSet alloc] init];
    }

    return _informationViews;
}

- (UIView *)newInformationView
{
    UIView *informationView = self.createInformationView();
    [informationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedInformationView)]];
    [self.informationViews addObject:informationView];
    return informationView;
}

- (void)removeInformationView:(UIView *)informationView
{
    int n = informationView.gestureRecognizers.count;
    for (int i = 0; i < n; i++)
        [informationView removeGestureRecognizer:informationView.gestureRecognizers.firstObject];

    [self.informationViews removeObject:informationView];
}

- (void)modifyInformationViews:(void (^)(UIView *))modifyBlock
{
    for (UIView *view in self.informationViews)
    {
        modifyBlock(view);
    }
}

@end