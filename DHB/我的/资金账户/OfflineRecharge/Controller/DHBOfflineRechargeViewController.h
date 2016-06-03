//
//  DHBOfflineRechargeViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/11/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBOfflineRechargeService.h"
#import "DHBOfflineRechargeTableViewCell.h"
#import "DeliveryDateTableViewCell.h"
#import "DHBRechargeResultViewController.h"
#import "OrderModuleDTO.h"
#import "PayType.h"
#import "DHBUploadImage.h"
#import "AppDelegate.h"

@interface DHBOfflineRechargeViewController : DHBTableViewController<DHBOfflineRechargeService_Delegte, DeliveryDateTableViewCell_Delegate, DHBOfflineRechargeTableViewCell_Delegte, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    CGFloat datePicker_height;
    NSDictionary *_selectBank;//选中得银行
    NSString *_remark;//备注
    NSString * _receipts_date;//时间
    NSDictionary *requestDictionary;
    DHBButton *submitButton;
}
@property(nonatomic,assign)BOOL keyboard_isShow;
@property(nonatomic, retain) DHBOfflineRechargeService *mainService;
@property(nonatomic, retain) UIView *bottomView;
@property(nonatomic, strong) OrderModuleDTO *order;//订单
@property(nonatomic, strong)PayType *paytype;
@property(nonatomic, strong) NSString *amount;//充值金额
@property(nonatomic, strong) DHBUploadImage *uploadImage; //上传的图片
@end
