//
//  LWCenterRightTableView.h
//  CuteView
//
//  Created by leven on 2018/2/10.
//  Copyright © 2018年 leven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWCenterRightTableViewDelegate<NSObject>
- (void) LWCenterRightTableViewDidScroll;
@end

@interface LWCenterRightTableView : UITableView
@property (nonatomic, weak) id<LWCenterRightTableViewDelegate> viewDelegate;
@end
