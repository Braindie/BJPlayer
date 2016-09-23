//
//  DownloadingCell.h
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/20.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *fileSize;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *percent;

@end
