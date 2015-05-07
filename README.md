# PJSegmentedBarChart
Segmented Barchart for iOS
Import PJSegmentedBarChart In you view controller  and add PJSegmentedBarChart that's it. Sample usage makes it more clear. Thanx. 

prajeet.shrestha@gmail.com
USAGE SAMPLE
```
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
    //chart.frame = self.chartContainer.bounds;
    chart.frame = CGRectMake(10, 10, 220, 100);
    chart.data = @[
                   @{kTopSegment:@50,kBotSegment:@50,kBarLabel:@"Assigned"},
                   @{kTopSegment:@50,kBotSegment:@20,kBarLabel:@"Completed"},
                   @{kTopSegment:@5,kBotSegment:@15,kBarLabel:@"Overdue"},
                   @{kTopSegment:@35,kBotSegment:@45,kBarLabel:@"Draft"}
                        ];
    chart.scaleHeightOfyAxis = 10;
    chart.padding = 12;
    [chart addChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

}
```
