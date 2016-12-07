//
//  OTMenuCollectionView.h
//  OneTargetGClient
//
//  Created by WeiHan on 5/10/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import "OTCollectionView.h"

@interface OTMenuCollectionView : OTCollectionView

@property (nonatomic, assign) NSUInteger columnCount; // default value is 4

@property (nonatomic, copy) void (^ onCollectionCellViewTappedBlock)(NSIndexPath *indexPath);
@property (nonatomic, copy) void (^ onCollectionCellHeaderViewTappedBlock)(NSInteger section);

@end
