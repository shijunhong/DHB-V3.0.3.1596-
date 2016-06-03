//
//  DHBProductViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/2.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "CDRTranslucentSideBar.h"
#import "GoodsListService.h"
#import "SiftingService.h"
#import "MultiOptionsService.h"
#import "DHBOptionTableViewCell.h"

@interface DHBGoodsViewController : DHBTableViewController<CDRTranslucentSideBarDelegate,GoodsListServiceDelegate,SiftingServiceDelegate,MultiOptionsServiceDelegate, DHBOptionTableViewCellDelegate>
{
    UITableViewCell *curOperateTableViewCell; ///当前操作的cell
}

@property(nonatomic,strong)GoodsListService *goodsListService;
@property (strong, nonatomic) CategoryModuleDTO *selectedCategory;///选择的商品类别
@property (strong, nonatomic) NSString *searchContent;///搜索的内容
@property (nonatomic,assign)BOOL is_Barcode;//是否是扫描进入
@property (nonatomic,assign)BOOL is_Category;//是否分类进入
@end
