//
//  MainTableViewCell.m
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/19.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "MainTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSURL *imageUrl = [NSURL URLWithString:_model.imageUrl];
    [self.mainImage sd_setImageWithURL:imageUrl];
    
    self.titleLabel.text = _model.title;
    
}

@end
