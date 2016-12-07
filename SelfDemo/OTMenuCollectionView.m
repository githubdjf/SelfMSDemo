//
//  OTMenuCollectionView.m
//  OneTargetGClient
//
//  Created by WeiHan on 5/10/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import "OTMenuCollectionView.h"
#import "OTLabel.h"
#import <Masonry/Masonry.h>
#import "UIGestureRecognizer+BlocksKit.h"

#define RGBA(__r, __g, __b, __a)           \
[UIColor colorWithRed : (__r / 255.0f) \
green : (__g / 255.0f)                \
blue : (__b / 255.0f)                 \
alpha : (__a)]

#define RGB(__r, __g, __b) RGBA(__r, __g, __b, 1.0)


#define kSTRKey_OTMenuCollectionViewCellID       @"OTMenuCollectionViewCellID"
#define kSTRKey_OTMenuCollectionViewHeaderCellID @"OTMenuCollectionViewHeaderCellID"

#define kCellBorderColor_Normal                  RGB(217, 217, 217)
#define kCellBorderColor_Selected                RGB(0, 181, 246)
#define kCellBackgroundColor_Normal              [UIColor clearColor]
#define kCellBackgroundColor_Selected            RGB(223, 242, 255)


#pragma mark - OTMenuCollectionViewCell

@interface OTMenuCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) OTLabel *titleLabel;

@end

@implementation OTMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [OTLabel new];
        _titleLabel.layer.cornerRadius = 2.5f;
        _titleLabel.layer.borderWidth = 0.5f;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textInsets = UIEdgeInsetsMake(2, 10, 2, 10);

        self.selected = NO;

        [self.contentView addSubview:_titleLabel];
    }

    return self;
}

- (void)updateConstraints
{
    [self.titleLabel sizeToFit];

    [self.titleLabel
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.edges.equalTo(self.contentView);
    }];

    [super updateConstraints];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
{
    return [self.titleLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

//
// http://stackoverflow.com/a/23616848/1677041
//
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    if (selected) {
        self.titleLabel.layer.borderColor = kCellBorderColor_Selected.CGColor;
        self.titleLabel.backgroundColor = kCellBackgroundColor_Selected;
    } else {
        self.titleLabel.layer.borderColor = kCellBorderColor_Normal.CGColor;
        self.titleLabel.backgroundColor = kCellBackgroundColor_Normal;
    }
}

@end


#pragma mark - OTMenuCollectionViewHeaderCell

@interface OTMenuCollectionViewHeaderCell : UICollectionReusableView

@property (nonatomic, strong) OTLabel *titleLabel;

@property (nonatomic, assign) BOOL selected;

@end

@implementation OTMenuCollectionViewHeaderCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [OTLabel new];
        _titleLabel.layer.cornerRadius = 2.0f;
        _titleLabel.layer.borderColor = RGB(217, 217, 217).CGColor;
        _titleLabel.layer.borderWidth = 0.5f;
        _titleLabel.textInsets = UIEdgeInsetsMake(2, 10, 2, 10);
        _titleLabel.textColor = RGB(80, 80, 80);
        _titleLabel.font = [UIFont systemFontOfSize:15];

        [self addSubview:_titleLabel];

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellItemTapped:)];
        [self addGestureRecognizer:tapGesture];
    }

    return self;
}

- (void)updateConstraints
{
    [self.titleLabel sizeToFit];

    [self.titleLabel
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.centerY.equalTo(self.mas_centerY);
    }];

    [super updateConstraints];
}

//
// http://stackoverflow.com/a/23616848/1677041
//
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

#pragma mark - Property

- (void)setSelected:(BOOL)selected
{
    _selected = selected;

    if (selected) {
        self.titleLabel.layer.borderColor = kCellBorderColor_Selected.CGColor;
        self.titleLabel.backgroundColor = kCellBackgroundColor_Selected;
    } else {
        self.titleLabel.layer.borderColor = kCellBorderColor_Normal.CGColor;
        self.titleLabel.backgroundColor = kCellBackgroundColor_Normal;
    }
}

#pragma mark - Action

- (void)cellItemTapped:(id)sender
{
    self.selected = !self.selected;
}

@end

#pragma mark - OTMenuCollectionView

@implementation OTMenuCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self registerClass:[OTMenuCollectionViewCell class] forCellWithReuseIdentifier:kSTRKey_OTMenuCollectionViewCellID];
        [self registerClass:[OTMenuCollectionViewHeaderCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSTRKey_OTMenuCollectionViewHeaderCellID];

        self.columnCount = 4;
        self.sectionInset = UIEdgeInsetsMake(self.flowLayout.minimumLineSpacing, 0, 32, 0);


        self.configCell = ^(UICollectionViewCell *cell, NSIndexPath *indexPath) {

            OTMenuCollectionViewCell *menuCell = (OTMenuCollectionViewCell *)cell;
            OTCollectionCellData *cellData = self.dataItems[indexPath.section].subItems[indexPath.row];
            menuCell.titleLabel.text = cellData.title;
            menuCell.selected = cellData.selected;

            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {

                if (state == UIGestureRecognizerStateEnded) {
                    if (self.onCollectionCellViewTappedBlock) {
                        self.onCollectionCellViewTappedBlock(indexPath);
                    }
                }
            }];
            [menuCell addGestureRecognizer:tapGesture];
        };

        self.configHeader = ^(UICollectionReusableView *reusableView, NSIndexPath *indexPath) {

            OTMenuCollectionViewHeaderCell *headerView = (OTMenuCollectionViewHeaderCell *)reusableView;
            NSInteger section = indexPath.section;
            headerView.titleLabel.text = self.dataItems[section].title;
            headerView.selected = self.dataItems[section].selected;


            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {

                if (state == UIGestureRecognizerStateEnded) {
                    if (self.onCollectionCellHeaderViewTappedBlock) {
                        self.onCollectionCellHeaderViewTappedBlock(section);
                    }
                }
            }];
            [headerView addGestureRecognizer:tapGesture];
        };

        self.fittingCellSize = ^(NSIndexPath *indexPath, CGSize size) {

            UIEdgeInsets contentInset = self.contentInset;
            UIEdgeInsets sectionInset = self.flowLayout.sectionInset;
            CGFloat maxWidth = CGRectGetWidth(self.frame) - contentInset.left - contentInset.right - sectionInset.left - sectionInset.right;
            CGFloat cellWidth = ceil((maxWidth - self.flowLayout.minimumInteritemSpacing * (self.columnCount - 1)) / self.columnCount);

            size.width = MIN(MAX(size.width, cellWidth), maxWidth);
            size.height = 30;

            return size;
        };
    }

    return self;
}

@end




