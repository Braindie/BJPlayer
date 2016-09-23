//
//  DownloadModel.h
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/21.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "ZDBModel.h"

@interface DownloadModel : ZDBModel

//
@property (nonatomic, strong) NSString *savePath;
//
@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *tempPath;//临时地址
@property (nonatomic, strong) NSString *targetPath;//目标地址
//文件名
@property (nonatomic ,strong) NSString *title;
//下载状态
@property (nonatomic ,strong) NSString *downloadState;
//
@property (nonatomic ,strong) NSString *downProgress;

//@property (nonatomic, strong) NSString *fileSize;//文件的大小（弃用）

//文件的大小
@property (nonatomic ,strong) NSString *size;
//@property (nonatomic ,strong) NSString *fileSize;


@end
