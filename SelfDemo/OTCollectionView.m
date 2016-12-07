//
//  OTCollectionView.m
//  OneTargetGClient
//
//  Created by WeiHan on 5/6/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import "OTCollectionView.h"
#import "UICollectionViewLeftAlignedLayout.h"


#define RGBA(__r, __g, __b, __a)           \
[UIColor colorWithRed : (__r / 255.0f) \
green : (__g / 255.0f)                \
blue : (__b / 255.0f)                 \
alpha : (__a)]

#define RGB(__r, __g, __b) RGBA(__r, __g, __b, 1.0)


#pragma mark - OTCollectionCellData

@implementation OTCollectionCellData

@end


#pragma mark - OTCollectionGroupCellData

@implementation OTCollectionGroupCellData

@end


#pragma mark - OTCollectionView

@interface OTCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionViewCell *protoTypeCell;
}

@property (nonatomic, strong) UICollectionViewLeftAlignedLayout *flowLayout;

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) NSMutableDictionary<NSString */*kind*/, NSString */*identifier*/> *supplementaryViewInfo;
@end

@implementation OTCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
//    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    UICollectionViewLeftAlignedLayout *flowLayout = [UICollectionViewLeftAlignedLayout new];
    CGFloat padding = 20, margin = 15;

    flowLayout.minimumLineSpacing = padding;
    flowLayout.minimumInteritemSpacing = margin;
    

    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        _flowLayout = flowLayout;

        self.dataSource = self;
        self.delegate = self;

        self.contentInset = UIEdgeInsetsMake(padding, padding, padding, padding);
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [super registerClass:cellClass forCellWithReuseIdentifier:identifier];
    self.cellClass = cellClass;
    self.cellIdentifier = identifier;
}

- (void)registerClass:(Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier
{
    [super registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];

    [self.supplementaryViewInfo setValue:identifier forKey:elementKind];
}

#pragma mark - Property

- (void)setDataItems:(NSArray<OTCollectionGroupCellData *> *)dataItems
{
    _dataItems = dataItems;

    BOOL hasNoSection = dataItems.count <= 1 && [dataItems firstObject].title.length <= 0;

    if (hasNoSection) {
        self.flowLayout.headerReferenceSize = CGSizeZero;
        self.flowLayout.footerReferenceSize = CGSizeZero;
        self.flowLayout.sectionInset = UIEdgeInsetsZero;
    } else {
        self.flowLayout.headerReferenceSize = CGSizeMake(0, 30);

        if (UIEdgeInsetsEqualToEdgeInsets(self.sectionInset, UIEdgeInsetsZero)) {
            CGFloat space = self.flowLayout.minimumLineSpacing;
            self.flowLayout.sectionInset = UIEdgeInsetsMake(space, 0, space, 0);
        } else {
            self.flowLayout.sectionInset = self.sectionInset;
        }
    }

    [self reloadData];
}

- (void)setCellClass:(Class)cellClass
{
    _cellClass = cellClass;
    protoTypeCell = [cellClass new];
}

- (NSMutableDictionary<NSString *, NSString *> *)supplementaryViewInfo
{
    if (!_supplementaryViewInfo) {
        _supplementaryViewInfo = [NSMutableDictionary new];
    }

    return _supplementaryViewInfo;
}

#pragma mark - Private

- (void)_configureCell:(UICollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    if (self.configCell) {
        self.configCell(cell, indexPath);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataItems.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataItems[section].subItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSParameterAssert(self.cellIdentifier);

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];

    [self _configureCell:cell forIndexPath:indexPath];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *strReuseID = self.supplementaryViewInfo[kind];

    NSAssert(strReuseID, @"Invalid reuse identifier for cell kind %@", kind);

    UICollectionReusableView *elementView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:strReuseID forIndexPath:indexPath];

    BOOL isHeader = [kind isEqualToString:UICollectionElementKindSectionHeader];
    BOOL isFooter = [kind isEqualToString:UICollectionElementKindSectionFooter];

    if (isHeader) {
        if (self.configHeader) {
            self.configHeader(elementView, indexPath);
        }
    } else if (isFooter) {
        if (self.configFooter) {
            self.configFooter(elementView, indexPath);
        }
    }

    return elementView;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self _configureCell:protoTypeCell forIndexPath:indexPath];

    CGSize size = [protoTypeCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];

    if (self.fittingCellSize) {
        return self.fittingCellSize(indexPath, size);
    }

    return size;
}

@end




