//
//  DHBSupplierListTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 2/22/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBSupplierModuleDTO.h"

@interface DHBSupplierListTableViewCell : UITableViewCell
/**
 *  顶部分割线
 */
@property(nonatomic, retain) UIView *topLineView;
/**
 *  供应商名称背景视图
 */
@property(nonatomic, retain) UIView *supplierNameBgView;
/**
 *  消息提示
 */
@property(nonatomic, retain) UIButton *prompt_btn;
/**
 *  箭头
 */
@property(nonatomic, retain) UIImageView *arrowImageView;
/**
 *  供应商名称
 */
@property(nonatomic, retain) UILabel *supplierLabel;
/**
 *  账号状态
 */
@property(nonatomic, retain) UILabel *statusLabel;
/**
 *  账号状态背景视图
 */
@property(nonatomic, retain) UIView *statusBgView;
/**
 *  底部分割线
 */
@property(nonatomic, retain) UIView *bottomLineView;

/**
 *  public method
 *  根据数据模型加载数据
 *  @param dto 供应商数据模型
 */
- (void)updateViewWithDTO:(DHBSupplierModuleDTO *) dto CompanyID:(NSInteger)company_id;
@end
