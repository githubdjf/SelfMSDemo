//
//  OTDropDownMenuView.h
//  OneTargetGClient
//
//  Created by WeiHan on 5/6/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTDropDownMenuView : UIView

@property (nonatomic, strong) NSArray<NSString *> *menuItems;

@property (nonatomic, assign) NSUInteger selectedItemIndex;

@property (nonatomic, copy) void (^ selectedItemChanged)(NSUInteger selectedIndex, BOOL state);

- (void)updateMenuItem:(NSString *)strTitle forIndex:(NSUInteger)index;

@end
