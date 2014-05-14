//
// Created by David Lawson on 14/05/2014.
// Copyright (c) 2014 Livestock Exchange. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InformationView : UIView

@property (nonatomic, strong) UILabel *textLabel;

- (id)initWithScreenBounds;

- (void)showView:(BOOL)animated;
- (void)hideView:(BOOL)animated;

- (void)setText:(NSString *)text;
- (void)setTextColor:(UIColor *)textColor;
- (void)setFont:(UIFont *)font;

@end