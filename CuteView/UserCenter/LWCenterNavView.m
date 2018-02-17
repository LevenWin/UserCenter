//
//  LWCenterNavView.m
//  CuteView
//
//  Created by leven on 2018/2/17.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "LWCenterNavView.h"
@interface LWCenterNavView()
@end
@implementation LWCenterNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor,
                           (id)[[UIColor blackColor] colorWithAlphaComponent:0.0].CGColor,nil];
        gradient.startPoint = CGPointMake(0.5, 0);
        gradient.endPoint = CGPointMake(0.5, 1);
        [self.layer addSublayer:gradient];
    
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, kScreenWidth, kNavBarHeight - kStatusBarHeight)];
        _titleLabel.text = @"个人中心";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:_titleLabel];
    }
    return self;
}
@end
