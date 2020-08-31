//
//  AVListCell.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/11.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "MainListCell.h"
#import "MainListModel.h"
@interface MainListCell()
@property (weak, nonatomic) IBOutlet UILabel *ttLabel;

@end
@implementation MainListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setModel:(MainListModel *)model
{
    _model = model;
    self.ttLabel.text  = model.title;
    if (model.isMain) {
        self.ttLabel.textColor = [UIColor redColor];
    }else
    {
        self.ttLabel.textColor = [UIColor blackColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
