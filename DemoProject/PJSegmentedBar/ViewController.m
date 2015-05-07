//
//  ViewController.m
//  PJSegmentedBar
//
//  Created by EKbana on 5/7/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//
#define kTopSegment @"topSegment"
#define kBotSegment @"botSegment"
#define kBarLabel @"barLabel"

#import "ViewController.h"
#import "PJSegmentedBarChart.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PJSegmentedBarChart *chart = [PJSegmentedBarChart new];
    [self.chartContainer addSubview:chart];
    chart.frame = self.chartContainer.bounds;
    chart.data = @[
                   @{kTopSegment:@251,kBotSegment:@0,kBarLabel:@"Assigned"},
                   @{kTopSegment:@50,kBotSegment:@20,kBarLabel:@"Completed"},
                   @{kTopSegment:@5,kBotSegment:@15,kBarLabel:@"Overdue"},
                   @{kTopSegment:@35,kBotSegment:@45,kBarLabel:@"Draft"}
                   ];
    chart.scaleHeightOfyAxis = 11;
    chart.segmented = YES;
    chart.padding = 12;
    chart.mainBarColor = [UIColor blueColor];
    [chart addChart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
