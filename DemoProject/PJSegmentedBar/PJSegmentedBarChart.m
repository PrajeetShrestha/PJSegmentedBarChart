//
//  PJSegmentedBarChart.m
//  PJSegmentedBar
//
//  Created by EKbana on 5/7/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//
#define kColor [UIColor grayColor];

#import "PJSegmentedBarChart.h"
@interface PJSegmentedBarChart() {
    NSMutableArray *scaledBarData;
    NSMutableArray *barMidXPositions;
    NSMutableArray *yScaleLabels;
    NSMutableArray *barTotalValue;
    NSMutableArray *topSegmentNumbers;
    NSMutableArray *bottomSegmentNumbers;
    NSMutableArray *horizontalLabelsForBar;
    
    CGFloat minX;
    CGFloat minY;
    CGFloat maxX;
    CGFloat maxY;
    CGFloat height;
    CGFloat width;
    CGFloat dynamicWidthOfBar;
}
@end

@implementation PJSegmentedBarChart

- (instancetype)init
{
    self = [super init];
    if (self) {
        scaledBarData = [NSMutableArray new];
        barMidXPositions = [NSMutableArray new];
        yScaleLabels = [NSMutableArray new];
        barTotalValue = [NSMutableArray new];
        topSegmentNumbers = [NSMutableArray new];
        bottomSegmentNumbers = [NSMutableArray new];
        horizontalLabelsForBar = [NSMutableArray new];
        self.mainBarColor = [UIColor new];
        
        self.backgroundColor = [UIColor whiteColor];
        
        //Setting Default padding and width
        self.padding = 10;
        self.barWidth = 50;
        self.scaleHeightOfyAxis = 7;
        self.segmented = NO;
        
    }
    return self;
}

#pragma mark - Plot graph components
- (void)addChart {
    [self extractValuesFromBarData];
    minX = CGRectGetMinX(self.bounds);
    minY = CGRectGetMinY(self.bounds);
    maxX = CGRectGetMaxX(self.bounds);
    maxY = CGRectGetMaxY(self.bounds);
    height = CGRectGetHeight(self.bounds);
    width = CGRectGetWidth(self.bounds);
    
    dynamicWidthOfBar = (width - (self.data.count * self.padding))/self.data.count;
    
    [self scaleChartDataWithRespectToItsHeight];
    [self plotAxes];
    if (self.segmented) {
        [self plotBarsWithSegments];
    } else {
        [self plotBars];
}
    //[self plotBars];
    
    [self plotHorizontalLabels];
    [self plotVerticalLabels];
}

- (void)plotAxes {
    
    UIView *verticalAxis = [UIView new];
    verticalAxis.backgroundColor = [UIColor lightGrayColor];
    verticalAxis.frame = CGRectMake(minX, maxY, 1, -(height + 12));
    [self addSubview:verticalAxis];
    
    //DynamicHorizontalBar
    UIView *horizontalAxis = [UIView new];
    horizontalAxis.backgroundColor = [UIColor lightGrayColor];
    horizontalAxis.frame = CGRectMake(minX, maxY, self.data.count * (dynamicWidthOfBar + self.padding), 1);
    [self addSubview:horizontalAxis];
}

- (void)plotBars {
    __block CGFloat xPosition = self.padding;
    for (NSNumber *barData in scaledBarData) {
        UIView *bar = [UIView new];
        bar.backgroundColor = self.mainBarColor;
        bar.frame = CGRectMake(xPosition, maxY, dynamicWidthOfBar , -barData.floatValue);
        [self addSubview:bar];
        [barMidXPositions addObject:[NSNumber numberWithFloat:CGRectGetMidX(bar.frame)]];
        bar.frame = CGRectMake(xPosition, maxY, dynamicWidthOfBar ,0);
        [UIView animateWithDuration:0.6 animations:^(void){
            bar.frame = CGRectMake(xPosition, maxY, dynamicWidthOfBar , -barData.floatValue);
            xPosition += dynamicWidthOfBar + self.padding;
        }];
    }
}

- (void)plotBarsWithSegments {
    __block CGFloat xPosition = self.padding;
    for (NSNumber *barData in scaledBarData) {
        UIView *bar = [UIView new];
        
        bar.frame = CGRectMake(xPosition, maxY, dynamicWidthOfBar , -barData.floatValue);
        bar.backgroundColor = [UIColor blackColor];
        [self addSubview:bar];
        CGFloat scaleFactor = [self findScaleFactorOfBarData];
        SegmentedBarView *segmentedBar = [SegmentedBarView new];
        NSNumber *topSegmentValue = topSegmentNumbers[[scaledBarData indexOfObject:barData]];
        segmentedBar.topSegmentHeight.constant = topSegmentValue.floatValue * scaleFactor;
        segmentedBar.topTitle.text = topSegmentValue.stringValue;
        
        if (segmentedBar.topSegmentHeight.constant < 14) {
            segmentedBar.topTitle.hidden = YES;
        } else {
            segmentedBar.topTitle.hidden = NO;
        }
        
        NSNumber *botSegmentValue = bottomSegmentNumbers[[scaledBarData indexOfObject:barData]];
        segmentedBar.bottomSegmentHeight.constant = botSegmentValue.floatValue * scaleFactor;
        segmentedBar.botTitle.text = botSegmentValue.stringValue;
        
        if (segmentedBar.bottomSegmentHeight.constant < 14) {
            segmentedBar.botTitle.hidden = YES;
        } else {
            segmentedBar.botTitle.hidden = NO;
        }
        
        [bar addSubview:segmentedBar];
        segmentedBar.frame = bar.bounds;
        bar.clipsToBounds = YES;
        
        [barMidXPositions addObject:[NSNumber numberWithFloat:CGRectGetMidX(bar.frame)]];
        bar.frame = CGRectMake(xPosition, maxY, dynamicWidthOfBar ,0);
        [UIView animateWithDuration:0.6 animations:^(void){
            bar.frame = CGRectMake(xPosition, maxY, dynamicWidthOfBar , -barData.floatValue);
            xPosition += dynamicWidthOfBar + self.padding;
        }];
    }
}

- (void)plotHorizontalLabels {
    for (NSString *string in horizontalLabelsForBar) {
        UILabel *barLabel = [UILabel new];
        barLabel.text = string;
        [barLabel sizeToFit];
        [self addSubview:barLabel];
        NSNumber *barXObject = barMidXPositions[[horizontalLabelsForBar indexOfObject:string]];
        CGFloat barXposition = barXObject.floatValue ;
        CGFloat labelHeight = CGRectGetHeight(barLabel.frame);
        barLabel.center = CGPointMake(barXposition,maxY + labelHeight/2);
        barLabel.font = [UIFont systemFontOfSize:12];
        barLabel.textAlignment = NSTextAlignmentCenter;
        barLabel.textColor = kColor;
    }
}

- (void)plotVerticalLabels {
    NSNumber *maxBarDataObject = [barTotalValue valueForKeyPath:@"@max.floatValue"];
    CGFloat maxBarData = maxBarDataObject.floatValue;
    CGFloat scale = maxBarData/self.scaleHeightOfyAxis;
    CGFloat yAxisScaleFactor = height/self.scaleHeightOfyAxis;
    CGFloat yCoordinate = minY;
    int i = 0;
    for (float labelValue = (float)maxBarData; labelValue > i; labelValue -= scale) {
//        NSLog(@"%d %f",labelValue,scale);
        NSString *yAxisLabelTitle = [NSString stringWithFormat:@"%d",(int)labelValue];
        UILabel *yAxisLabel = [UILabel new];
        yAxisLabel.text = yAxisLabelTitle;
        [yAxisLabel sizeToFit];
        CGFloat labelWidth = 100;
        CGFloat labelHeight = CGRectGetHeight(yAxisLabel.frame)/2;
        yAxisLabel.frame = CGRectMake(minX - labelWidth - 10, yCoordinate - labelHeight,  labelWidth, CGRectGetHeight(yAxisLabel.frame));
        yAxisLabel.textAlignment = NSTextAlignmentRight;
        yAxisLabel.font = [UIFont systemFontOfSize:12];
        yAxisLabel.textColor = kColor;
        
        UIView *verticalLabelView = [UIView new];
        verticalLabelView.backgroundColor = kColor;
        verticalLabelView.frame = CGRectMake(minX-5, yCoordinate, 5, 1);
        verticalLabelView.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:verticalLabelView];
        [self addSubview:yAxisLabel];
        yCoordinate += yAxisScaleFactor;
        i++;
        if (i == self.scaleHeightOfyAxis) {
            break;
        }
    }
}

#pragma mark - Private Methods
- (CGFloat)findScaleFactorOfBarData {
    
    NSNumber *maxBarDataObject = [barTotalValue valueForKeyPath:@"@max.floatValue"];
    return height/maxBarDataObject.floatValue;
}

- (void)scaleChartDataWithRespectToItsHeight {
    CGFloat scaleFactor = [self findScaleFactorOfBarData];
    for (NSNumber *data in barTotalValue) {
        NSNumber *scaledData = [NSNumber numberWithFloat:data.floatValue * scaleFactor];
        [scaledBarData addObject:scaledData];
    }
}

- (void)extractValuesFromBarData {
    for (NSDictionary *data in self.data) {
        [topSegmentNumbers addObject: data[kTopSegment]];
        [bottomSegmentNumbers addObject:data[kBotSegment]];
        NSNumber *topNumber = data[kTopSegment];
        NSNumber *bottomNumber = data[kBotSegment];
        NSNumber *total = [NSNumber numberWithFloat:topNumber.floatValue + bottomNumber.floatValue];
        [barTotalValue addObject:total];
        [horizontalLabelsForBar addObject:data[kBarLabel]];
    }
}
@end
