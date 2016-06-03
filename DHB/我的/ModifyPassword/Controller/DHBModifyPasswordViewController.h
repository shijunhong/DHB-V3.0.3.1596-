//
//  DHBModifyPasswordViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/30/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBModifyPasswordTableViewCell.h"
#import "DHBModifyPasswordViewRequest.h"

@interface DHBModifyPasswordViewController : DHBTableViewController<DHBModifyPasswordTableViewCell_Delegate>
{
    id firstResponser;
}
/**
 *  dataArray：tableView数据源
 */
@property(nonatomic, strong) NSArray *dataArray;
/**
 *  placeholderDataArray: textFeild的默认数据源
 */
@property(nonatomic, strong) NSArray *placeholderDataArray;
/**
 *  compeleteButton: 确定按钮
 */
@property(nonatomic, strong) UIButton *compeleteButton;
@end
