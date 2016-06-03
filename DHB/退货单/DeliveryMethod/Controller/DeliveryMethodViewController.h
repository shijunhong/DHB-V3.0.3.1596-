//
//  DeliveryMethodViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/29/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DeliveryBaseTableViewCell.h"
#import "DHBDeliveryService.h"
#import "DHBDeliveryMethodMoudleDTO.h"

typedef enum{
    kAddDeliveryMode_type = 0,
    kEditDeliveryMode_type
}DeliveryMode_Type;

@interface DeliveryMethodViewController : DHBTableViewController<DHBDeliveryServiceDelegate, DeliveryBaseTableViewCell_Delegate>
{
    CGFloat datePicker_height;
}

@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) DHBDeliveryService *mainService;
@property(nonatomic, strong) UIButton *compeleteButton;
@property(nonatomic, strong) NSString *returns_id; //退货单编号
@property(nonatomic, strong) DHBDeliveryMethodMoudleDTO *deliveryMethodDTO;
@property(nonatomic, retain) UITextField *sendTimeTextField;
@property(nonatomic, retain) UITextField *sendCompanyTextField;
@property(nonatomic, retain) UITextField *sendNOTextField;

@property(nonatomic,assign)BOOL keyboard_isShow;

@property(nonatomic, assign) DeliveryMode_Type operationMode;
@end
