//
//  SegmentSelect.m
//  MVVM实践
//
//  Created by cssweb on 2018/1/30.
//  Copyright © 2018年 cssweb. All rights reserved.
//

#import "SegmentSelect.h"
@interface SegmentSelect(){
    
    CGFloat _titleSize;
}
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) UIColor *mainColor;

@property (nonatomic, strong) UIView *topSlideLineView;
@end

@implementation SegmentSelect
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArr selectedColor:(UIColor *)color titleSize:(CGFloat)size{
    self = [self initWithFrame:frame];
    if (self) {
        self.titleArray = titleArr;
        self.mainColor = color;
        _titleSize = size;
        [self viewCreat];
    }
    return  self;
}

- (void)viewCreat{
    self.backgroundColor = [UIColor whiteColor];
    
    //设置顶部的slideBar
    UIView *slideBGView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 2, self.frame.size.width, 2)];
    slideBGView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:slideBGView];
    
    self.topSlideLineView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/self.titleArray.count/4, self.frame.size.height - 2, self.frame.size.width/self.titleArray.count - self.frame.size.width/self.titleArray.count/2, 2)];
    self.topSlideLineView.backgroundColor = self.mainColor;
    [self addSubview:self.topSlideLineView];
    
    //添加按键
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.titleArray.count];

    for (int i = 0; i < self.titleArray.count; i++) {
        NSString *title = self.titleArray[i];
        NSAttributedString *attrTitle = [[NSAttributedString alloc]initWithString:title attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:_titleSize], NSForegroundColorAttributeName : [UIColor blackColor]}];
        UIButton *btu = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/self.titleArray.count * i, 5, self.frame.size.width/self.titleArray.count, self.frame.size.height - 10)];
        [btu setAttributedTitle:attrTitle forState:UIControlStateNormal];
        [btu setTag:i];
        [btu addTarget:self action:@selector(tapBtu:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btu];
        [tempArray addObject:btu];
    }
    self.titleArray = tempArray;
}

- (void) tapBtu:(UIButton *)btu{
    NSInteger tag = btu.tag;
    [self.delegate SectionSelectIndex:tag];
    NSAttributedString *selectTitle = [[NSAttributedString alloc]initWithString:btu.titleLabel.text attributes:@{NSForegroundColorAttributeName : self.mainColor}];
    [btu setAttributedTitle:selectTitle forState:UIControlStateNormal];
    for (int i = 0; i < self.titleArray.count; i++) {
        UIButton *btu = self.titleArray[i];
        if (btu.tag != tag) {
            NSAttributedString *normalTitle = [[NSAttributedString alloc]initWithString:btu.titleLabel.text attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
            [btu setAttributedTitle:normalTitle forState:UIControlStateNormal];
        }
    }
    [UIView animateWithDuration:0.35 animations:^{
        self.topSlideLineView.frame = CGRectMake(self.frame.size.width/self.titleArray.count * tag + self.frame.size.width/self.titleArray.count/4, self.frame.size.height - 2, self.frame.size.width/self.titleArray.count - self.frame.size.width/self.titleArray.count/2, 2);
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
