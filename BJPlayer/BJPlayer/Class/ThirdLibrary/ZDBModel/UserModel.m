//
//  UserModel.m
//  QimuDemo
//
//  Created by zhangwenjun on 16/8/22.
//  Copyright © 2016年 ll. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

// 归档方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
}
// 反归档方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (self != nil) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
    }
    return self;
}

- (NSString *)description
{
    NSString *string = [NSString stringWithFormat:@"%@,%@,%@",self.name,self.sex,self.mobile];
    return string;
}

@end
