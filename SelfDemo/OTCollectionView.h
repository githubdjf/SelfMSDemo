//
//  OTCollectionView.h
//  OneTargetGClient
//
//  Created by WeiHan on 5/6/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTCollectionCellData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL selected;

@end


@interface OTCollectionGroupCellData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) NSArray<OTCollectionCellData *> *subItems;

@end


@interface OTCollectionView : UICollectionView

@property (nonatomic, strong) NSArray<OTCollectionGroupCellData *> *dataItems;

@property (nonatomic, strong, readonly) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic) UIEdgeInsets sectionInset;

@property (nonatomic, copy) void (^ configCell)(UICollectionViewCell *, NSIndexPath *indexPath);

@property (nonatomic, copy) void (^ configHeader)(UICollectionReusableView *, NSIndexPath *indexPath);

@property (nonatomic, copy) void (^ configFooter)(UICollectionReusableView *, NSIndexPath *indexPath);

/**
 *    @brief config the size of the specified item’s cell.
 */
@property (nonatomic, copy) CGSize (^ fittingCellSize)(NSIndexPath *, CGSize /* This fitting size is returned by cell's systemLayoutSizeFittingSize method. */);

@end
