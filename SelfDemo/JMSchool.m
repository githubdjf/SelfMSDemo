//
//  JMSchool.m
//  OneTargetGClient
//
//  Created by WeiHan on 3/14/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import "JMSchool.h"

NSString *FormatGrades(NSString *grades)
{
    if (!grades) {
        return nil;
    }

    NSArray *items = [grades componentsSeparatedByString:kSTR_CommaSeparator];
    NSMutableString *string = [NSMutableString new];

    for (NSUInteger i = 0; i < items.count; i++) {
        NSString *item = items[i];

        if (item.length > 0) {
            NSString *grade = [item.uppercaseString hasPrefix:@"K"] ? [item substringFromIndex:1] : item;

            [string appendString:grade];
        }

        if (i != items.count - 1) {
            [string appendString:kSTR_CommaSeparator];
        }
    }

    return string;
}


@implementation JMArea

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                @"records": @"schools"
            }];
}

@end

@implementation JMSchool

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                @"contactName": @"masterName",
                @"contactPhone": @"masterPhone",
                @"pName": @"masterName",
                @"pPhone": @"masterPhone",
                @"classAcount": @"classAmount",
                @"pCount": @"studentAmount"
            }];
}

#pragma mark - Property

- (NSString<Optional> *)grades
{
    return FormatGrades(_grades);
}

@end




