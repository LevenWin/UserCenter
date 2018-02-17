//
//  XBorderTabView.m
//  iOSClient
//
//  Created by leven on 2017/6/1.
//  Copyright © 2017年 borderxlab. All rights reserved.
//

#import "XBorderTabView.h"

static CGFloat kMinSliderWidth = 75;

@interface XBorderTabView(){
    NSArray *_titles;
}

@property (nonatomic, strong) NSMutableArray *titleButtonArray;
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) NSMutableDictionary *widhtDict;
@end
@implementation XBorderTabView
- (void)setSliderColor:(UIColor *)sliderColor{
    _sliderColor = sliderColor;
    [self refreshUI];
}

- (NSArray <NSString *>*)titles{
    return _titles;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self refreshUI];
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    [self refreshUI];
}

- (instancetype)initWithFrame:(CGRect)frame withTitls:(NSArray <NSString *>*)titls{
    if ((self = [super initWithFrame:frame])) {
        self.currentIndex = 0;
        self.sliderColor = [UIColor colorWithHexString:@"333333"];
        self.titleColor = [UIColor colorWithHexString:@"333333"];
        _titles = [titls copy];
        self.backgroundColor =  [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        self.titleButtonArray = @[].mutableCopy;
        [self saveTitleWidth];
    }
    return self;
}

- (void)saveTitleWidth{
    self.widhtDict = @{}.mutableCopy;
    for (NSString *title in _titles) {
        CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
        width += 8;
        if (width < kMinSliderWidth) {
            width = kMinSliderWidth;
        }
        [self.widhtDict setObject:@(width) forKey:title];
    }
}
- (void)refreshUI{
    if (self.titleButtonArray.count > 0) {
        for (UIButton *btn in self.titleButtonArray) {
            [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        }
        self.sliderView.backgroundColor = self.sliderColor;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.titleButtonArray.count == 0) {
        CGFloat itemWidth = self.width / self.titles.count;
        CGFloat itemHeight = self.height;
        CGFloat sliderWidth = kMinSliderWidth;
        CGFloat sliderHeight = 2;
        for (NSString *title in self.titles) {
            NSInteger index = [self.titles indexOfObject:title];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.frame = CGRectMake(itemWidth * index , 0, itemWidth, itemHeight);
            btn.tag = index + 1;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self.titleButtonArray addObject:btn];
        }
        if (self.titles) {
            self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sliderWidth, sliderHeight)];
            UIButton *selectedButton = [self viewWithTag:self.currentIndex + 1];
            self.sliderView.center = selectedButton.center;
            self.sliderView.top = selectedButton.height - self.sliderView.height;
            [self addSubview:self.sliderView];
        }
        [self refreshUI];
    }
}

- (void)itemClick:(UIButton *)button{
    self.currentIndex = button.tag - 1;
    if ([self.delegate respondsToSelector:@selector(XBorderTabViewDidClickAtIndex:title:)]) {
        [self.delegate XBorderTabViewDidClickAtIndex:self.currentIndex title:self.titles[self.currentIndex]];
    }
}

- (void)bottomScrollViewOffset:(CGFloat)offsetX{
    
    [self refrshSliderWidthWithOffsetX:offsetX];
    
    CGFloat width = self.width;
    CGFloat itemWidth = self.width / self.titles.count;
    CGFloat sliderOriginalCenterX = itemWidth/2.0;
    CGFloat centerX = sliderOriginalCenterX + offsetX*(itemWidth/width);
    self.sliderView.centerX = centerX;
}

- (void)refrshSliderWidthWithOffsetX:(CGFloat)offsetX{
    CGFloat itemWidth = self.width / self.titles.count;
    CGFloat halfItemWidth = itemWidth/2;
    NSInteger leftIndex = self.sliderView.centerX / halfItemWidth / 2 ;
    leftIndex += (NSInteger)(self.sliderView.centerX / halfItemWidth) % 2 ;
    leftIndex --;

    CGFloat leftWidth = 0;
    CGFloat rightWidth = 0;
    CGFloat sliderWidth = 0;
    if (leftIndex < 0) {
        leftWidth = [[self.widhtDict objectForKey:_titles[0]] doubleValue];
        rightWidth = leftWidth;
        sliderWidth = rightWidth;
    }else if(leftIndex >= (_titles.count-1)){
        leftWidth = [[self.widhtDict objectForKey:_titles.lastObject] doubleValue];
        rightWidth = leftWidth;
        sliderWidth = rightWidth;
    }else{
        leftWidth = [[self.widhtDict objectForKey:_titles[leftIndex]] doubleValue];
        rightWidth = [[self.widhtDict objectForKey:_titles[leftIndex+1]] doubleValue];
        CGFloat subWidth = self.sliderView.centerX - ((leftIndex+1) * itemWidth  - halfItemWidth);
        sliderWidth = leftWidth + (rightWidth-leftWidth)*(subWidth/itemWidth);
    }
    _sliderView.width = sliderWidth;
}
@end
