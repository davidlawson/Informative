//
// Created by David Lawson on 14/05/2014.
// Copyright (c) 2014 Livestock Exchange. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kStatusBarTappedNotification;

@interface UIResponder (Informative)

- (void)informative_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end