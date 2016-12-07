//
//  JMSchool.h
//  OneTargetGClient
//
//  Created by WeiHan on 3/14/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import "JMBaseModel.h"
#import "JMClass.h"

#define kSTR_CommaSeparator @","

NSString * FormatGrades(NSString *grades);


@protocol JMSchool
@end

@interface JMArea : JMBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString<Optional> *phone;
@property (nonatomic, strong) NSArray<JMSchool, ConvertOnDemand> *schools;

@end

@interface JMSchool : JMBaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString<Optional> *typeName;
@property (nonatomic, copy) NSString<Optional> *addressName;
@property (nonatomic, copy) NSString<Optional> *masterName;
@property (nonatomic, copy) NSString<Optional> *masterPhone;
@property (nonatomic, copy) NSString<Optional> *grades;
@property (nonatomic, copy) NSString<Optional> *classAmount;
@property (nonatomic, copy) NSString<Optional> *studentAmount;

@end
