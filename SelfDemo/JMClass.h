//
//  JMClass.h
//  OneTargetGClient
//
//  Created by WeiHan on 3/14/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import "JMBaseModel.h"

@protocol JMClass
@end

@interface JMGrade : JMBaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<JMClass, ConvertOnDemand> *classes;

@end

@interface JMClass : JMBaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString<Optional> *principalName;
@property (nonatomic, copy) NSString<Optional> *principalPhone;
@property (nonatomic, copy) NSNumber<Optional> *studentAmount;
@property (nonatomic, copy) NSNumber<Optional> *isConfirm; // for student identification

@end
