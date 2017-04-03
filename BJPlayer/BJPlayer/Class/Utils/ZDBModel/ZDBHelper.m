//
//  ZDBHelper.m
//  QimuDemo
//
//  Created by zhangwenjun on 16/8/22.
//  Copyright © 2016年 ll. All rights reserved.
//

#import "ZDBHelper.h"

@interface ZDBHelper ()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation ZDBHelper

static ZDBHelper *_instance = nil;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [ZDBHelper shareInstance];
}

- (FMDatabaseQueue *)dbQueue
{
    if (_dbQueue == nil) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self.class dbPath]];
    }
    return _dbQueue;
}


+ (NSString *)dbPath
{
    return [self dbPathWithDirectoryName:nil];
}

+ (NSString *)dbPathWithDirectoryName:(NSString *)directoryName{
    NSString *docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *filemanage = [NSFileManager defaultManager];
    if (directoryName == nil || directoryName.length == 0) {
        docsdir = [docsdir stringByAppendingPathComponent:@"BJBD"];//默认文件名
    } else {
        docsdir = [docsdir stringByAppendingPathComponent:directoryName];
    }
    BOOL isDir;
    BOOL exit =[filemanage fileExistsAtPath:docsdir isDirectory:&isDir];
    if (!exit || !isDir) {
        [filemanage createDirectoryAtPath:docsdir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *dbpath = [docsdir stringByAppendingPathComponent:@"bjdb.sqlite"];
    return dbpath;
}

@end
