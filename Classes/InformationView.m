//
// Created by David Lawson on 14/05/2014.
// Copyright (c) 2014 Livestock Exchange. All rights reserved.
//

#import "InformationView.h"
#import <Masonry/Masonry.h>

@implementation InformationView

- (id)initWithScreenBounds
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds]; // portrait bounds
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
    {
        screenBounds.size = CGSizeMake(screenBounds.size.height, screenBounds.size.width);
    }

    screenBounds.origin.y = -40;
    screenBounds.size.height = 20;

    return [self initWithFrame:screenBounds];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];

        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(20);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];

        self.alpha = 0.0f;

        [self setDefaults];
    }

    return self;
}

// Set the autoresize mask after the screen rotation has been applied
- (void)didMoveToWindow
{
    [super didMoveToWindow];

    // We can't use autolayout as the superview is the UINavigationBar
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)setDefaults
{
    self.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:85.0f/255.0f blue:85.0f/255.0f alpha:1.0];
    self.text = @"Information View";
    self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    self.textColor = [UIColor whiteColor];
}

- (void)showView:(BOOL)animated
{
    void (^animateTo)() = ^{
        self.frame = CGRectMake(0, -20, self.bounds.size.width, 40);
        self.alpha = 1.0f;
    };

    if (animated)
    {
        self.frame = CGRectMake(0, -40, self.bounds.size.width, 20);
        self.alpha = 0.0f;

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
}

- (void)hideView:(BOOL)animated
{
    void (^animateTo)() = ^{
        self.frame = CGRectMake(0, -40, self.bounds.size.width, 20);
        self.alpha = 0.0f;
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
}

- (void)setText:(NSString *)text
{
    self.textLabel.text = text;
}

- (void)setTextColor:(UIColor *)textColor
{
    self.textLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font
{
    self.textLabel.font = font;
}

@end