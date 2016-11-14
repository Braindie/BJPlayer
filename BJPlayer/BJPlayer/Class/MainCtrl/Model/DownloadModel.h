//
//  DownloadModel.h
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/21.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "ZDBModel.h"

@interface DownloadModel : ZDBModel



//文件名
@property (nonatomic ,strong) NSString *title;
//url网络路径
@property (nonatomic, strong) NSString *savePath;
//本地路径
@property (nonatomic, strong) NSString *filePath;
//下载状态
@property (nonatomic ,assign) NSInteger downloadState;


//临时地址
@property (nonatomic, strong) NSString *tempPath;
//目标地址
@property (nonatomic, strong) NSString *targetPath;


//文件的大小
@property (nonatomic ,strong) NSString *size;
//
@property (nonatomic ,strong) NSString *downProgress;





@end
