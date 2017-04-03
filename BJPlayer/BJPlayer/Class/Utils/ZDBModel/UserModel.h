//
//  UserModel.h
//  QimuDemo
//
//  Created by zhangwenjun on 16/8/22.
//  Copyright © 2016年 ll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject<NSCopying>


///** 账号 */
//@property (nonatomic, copy)     NSString                    *account;
/** 名字 */
@property (nonatomic, copy)     NSString                    *name;
/** 性别 */
@property (nonatomic, copy)     NSString                    *sex;
/** 手机号码 */
@property (nonatomic, copy)     NSString                    *mobile;


- (NSString *)description;


//for (int i = 0; i<10; i++) {
//    UserModel *userModel = [[UserModel alloc] init];
//    userModel.name = @"BigBaby";
//    userModel.sex = @"男";
//    userModel.mobile = @"110";
//    [self.myDataArr addObject:userModel];
//}
//
//// 归档，调用归档方法
//NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"person.plist"];
//BOOL success = [NSKeyedArchiver archiveRootObject:self.myDataArr toFile:filePath];
//NSLog(@"%d",success);
//
//// 反归档，调用反归档方法
//NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//NSLog(@"%@",arr);
//
//UserModel *model = [arr lastObject];
//model.mobile = @"120";
//[arr removeLastObject];
//[arr addObject:model];
//
//// 归档，调用归档方法
//NSString *fileP = [NSHomeDirectory() stringByAppendingString:@"person.plist"];
//BOOL successP = [NSKeyedArchiver archiveRootObject:arr toFile:fileP];
//NSLog(@"%d",successP);
//
//// 反归档，调用反归档方法
//NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//NSLog(@"%@",array);



@end
