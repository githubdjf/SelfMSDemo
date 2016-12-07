//
//  Case1ViewController.m
//  SelfDemo
//
//  Created by Jaffer on 16/12/6.
//  Copyright © 2016年 51Nage. All rights reserved.
//

#import "Case1ViewController.h"
#import "AutoIncrementFrameView.h"
#import <Masonry/Masonry.h>

@interface Case1ViewController () <UISearchBarDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) AutoIncrementFrameView *autoView;
@property (nonatomic, strong) UITextField *keyboardField;
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic, strong) UIButton *increaseButton;
@property (nonatomic, strong) MASConstraint *keyboardFieldBottomConstraint;

@end

@implementation Case1ViewController

#pragma mark dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self listenKeyboard];
    [self initViews];
}

- (void)listenKeyboard {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notify {

}

- (void)keyboardWillHide:(NSNotification *)notify {

}

- (void)keyboardFrameWillChange:(NSNotification *)notify {
    NSDictionary *info = notify.userInfo;
    if (info) {
        NSLog(@"key board info =%@",info);
        NSTimeInterval animationInterval = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect keyboardFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat availableHeight = [UIScreen mainScreen].bounds.size.height - CGRectGetMinY(keyboardFrame);
        [self updateFieldConstraintByKeyboardVisibleHeight:availableHeight withinDuration:animationInterval];
    }
}

#pragma mark update
- (void)updateFieldConstraintByKeyboardVisibleHeight:(CGFloat)height withinDuration:(NSTimeInterval)duration {
    //方式一
    [self.keyboardField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-height);
    }];
    //方法二
    //self.keyboardFieldBottomConstraint.mas_equalTo(-height);
    
    [UIView animateWithDuration:duration
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

- (void)updateAutoViewByViewSize:(CGSize)size {
    [self.autoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}

#pragma mark init views
- (void)initViews {
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.barStyle = UISearchBarStyleDefault;
    searchBar.placeholder = @"请输入搜索内容";
    searchBar.scopeButtonTitles = @[@"item1",@"item2",@"item3"];
    searchBar.showsScopeBar = YES;
    searchBar.showsCancelButton = YES;
    searchBar.showsSearchResultsButton = YES;
    searchBar.delegate = self;
    self.searchBar = searchBar;
    [self.view addSubview:searchBar];
    
    CGFloat incrementWidth = 200;
    CGFloat incrementHeight = 100;
    AutoIncrementFrameView *incrementView = [[AutoIncrementFrameView alloc] initWithFrame:CGRectMake(0, 0, incrementWidth, incrementHeight)];
    incrementView.backgroundColor = [UIColor greenColor];
    self.autoView = incrementView;
    [self.view addSubview:incrementView];
    
    UITextField *field = [UITextField new];
    field.backgroundColor = [UIColor yellowColor];
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.placeholder = @"send";
    field.delegate = self;
    self.keyboardField = field;
    [self.view addSubview:field];
    
    UIView *space1 = [UIView new];
    [self.view addSubview:space1];
    
    UIView *space2 = [UIView new];
    [self.view addSubview:space2];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
    
    [space1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.autoView.mas_top);
        make.height.equalTo(space2.mas_height);
    }];
    
    [self.autoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(space1.mas_bottom);
    }];
    
    [space2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.autoView.mas_bottom);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
    [self.keyboardField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.searchBar);
        self.keyboardFieldBottomConstraint = make.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

#pragma mark action
#pragma mark text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

}

#pragma mark search delegate
- (void)resign {
    [self.searchBar resignFirstResponder];
}

#pragma mark delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"search");
    [self resign];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"cancel");
    [self resign];
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"result list click");
    [self resign];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    NSLog(@"scope selected at index %d",selectedScope);
    CGSize finalSize = [self.autoView increaseByMultiplier:selectedScope];
    [self updateAutoViewByViewSize:finalSize];
    [self resign];
}



@end




