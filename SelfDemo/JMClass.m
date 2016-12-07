//
//  JMClass.m
//  OneTargetGClient
//
//  Created by WeiHan on 3/14/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import "JMClass.h"

@implementation JMGrade

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                @"classList": @"classes"
            }];
}

@end


@implementation JMClass

@end




