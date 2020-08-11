//
//  AVListCell.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/11.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "AVListCell.h"
#import "AVListModel.h"
@interface AVListCell()
@property (weak, nonatomic) IBOutlet UILabel *ttLabel;

@end
@implementation AVListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(AVListModel *)model
{
    _model = model;
    self.ttLabel.text  = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
