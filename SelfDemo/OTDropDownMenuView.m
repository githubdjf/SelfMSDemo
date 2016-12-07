//
//  OTDropDownMenuView.m
//  OneTargetGClient
//
//  Created by WeiHan on 5/6/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import "OTDropDownMenuView.h"
#import <Masonry/Masonry.h>
#define RGBA(__r, __g, __b, __a)           \
[UIColor colorWithRed : (__r / 255.0f) \
green : (__g / 255.0f)                \
blue : (__b / 255.0f)                 \
alpha : (__a)]

#define RGB(__r, __g, __b) RGBA(__r, __g, __b, 1.0)

#pragma mark - OTDropDownMenuItemView
#define LOADIMAGE(__image) [UIImage imageNamed : (__image)]


@interface OTDropDownMenuItemView : UIControl

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

/**
 *    @brief selectedItemChanged will be called when user tapped the menu item view only.
 */
@property (nonatomic, copy) void (^ selectedStateChanged)(BOOL selected);

@end

@implementation OTDropDownMenuItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor greenColor].CGColor;
        self.layer.borderWidth = 0.5f;

        _containerView = [UIView new];
        _titleLabel = [UILabel new];
        _imageView = [UIImageView new];

        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        _titleLabel.userInteractionEnabled = YES;

        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemViewTapped:)];
        [_titleLabel addGestureRecognizer:tapGesture];
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemViewTapped:)];
        [_imageView addGestureRecognizer:tapGesture];

        [self addSubview:_containerView];
        [_containerView addSubview:_titleLabel];
        [_containerView addSubview:_imageView];

        self.selected = NO;

        [self addTarget:self action:@selector(itemViewTapped:) forControlEvents:UIControlEventTouchUpInside];
    }

    return self;
}

- (void)updateConstraints
{
    [self.containerView
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);

        make.height.greaterThanOrEqualTo(self.titleLabel.mas_height);
        make.height.greaterThanOrEqualTo(self.imageView.mas_height);

        make.left.equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.imageView.mas_right);
    }];

    [self.titleLabel sizeToFit];

    [self.titleLabel
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
    }];

    [self.imageView
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
    }];

    [super updateConstraints];
}

#pragma mark - Property

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    self.titleLabel.textColor = selected ? RGB(80, 80, 80) : RGB(142, 142, 142);
    self.imageView.image = LOADIMAGE(selected ? @"dropdown_menu_arrow_up" : @"dropdown_menu_arrow_down");
}

#pragma mark - Actions

- (void)itemViewTapped:(id)sender
{
    self.selected = !self.selected;

    if (self.selectedStateChanged) {
        self.selectedStateChanged(self.selected);
    }
}

@end


#pragma mark - OTDropDownMenuView

@interface OTDropDownMenuView ()

@property (nonatomic, strong) UIView *menuItemContainerView;

@property (nonatomic, strong) NSArray<OTDropDownMenuItemView *> *menuItemViews;

@end

@implementation OTDropDownMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

- (void)updateConstraints
{
    [self.menuItemContainerView
     mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height);
    }];

    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
    }];

    [super updateConstraints];
}

#pragma mark - Public

- (void)updateMenuItem:(NSString *)strTitle forIndex:(NSUInteger)index
{
    if (index < self.menuItemViews.count) {
        OTDropDownMenuItemView *currentMenuItemView = self.menuItemViews[index];

        currentMenuItemView.titleLabel.text = strTitle;
    }
}

#pragma mark - Property

- (UIView *)menuItemContainerView
{
    if (!_menuItemContainerView) {
        _menuItemContainerView = [UIView new];
        [self addSubview:_menuItemContainerView];

        _menuItemContainerView.layer.borderColor = RGB(230, 230, 230).CGColor;
        _menuItemContainerView.layer.borderWidth = 1.0f;
    }

    return _menuItemContainerView;
}

- (void)setMenuItems:(NSArray<NSString *> *)menuItems
{
    _menuItems = menuItems;

    [self.menuItemContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSUInteger count = _menuItems.count;
    OTDropDownMenuItemView *leftItemView;
    NSMutableArray *arrItemView = [[NSMutableArray alloc] initWithCapacity:count];

    for (NSUInteger idx = 0; idx < count; idx++) {
        NSString *title = _menuItems[idx];

        OTDropDownMenuItemView *itemView = [OTDropDownMenuItemView new];

        itemView.titleLabel.text = title;
        [self.menuItemContainerView addSubview:itemView];

        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.menuItemContainerView.mas_centerY);
            make.height.equalTo(self.menuItemContainerView.mas_height);
            make.width.equalTo(self.menuItemContainerView.mas_width).dividedBy(count);

            if (leftItemView) {
                make.left.equalTo(leftItemView.mas_right);
            } else {
                make.left.equalTo(self.menuItemContainerView.mas_left);
            }
        }];


        itemView.selectedStateChanged = ^(BOOL selected) {

            for (OTDropDownMenuItemView *item in self.menuItemViews) {
                if (![item isEqual:itemView]) {
                    item.selected = NO;
                }
            }

            self.selectedItemIndex = selected ? idx : NSNotFound;

            if (self.selectedItemChanged) {
                self.selectedItemChanged(idx, selected);
            }
        };

        [arrItemView addObject:itemView];
        leftItemView = itemView;
    }

    self.menuItemViews = arrItemView;
}

- (void)setSelectedItemIndex:(NSUInteger)selectedItemIndex
{
    _selectedItemIndex = selectedItemIndex;

    if (selectedItemIndex < self.menuItemViews.count) {
        OTDropDownMenuItemView *currentMenuItemView = self.menuItemViews[selectedItemIndex];
        currentMenuItemView.selected = YES;
    } else {
        for (NSUInteger idx = 0; idx < self.menuItemViews.count; idx++) {
            self.menuItemViews[idx].selected = NO;
        }
    }
}

@end




