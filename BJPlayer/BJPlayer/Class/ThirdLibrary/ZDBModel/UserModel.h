//
//  UserModel.h
//  QimuDemo
//
//  Created by zhangwenjun on 16/8/22.
//  Copyright © 2016年 ll. All rights reserved.
//

#import "ZDBModel.h"

@interface UserModel : ZDBModel



///** 账号 */
//@property (nonatomic, copy)     NSString                    *account;
/** 名字 */
@property (nonatomic, copy)     NSString                    *name;
/** 性别 */
@property (nonatomic, copy)     NSString                    *sex;
/** 手机号码 */
@property (nonatomic, copy)     NSString                    *mobile;



@end
