//
//  AVListCell.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/11.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "AVListCell.h"
#import "AVListModel.h"
@implementation AVListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(AVListModel *)model
{
    _model = model;
    
    self.textLabel.text  = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
