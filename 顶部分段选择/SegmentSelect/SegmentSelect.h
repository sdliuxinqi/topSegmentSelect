//
//  SegmentSelect.h
//  MVVM实践
//
//  Created by cssweb on 2018/1/30.
//  Copyright © 2018年 cssweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentSelectDelegate <NSObject>

- (void)SectionSelectIndex:(NSInteger)selectIndex;

@end

@interface SegmentSelect : UIView

@property (nonatomic, weak) id<SegmentSelectDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleArr selectedColor:(UIColor *)color titleSize:(CGFloat)size;

@end
