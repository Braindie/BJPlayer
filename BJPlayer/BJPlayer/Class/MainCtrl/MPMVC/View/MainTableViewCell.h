//
//  MainTableViewCell.h
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/19.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableModel.h"

@interface MainTableViewCell : UITableViewCell
@property (nonatomic, strong) MainTableModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@end
