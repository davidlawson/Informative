//
// Created by David Lawson on 13/05/2014.
// Copyright (c) 2014 Livestock Exchange. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Informative : NSObject

+ (instancetype)singleton;

// Observed property that defines whether or not the information views are visible
@property (nonatomic) BOOL showInformation;

/*
 Block used to create each information view (one per UINavigationController)

 We can't use a UIView property as views can't have multiple superviews, and
 we might need multiple instances of the information view on screen at once.
 E.g. UINavigationController visible while another UINavigationController is
 presented modally.
 */
@property (nonatomic, copy) UIView* (^createInformationView)(void);

// Block used to animate display of information view
@property (nonatomic, copy) void (^hideInformationView)(UIView *view, BOOL animated);

// Block used to animate hiding of information view
@property (nonatomic, copy) void (^showInformationView)(UIView *view, BOOL animated);

// Block called when you tap the information view
@property (nonatomic, copy) void (^tapInformationView)();

// Creates a new information view, adds a gesture recogniser and adds it to the set of information views
- (UIView *)newInformationView;

// Removes an information view from the set of information views
- (void)removeInformationView:(UIView *)informationView;

// Height of status bar when an information view is visible
@property (nonatomic) float newStatusBarHeight;

// Duration of hide/show animations
@property (nonatomic) float animationDuration;

// Block that updates each information view, e.g. for animations
- (void)modifyInformationViews:(void (^)(UIView *))modifyBlock;

@end