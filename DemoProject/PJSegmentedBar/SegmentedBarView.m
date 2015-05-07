//
//  SegmentedBarView.m
//  test
//
//  Created by EKbana on 5/3/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import "SegmentedBarView.h"

@implementation SegmentedBarView
@synthesize topTitle;
@synthesize botTitle;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SegmentedBarView" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

@end
