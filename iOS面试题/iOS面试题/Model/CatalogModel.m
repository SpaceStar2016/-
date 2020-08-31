//
//  CatalogModel.m


#import "CatalogModel.h"

@implementation CatalogModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"content" : [SubCatalogModel class]};
}

MJCodingImplementation

@end
