//
//  Case2ViewController.m
//  SelfDemo
//
//  Created by Jaffer on 16/12/7.
//  Copyright © 2016年 51Nage. All rights reserved.
//

#import "Case2ViewController.h"
#import "OTGroupMenuPickerView.h"
#import "OTDropDownMenuView.h"
#import "OTMenuCollectionView.h"
#import "JMSchool.h"
#import <Masonry/Masonry.h>

#define kSTR_Region     @"地域"
#define kSTR_SchoolType @"学校类型"
#define kSTR_All        @"全部"

#define kSTRKey_Icon    @"Icon"
#define kSTRKey_Title   @"Title"

#define kArray_FilterInfo                                                    \
@[                                                                       \
@{ kSTRKey_Icon: @"school_icon",   kSTRKey_Title: @"学校" },           \
@{ kSTRKey_Icon: @"grade_small_icon",   kSTRKey_Title: @"年级" },      \
@{ kSTRKey_Icon: @"student_small_icon",   kSTRKey_Title: @"人数" },    \
@{ kSTRKey_Icon: @"phone_master_icon",   kSTRKey_Title: @"负责人联系方式" } \
]


@interface Case2ViewController ()

@property (nonatomic, strong) OTGroupMenuPickerView *pickerView;
@property (nonatomic, strong) NSArray<JMArea *> *areaList;
@property (nonatomic, strong) NSArray<JMSchool *> *schoolList;



@end

@implementation Case2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView = [OTGroupMenuPickerView new];
    [self.view addSubview:self.pickerView];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(74, 10, 10, 10));
    }];
    
    [self fakeData];
    
    [self load];
}

- (void)load {
    OTDropDownMenuView *dropDownView = self.pickerView.dropDownView;
    OTMenuCollectionView *collectionView = self.pickerView.collectionView;
    
    NSArray<NSString *> *arrMenuItems = @[kSTR_Region, kSTR_SchoolType];
    
    dropDownView.menuItems = arrMenuItems;
    
    OTCollectionGroupCellData *regionGroupData = [OTCollectionGroupCellData new];
    OTCollectionGroupCellData *schoolTypeGroupData = [OTCollectionGroupCellData new];
    OTCollectionCellData *data = nil;
    NSMutableArray<OTCollectionCellData *> *cellData = [NSMutableArray new];
    
    for (NSString *item in [self allRegions]) {
        data = [OTCollectionCellData new];
        data.title = item;
        [cellData addObject:data];
    }
    
    regionGroupData.title = kSTR_All;
    regionGroupData.subItems = cellData;
    
    
    cellData = [NSMutableArray new];
    
    for (NSString *item in [self allSchoolTypes]) {
        data = [OTCollectionCellData new];
        data.title = item;
        [cellData addObject:data];
    }
    
    schoolTypeGroupData.title = kSTR_All;
    schoolTypeGroupData.subItems = cellData;
    
    
    
    self.pickerView.selectedMenuChanged = ^(NSUInteger selectedIndex) {
        
        if (selectedIndex == 0) {
            collectionView.dataItems = @[regionGroupData];
        } else if (selectedIndex == 1) {
            collectionView.dataItems = @[schoolTypeGroupData];
        }
    };
    
    collectionView.onCollectionCellViewTappedBlock = ^(NSIndexPath *indexPath) {
        
        NSString *title = collectionView.dataItems[indexPath.section].subItems[indexPath.row].title;
        NSUInteger selectedIndex = dropDownView.selectedItemIndex;
        
//        if (selectedIndex == 0) {
//            self.schoolAreaCondition = title;
//        } else if (selectedIndex == 1) {
//            self.schoolTypeCondition = title;
//        } else {
//            NSAssert(NO, @"Unexpected menu selected item index!");
//        }
        
        [dropDownView updateMenuItem:title forIndex:selectedIndex];
        self.pickerView.expanded = NO;
    };
    
    collectionView.onCollectionCellHeaderViewTappedBlock = ^(NSInteger section) {
        
        NSUInteger selectedIndex = dropDownView.selectedItemIndex;
        
//        if (selectedIndex == 0) {
//            self.schoolAreaCondition = nil;
//        } else if (selectedIndex == 1) {
//            self.schoolTypeCondition = nil;
//        } else {
//            NSAssert(NO, @"Unexpected menu selected item index!");
//        }
        
        NSString *title = arrMenuItems[selectedIndex];
        [dropDownView updateMenuItem:title forIndex:dropDownView.selectedItemIndex];
        self.pickerView.expanded = NO;
    };

}

- (void)fakeData {
    NSMutableArray * areas = [NSMutableArray new];
    NSArray *names = @[@"的",@"的",@"的",@"发多少级的说法发的说法发的说法发斯蒂芬",@"发",@"发的发法师法生发发",@"发的",@"发大水发发发",@"飞得更高",@"发发送",@"发发发",@"发多少发到付发",@"发生大发发"];
    for (NSUInteger idx = 1; idx <= 10; idx++) {
        JMArea *area = [JMArea new];
        
        area.name = names[idx - 1];
        area.phone = @"1234567890";
        
        NSMutableArray *schools = [NSMutableArray new];
        
        for (NSUInteger i = 1; i <= 50; i++) {
            JMSchool *school = [JMSchool new];
            
            school.name = [NSString stringWithFormat:@"学校%ld", i * idx];
            school.typeName = [NSString stringWithFormat:@"类型%ld", (i * idx) % 5];
            school.grades = @"K1, K2, K4, K5";
            school.classAmount = @(10);
            school.studentAmount = @(i * 10);
            school.addressName = [NSString stringWithFormat:@"地址%ld", idx];
            school.masterName = [NSString stringWithFormat:@"校长%ld", i];
            school.masterPhone = @"1231231";
            
            [schools addObject:school];
        }
        
        area.schools = (NSArray<JMSchool, ConvertOnDemand> *)schools;
        
        [areas addObject:area];
    }
    
    self.areaList = areas;
}

- (NSMutableArray<NSString *> *)allRegions
{
    NSMutableArray<NSString *> *arrRegion = [[NSMutableArray alloc] initWithCapacity:self.areaList.count];
    
    for (JMArea *area in self.areaList) {
        [arrRegion addObject:area.name];
    }
    
    return arrRegion;
}

- (NSMutableArray<NSString *> *)allSchoolTypes
{
    NSMutableArray *arrTypes = [NSMutableArray new];
    
    for (JMSchool *school in self.schoolList) {
        NSString *strType = school.typeName;
        
        if (strType.length > 0 && ![arrTypes containsObject:strType]) {
            [arrTypes addObject:strType];
        }
    }
    
    return arrTypes;
}

@end
