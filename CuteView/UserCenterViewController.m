//
//  UserCenterViewController.m
//  CuteView
//
//  Created by leven on 2018/2/10.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LWCenterBottomScrollView.h"
#import "XBorderTabView.h"
#import "LWCenterNavView.h"

const CGFloat kHederHeight = 220;
const CGFloat kTabViewHeight = 44;
const CGFloat kSpeedScale = 0.7;

@interface UserCenterViewController ()<XBorderTabViewDelegate, LWCenterBottomScrollViewDelegate>{
    CGFloat _avatarImageViewOriginTop;
    CGFloat _nameLabelOriginTop;
    CGFloat _tabViewOriginTop;
}

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) XBorderTabView *tabView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) LWCenterNavView *navView;
@property (nonatomic, strong) LWCenterBottomScrollView *bottomScrollView;
@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)initUI {
    [self.view addSubview:self.headerImageView];
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.navView];
    [self.containerView addSubview:self.bottomScrollView];
    [self.containerView addSubview:self.tabView];
    [self.containerView addSubview:self.nameLabel];
    [self.containerView addSubview:self.avatarImageView];
}

- (void)XBorderTabViewDidClickAtIndex:(NSInteger)index title:(NSString *)title {
    [_bottomScrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
}

- (void)LWCenterBottomScrollViewContentOffsetXDidChange {
    [_tabView bottomScrollViewOffset:_bottomScrollView.contentOffset.x];
}

- (void)LWCenterBottomScrollViewTableViewDidScrolle:(UITableView *)tableView {
    CGFloat offset = tableView.contentOffset.y + tableView.contentInset.top;
    _avatarImageView.top =  _avatarImageViewOriginTop - offset;
    _nameLabel.top =  _nameLabelOriginTop - offset;
    
    if (offset >= kHederHeight) {
        _tabView.top = 0;
    }else{
        _tabView.top = _tabViewOriginTop - offset;
    }
    
    [_bottomScrollView resetUnScrollTableViewContentOffset];
    [self updateHeaderImageView:tableView];
}

- (void)updateHeaderImageView:(UITableView *)tableView {
    CGFloat offset = tableView.contentOffset.y;
    CGFloat insetTop = tableView.contentInset.top;
    NSLog(@"%lf",offset);

    if (offset <= kNavBarHeight && offset > -kHederHeight) {
        _headerImageView.top = -kTabViewHeight -  (insetTop + offset) * kSpeedScale;
    }else if (offset > kNavBarHeight) {
        _headerImageView.top = -kTabViewHeight -  (insetTop + kNavBarHeight) * kSpeedScale;
    }else if (offset <= -kHederHeight) {
        CGFloat offsetToOriginal = kTabViewHeight/kSpeedScale;
        if (offset >= - kHederHeight- offsetToOriginal) {
            _headerImageView.top = -kTabViewHeight -  (insetTop + offset) * kSpeedScale;
            _headerImageView.transform = CGAffineTransformMakeScale(1, 1);
            _headerImageView.left = 0;
        }else{
            CGFloat cacuOffset = -offset - kHederHeight - offsetToOriginal;
            CGFloat imageHeight = kHederHeight + kNavBarHeight + kTabViewHeight + kTabViewHeight * (1 - kSpeedScale);
            CGFloat bigScale = (cacuOffset + imageHeight)/imageHeight;
            _headerImageView.transform = CGAffineTransformMakeScale(bigScale, bigScale);
            _headerImageView.top = 0;
            _headerImageView.left = - (kScreenWidth*bigScale - kScreenWidth)/2;
        }
    }
}


- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kTabViewHeight, kScreenWidth, kHederHeight + kNavBarHeight + kTabViewHeight + kTabViewHeight * (1 - kSpeedScale)/kSpeedScale)];
        _headerImageView.layer.contentsGravity = kCAGravityResizeAspectFill;
        _headerImageView.layer.masksToBounds = YES;
        UIImage *image = [UIImage imageNamed:@"3217.jpg"];
        _headerImageView.image = image;
    }
    return _headerImageView;
}
- (XBorderTabView *)tabView {
    if (!_tabView) {
        _tabView = [[XBorderTabView alloc] initWithFrame:CGRectMake(0, kHederHeight, kScreenWidth, kTabViewHeight) withTitls:@[@"左边",@"中间",@"右边"]];
        _tabView.currentIndex = 1;
        _tabView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _tabView.layer.borderWidth = 0.5;
        _tabViewOriginTop = _tabView.top;
    }
    return _tabView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,80 + 40 , kScreenWidth, 30 )];
        _nameLabel.text = @"刘文";
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabelOriginTop = _nameLabel.top;
    }
    return _nameLabel;
}


- (LWCenterNavView *)navView {
    if (!_navView) {
        _navView = [[LWCenterNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    }
    return _navView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth-80)/2, 30, 80, 80)];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        _avatarImageView.image = [UIImage imageNamed:@"avatar.jpg"];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 40;
        _avatarImageViewOriginTop = _avatarImageView.top;
    }
    return _avatarImageView;
}


- (LWCenterBottomScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[LWCenterBottomScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavBarHeight)];
        _bottomScrollView.scrollDelgate = self;
    }
    return _bottomScrollView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight - kNavBarHeight)];
        _containerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        _containerView.layer.masksToBounds = YES;
    }
    return _containerView;
}


@end
