//
//  XBorderTabView.h
//  iOSClient
//
//  Created by leven on 2017/6/1.
//  Copyright © 2017年 borderxlab. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XBorderTabViewDelegate<NSObject>
- (void)XBorderTabViewDidClickAtIndex:(NSInteger)index title:(NSString *)title;
@end

@interface XBorderTabView : UIView
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *sliderColor;
@property (nonatomic, strong,readonly) NSArray <NSString *>*titles;
@property (nonatomic, weak) id<XBorderTabViewDelegate>delegate;
@property (nonatomic, assign) NSInteger currentIndex;
- (instancetype)initWithFrame:(CGRect)frame withTitls:(NSArray <NSString *>*)titls;

- (void)bottomScrollViewOffset:(CGFloat)offsetX;
@end
