//
//  LWCenterBottomScrollView.m
//  CuteView
//
//  Created by leven on 2018/2/10.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "LWCenterBottomScrollView.h"
#import "LWCenterLeftTableView.h"
#import "LWCenterRightTableView.h"
#import "LWCenterMiddleTableView.h"
#import "UserCenterViewController.h"
@interface LWCenterBottomScrollView ()<UIScrollViewDelegate,
LWCenterLeftTableViewDelegate,
LWCenterRightTableViewDelegate,
LWCenterMiddleTableViewDelegate>{
    CGFloat _originalOffsetYR;
    CGFloat _originalOffsetYL;
    CGFloat _originalOffsetYM;

}

@property (nonatomic, strong) LWCenterRightTableView *rightTableView;
@property (nonatomic, strong) LWCenterMiddleTableView *middleTableView;
@property (nonatomic, strong) LWCenterLeftTableView *leftTableView;


@end

@implementation LWCenterBottomScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(kScreenWidth*3, kScreenHeight-kNavBarHeight);
        self.bounces = NO;
        self.delegate =self;
        self.pagingEnabled = YES;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        [self addSubview:self.leftTableView];
        [self addSubview:self.middleTableView];
        [self addSubview:self.rightTableView];
        [self setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
    }
    return self;
}

- (void)resetUnScrollTableViewContentOffset {
    NSInteger  index = self.contentOffset.x / kScreenWidth;
    if (index == 0) {
        if (_originalOffsetYM == 0) {
            _originalOffsetYM = _middleTableView.contentOffset.y;
        }
        if (_originalOffsetYR == 0) {
            _originalOffsetYR = _rightTableView.contentOffset.y;
        }
        _originalOffsetYL = 0;
        [self resetTableView:_middleTableView ontentOffset:_leftTableView.contentOffset.y ];
        [self resetTableView:_rightTableView ontentOffset:_leftTableView.contentOffset.y ];

    }else if (index == 1) {
        if (_originalOffsetYL == 0) {
            _originalOffsetYL = _leftTableView.contentOffset.y;
        }
        if (_originalOffsetYR == 0) {
            _originalOffsetYR = _rightTableView.contentOffset.y;
        }
        _originalOffsetYM = 0;
        
        [self resetTableView:_leftTableView ontentOffset:_middleTableView.contentOffset.y ];
        [self resetTableView:_rightTableView ontentOffset:_middleTableView.contentOffset.y ];
    }else{
        if (_originalOffsetYL == 0) {
            _originalOffsetYL = _leftTableView.contentOffset.y;
        }
        if (_originalOffsetYM == 0) {
            _originalOffsetYM = _middleTableView.contentOffset.y;
        }
        _originalOffsetYR = 0;
        [self resetTableView:_leftTableView ontentOffset:_rightTableView.contentOffset.y ];
        [self resetTableView:_middleTableView ontentOffset:_rightTableView.contentOffset.y ];

    }
}

- (void)resetTableView :(UITableView *)tableView ontentOffset:(CGFloat )offsetY {
    NSLog(@"%@",@(offsetY));
    offsetY = offsetY < -kHederHeight ? -kHederHeight :offsetY;
    offsetY = offsetY > 0 ? 0 : offsetY;
    tableView.contentOffset = CGPointMake(0, offsetY);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_scrollDelgate respondsToSelector:@selector(LWCenterBottomScrollViewContentOffsetXDidChange)]) {
        [_scrollDelgate LWCenterBottomScrollViewContentOffsetXDidChange];
    }
}

- (void)LWCenterMiddleTableViewDidScroll {
    if ([_scrollDelgate respondsToSelector:@selector(LWCenterBottomScrollViewTableViewDidScrolle:)]) {
        [_scrollDelgate LWCenterBottomScrollViewTableViewDidScrolle:_middleTableView];
    }
}

- (void) LWCenterLeftTableViewDidScroll {
    if ([_scrollDelgate respondsToSelector:@selector(LWCenterBottomScrollViewTableViewDidScrolle:)]) {
        [_scrollDelgate LWCenterBottomScrollViewTableViewDidScrolle:_leftTableView];
    }
}

- (void) LWCenterRightTableViewDidScroll {
    if ([_scrollDelgate respondsToSelector:@selector(LWCenterBottomScrollViewTableViewDidScrolle:)]) {
        [_scrollDelgate LWCenterBottomScrollViewTableViewDidScrolle:_rightTableView];
    }
}

- (LWCenterMiddleTableView *)middleTableView {
    if (!_middleTableView) {
        _middleTableView = [[LWCenterMiddleTableView alloc] initWithFrame:CGRectMake(kScreenWidth, kTabViewHeight, kScreenWidth, kScreenHeight - kNavBarHeight-kTabViewHeight) style:UITableViewStylePlain];
        _middleTableView.contentInset = UIEdgeInsetsMake(kHederHeight, 0, 0, 0);
        _middleTableView.viewDelegate = self;
    }
    return _middleTableView;
}

- (LWCenterRightTableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[LWCenterRightTableView alloc] initWithFrame:CGRectMake(kScreenWidth*2, kTabViewHeight, kScreenWidth, kScreenHeight - kNavBarHeight-kTabViewHeight) style:UITableViewStylePlain];
        _rightTableView.contentInset = UIEdgeInsetsMake(kHederHeight, 0, 0, 0);
        _rightTableView.viewDelegate = self;

    }
    return _rightTableView;
}

- (LWCenterLeftTableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[LWCenterLeftTableView alloc] initWithFrame:CGRectMake(0, kTabViewHeight, kScreenWidth, kScreenHeight - kNavBarHeight-kTabViewHeight) style:UITableViewStylePlain];
        _leftTableView.contentInset = UIEdgeInsetsMake(kHederHeight, 0, 0, 0);
        _leftTableView.viewDelegate = self;

    }
    return _leftTableView;
}

@end
