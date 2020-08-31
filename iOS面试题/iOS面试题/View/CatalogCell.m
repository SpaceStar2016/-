//
//  CatalogCell.m

#import "CatalogCell.h"

@interface CatalogCell ()
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end



@implementation CatalogCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setChildModel:(SubCatalogModel *)childModel{
    _childModel = childModel;
    self.titleLabel.text = _childModel.answer;

}

@end
