//
//  AutoIncrementFrameView.h
//  SelfDemo
//
//  Created by Jaffer on 16/12/6.
//  Copyright © 2016年 51Nage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoIncrementFrameView : UIView

- (CGSize)increaseByMultiplier:(CGFloat)x;
- (CGSize)reset;

@end
