//
//  LWCenterBottomScrollView.h
//  CuteView
//
//  Created by leven on 2018/2/10.
//  Copyright © 2018年 leven. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LWCenterBottomScrollViewDelegate <NSObject>

- (void)LWCenterBottomScrollViewContentOffsetXDidChange;
- (void)LWCenterBottomScrollViewTableViewDidScrolle:(UITableView *)tableView;


@end

@interface LWCenterBottomScrollView : UIScrollView
@property (nonatomic, weak) id<LWCenterBottomScrollViewDelegate> scrollDelgate;

- (void)resetUnScrollTableViewContentOffset;
@end
