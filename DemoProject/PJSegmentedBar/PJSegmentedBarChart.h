//
//  PJSegmentedBarChart.h
//  PJSegmentedBar
//
//  Created by EKbana on 5/7/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//
#define kTopSegment @"topSegment"
#define kBotSegment @"botSegment"
#define kBarLabel @"barLabel"
#import <UIKit/UIKit.h>
#import "SegmentedBarView.h"
@interface PJSegmentedBarChart : UIView
@property (nonatomic) NSArray *data;
//@property (nonatomic) NSArray *horizontalLabelsForBar;
@property (nonatomic) CGFloat scaleHeightOfyAxis;
@property (nonatomic) CGFloat barWidth;
@property (nonatomic) CGFloat padding;
@property (nonatomic) BOOL segmented;
@property (nonatomic)UIColor *mainBarColor;
- (void)addChart;
@end
