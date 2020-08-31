//
//  CatalogCell.h

#import <UIKit/UIKit.h>
#import "SubCatalogModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CatalogCell : UITableViewCell

@property (nonatomic, retain) SubCatalogModel *childModel;

@end

NS_ASSUME_NONNULL_END
