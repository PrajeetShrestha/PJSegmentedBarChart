//
//  SegmentedBarView.h
//  test
//
//  Created by EKbana on 5/3/15.
//  Copyright (c) 2015 EK Solutions Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentedBarView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSegmentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSegmentHeight;
@property (weak, nonatomic) IBOutlet UILabel *topTitle;
@property (weak, nonatomic) IBOutlet UILabel *botTitle;

@property (weak, nonatomic) IBOutlet UIView *topSegmentView;
@property (weak, nonatomic) IBOutlet UIView *bottomSegmentView;

@end
