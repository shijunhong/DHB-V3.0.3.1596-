//
//  DHBOrderAttachmentViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/12/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBTableViewController.h"
#import "DHBOrderAttachmentService.h"

@interface DHBOrderAttachmentViewController : DHBTableViewController<DHBOrderAttachmentService_Delegate>
@property(nonatomic, retain) DHBOrderAttachmentService *mainService;
@property(nonatomic, assign) BOOL isReturnsOrder; //是否是退货单
@end
