//
//  LWCenterMiddleTableView.h
//  CuteView
//
//  Created by leven on 2018/2/10.
//  Copyright © 2018年 leven. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LWCenterMiddleTableViewDelegate<NSObject>
- (void) LWCenterMiddleTableViewDidScroll;
@end

@interface LWCenterMiddleTableView : UITableView
@property (nonatomic, weak) id<LWCenterMiddleTableViewDelegate> viewDelegate;
@end

