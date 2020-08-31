//
//  CatalogModel.h


#import <Foundation/Foundation.h>
#import "SubCatalogModel.h"
#import "MJExtension.h"
NS_ASSUME_NONNULL_BEGIN

@interface CatalogModel : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *name;

/** 内容 */
@property (nonatomic, copy) NSArray<SubCatalogModel *> *content;

/** 是否展开 */
@property (nonatomic, assign) BOOL isExpand;
@end

NS_ASSUME_NONNULL_END
