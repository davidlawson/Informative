//
//  ModalTVC.m
//  Informative
//
//  Created by David Lawson on 14/05/2014.
//  Copyright (c) 2014 David Lawson. All rights reserved.
//

#import "ModalTVC.h"

@implementation ModalTVC

- (IBAction)pressedClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
