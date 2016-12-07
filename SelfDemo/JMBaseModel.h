//
//  JMBaseModel.h
//  OneTargetGClient
//
//  Created by WeiHan on 3/2/16.
//  Copyright © 2016 onetarget. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface JMBaseModel : JSONModel

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array;

@end
