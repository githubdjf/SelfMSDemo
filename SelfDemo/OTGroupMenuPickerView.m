//
//  OTGroupMenuPickerView.m
//  OneTargetGClient
//
//  Created by WeiHan on 5/10/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import "OTGroupMenuPickerView.h"
#import <Masonry/Masonry.h>
#define RGBA(__r, __g, __b, __a)           \
[UIColor colorWithRed : (__r / 255.0f) \
green : (__g / 255.0f)                \
blue : (__b / 255.0f)                 \
alpha : (__a)]

#define RGB(__r, __g, __b) RGBA(__r, __g, __b, 1.0)


@interface OTGroupMenuPickerView ()

@property (nonatomic, strong) OTDropDownMenuView *dropDownView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *bottomGrayView;
@property (nonatomic, strong) OTMenuCollectionView *collectionView;

@end

@implementation OTGroupMenuPickerView

- (void)updateConstraints
{
    [self.dropDownView
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
    }];

    [self.containerView
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.dropDownView.mas_bottom);
        make.bottom.equalTo(self.bottomGrayView.mas_top);
    }];

    [self.bottomGrayView
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_width).dividedBy(8);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self.mas_width);
        make.centerX.equalTo(self.mas_centerX);
    }];

    [self layoutCollectionView:NO];

    [super updateConstraints];
}

#pragma mark - Property

- (OTDropDownMenuView *)dropDownView
{
    if (!_dropDownView) {
        _dropDownView = [OTDropDownMenuView new];
        [self addSubview:_dropDownView];

        _dropDownView.selectedItemChanged = ^(NSUInteger selectedIndex, BOOL state) {
            self.expanded = state;

            if (self.selectedMenuChanged) {
                self.selectedMenuChanged(state ? selectedIndex : NSNotFound);
            }
        };
    }

    return _dropDownView;
}

- (UIView *)containerView
{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.clipsToBounds = YES;
        [self addSubview:_containerView];
    }

    return _containerView;
}

- (UIView *)bottomGrayView
{
    if (!_bottomGrayView) {
        _bottomGrayView = [UIView new];
        _bottomGrayView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        [self addSubview:_bottomGrayView];
        [self updateBottomGrayView:NO];
    }

    return _bottomGrayView;
}

- (OTMenuCollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [OTMenuCollectionView new];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.containerView addSubview:_collectionView];
    }

    return _collectionView;
}

- (void)setExpanded:(BOOL)expanded
{
    BOOL fAnimation = _expanded != expanded;

    _expanded = expanded;

    if (!expanded) {
        self.dropDownView.selectedItemIndex = NSNotFound;
    }

    [self layoutCollectionView:fAnimation];
}

#pragma mark - Private

- (void)updateBottomGrayView:(BOOL)visible
{
    self.bottomGrayView.alpha = visible ? 1.0f : 0.0f;
}

- (void)layoutCollectionView:(BOOL)animation
{
    [self.collectionView
     mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.containerView.mas_width);
        make.centerX.equalTo(self.containerView.mas_centerX);
        make.height.equalTo(self.containerView.mas_height);

        if (self.expanded) {
            make.top.equalTo(self.containerView.mas_top);
        } else {
            make.bottom.equalTo(self.containerView.mas_top);
        }
    }];

    if (animation) {
        [UIView animateWithDuration:0.1f
                         animations:^{
            [self updateBottomGrayView:self.expanded];
            [self layoutIfNeeded];
        }];
    } else {
        [self updateBottomGrayView:self.expanded];
    }
}

@end




