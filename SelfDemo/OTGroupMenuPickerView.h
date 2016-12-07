//
//  OTGroupMenuPickerView.h
//  OneTargetGClient
//
//  Created by WeiHan on 5/10/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTDropDownMenuView.h"
#import "OTMenuCollectionView.h"

/**
 *    @author Wei Han
 *
 *    @brief  The prefer size constraint is full screen size.
 */
@interface OTGroupMenuPickerView : UIView

@property (nonatomic, strong, readonly) OTDropDownMenuView *dropDownView;
@property (nonatomic, strong, readonly) OTMenuCollectionView *collectionView;

@property (nonatomic, assign) BOOL expanded;

@property (nonatomic, copy) void (^ selectedMenuChanged)(NSUInteger selectedIndex);

@end
