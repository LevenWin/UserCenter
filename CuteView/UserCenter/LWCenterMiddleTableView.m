//
//  LWCenterMiddleTableView.m
//  CuteView
//
//  Created by leven on 2018/2/10.
//  Copyright © 2018年 leven. All rights reserved.
//

#import "LWCenterMiddleTableView.h"
@interface LWCenterMiddleTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LWCenterMiddleTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 70;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    }
    return self;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_viewDelegate respondsToSelector:@selector(LWCenterMiddleTableViewDidScroll)]) {
        [_viewDelegate LWCenterMiddleTableViewDidScroll];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"Middle Table Cell";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
