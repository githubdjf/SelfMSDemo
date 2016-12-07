//
//  OTLabel.m
//  OneTargetCommon
//
//  Created by WeiHan on 2/1/16.
//  Copyright © 2016 onetarget. All rights reserved.
//
//  http://stackoverflow.com/a/21267507/1677041

#import "OTLabel.h"

@implementation OTLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    UIEdgeInsets insets = self.textInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];

    rect.origin.x    -= insets.left;
    rect.origin.y    -= insets.top;
    rect.size.width  += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);

    return rect;
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (void)setTextInsets:(UIEdgeInsets)textInsets
{
    _textInsets = textInsets;

    [self invalidateIntrinsicContentSize];
}

@end




