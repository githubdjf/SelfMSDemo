//
//  ViewController.m
//  SelfDemo
//
//  Created by Jaffer on 16/12/5.
//  Copyright © 2016年 51Nage. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "Case1ViewController.h"
#import "Case2ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) TPKeyboardAvoidingScrollView *contentView;
@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UILabel *pwdLabel;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    
    [self initViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark init views
- (void)initViews {
    CGFloat contentHeight = [UIScreen mainScreen].bounds.size.height - 64.0;
    CGFloat headWith = 140;
    CGFloat labelWidht = 60;
    CGFloat labelHeight = 40;
    CGFloat fieldHeight = 40;
    
    TPKeyboardAvoidingScrollView *scroll = [TPKeyboardAvoidingScrollView new];
    scroll.backgroundColor = [UIColor lightGrayColor];
    self.contentView = scroll;
    [self.view addSubview:scroll];
    
    UIImageView *portrait = [UIImageView new];
    portrait.backgroundColor = [UIColor redColor];
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, headWith, headWith) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(headWith/4, headWith/4)];
    CAShapeLayer *roundShape = [CAShapeLayer layer];
    roundShape.path = roundPath.CGPath;
    portrait.layer.mask = roundShape;
    self.portraitImageView = portrait;
    [self.contentView addSubview:portrait];
    
    UILabel *account = [UILabel new];
    account.backgroundColor = [UIColor greenColor];
    account.textAlignment = NSTextAlignmentRight;
    account.font = [UIFont systemFontOfSize:14.0];
    account.text = @"Account";
    self.accountLabel = account;
    [self.contentView addSubview:account];
    
    UITextField *firstField = [UITextField new];
    firstField.backgroundColor = [UIColor redColor];
    firstField.placeholder = @"请输入账户名称";
    self.accountField = firstField;
    [self.contentView addSubview:firstField];
    
    UILabel *pwd = [UILabel new];
    pwd.backgroundColor = [UIColor greenColor];
    pwd.textAlignment = NSTextAlignmentRight;
    pwd.font = [UIFont systemFontOfSize:14.0];
    pwd.text = @"Pwd";
    self.pwdLabel = pwd;
    [self.contentView addSubview:pwd];
    
    UITextField *secondField = [UITextField new];
    secondField.backgroundColor = [UIColor redColor];
    secondField.placeholder = @"请输入账户密码";
    self.pwdField = secondField;
    [self.contentView addSubview:secondField];
    
    UIButton *login = [UIButton new];
    login.backgroundColor = [UIColor yellowColor];
    [login setTitle:@"login" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton = login;
    [self.contentView addSubview:self.loginButton];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.portraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(contentHeight * 0.1 + 64);
        make.width.mas_equalTo(headWith);
        make.height.mas_equalTo(headWith);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.portraitImageView.mas_bottom).offset(40);
        make.height.mas_equalTo(labelHeight);
        make.width.mas_equalTo(labelWidht);
    }];
    
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountLabel.mas_right).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.accountLabel.mas_top);
        make.height.mas_equalTo(fieldHeight);
    }];
    
    [self.pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountLabel.mas_left);
        make.top.equalTo(self.accountLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(labelWidht, labelHeight));
    }];
    
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pwdLabel.mas_right).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.pwdLabel.mas_top);
        make.height.mas_equalTo(fieldHeight);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(300).priorityHigh();
        make.top.equalTo(self.pwdLabel.mas_bottom).offset(10).priorityHigh();
        make.height.greaterThanOrEqualTo(@(50));
        
        make.bottom.lessThanOrEqualTo(self.view.mas_bottom).offset(-50);
    }];
}


#pragma mark action
- (void)login {
    NSLog(@"login action");
//    Case1ViewController *case1 = [Case1ViewController new];
//    [self.navigationController pushViewController:case1 animated:YES];
    
    Case2ViewController *case2 = [Case2ViewController new];
    [self.navigationController pushViewController:case2 animated:YES];
}

@end
















