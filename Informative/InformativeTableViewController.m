//
//  InformativeTableViewController.m
//  Informative
//
//  Created by David Lawson on 14/05/2014.
//  Copyright (c) 2014 David Lawson. All rights reserved.
//

#import "InformativeTableViewController.h"
#import <Informative/Informative.h>

@implementation InformativeTableViewController

- (IBAction)toggleInformative:(id)sender
{
    [Informative singleton].showInformation = ![Informative singleton].showInformation;
}

@end
