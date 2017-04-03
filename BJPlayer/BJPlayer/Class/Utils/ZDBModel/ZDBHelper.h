//
//  ZDBHelper.h
//  QimuDemo
//
//  Created by zhangwenjun on 16/8/22.
//  Copyright © 2016年 ll. All rights reserved.
//

#import "FMDB.h"

@interface ZDBHelper : NSObject

@property (nonatomic, strong, readonly) FMDatabaseQueue *dbQueue;


+ (ZDBHelper *)shareInstance;

+ (NSString *)dbPath;

@end
