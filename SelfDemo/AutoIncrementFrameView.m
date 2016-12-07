//
//  AutoIncrementFrameView.m
//  SelfDemo
//
//  Created by Jaffer on 16/12/6.
//  Copyright © 2016年 51Nage. All rights reserved.
//

#import "AutoIncrementFrameView.h"

@interface AutoIncrementFrameView ()

@property (nonatomic, assign) CGSize originSize;

@end

@implementation AutoIncrementFrameView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.originSize = frame.size;
        [self initViews];
    }
    return self;
}

- (void)initViews {

}


- (CGSize)increaseByMultiplier:(CGFloat)x {
    CGPoint origin = self.frame.origin;
    CGRect frame = CGRectMake(origin.x, origin.y, self.originSize.width + x * 20, self.originSize.height + x * 20);
    self.frame = frame;
    return self.frame.size;
}

- (CGSize)reset {
    CGRect frame = self.frame;
    frame.size = self.originSize;
    self.frame = frame;
    return self.frame.size;
}


@end
