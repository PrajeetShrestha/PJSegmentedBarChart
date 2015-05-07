# PJSegmentedBarChart
Segmented Barchart for iOS

USAGE SAMPLE
```
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
```
