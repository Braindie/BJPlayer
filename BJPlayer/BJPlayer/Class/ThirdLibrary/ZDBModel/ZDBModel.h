//
//  ZDBModel.h
//  QimuDemo
//
//  Created by zhangwenjun on 16/8/22.
//  Copyright © 2016年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>

/** SQLite五种数据类型 */
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"
#define PrimaryKey  @"primary key"

#define primaryId   @"pk"

@interface ZDBModel : NSObject

/** 主键 id */
@property (nonatomic, assign)   int        pk;
/** 列名 */
@property (retain, readonly, nonatomic) NSMutableArray         *columeNames;
/** 列类型 */
@property (retain, readonly, nonatomic) NSMutableArray         *columeTypes;



/** 插入数据 */
+ (BOOL)saveObjects:(NSArray *)array;


/** 删除数据 */
+ (BOOL)deleteObjects:(NSArray *)array;
/** 清空表 */
+ (BOOL)clearTable;


/** 更新数据 */
+ (BOOL)updateObjects:(NSArray *)array;



/** 查找数据 */
+ (NSArray *)findByCriteria:(NSString *)criteria;

@end
