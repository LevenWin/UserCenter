//
//  LWCenterLeftTableView.h
//  CuteView
//
//  Created by leven on 2018/2/10.
//  Copyright © 2018年 leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWCenterLeftTableViewDelegate<NSObject>
- (void) LWCenterLeftTableViewDidScroll;
@end

@interface LWCenterLeftTableView : UITableView
@property (nonatomic, weak) id<LWCenterLeftTableViewDelegate> viewDelegate;
@end

