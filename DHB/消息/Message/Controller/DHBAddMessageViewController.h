//
//  DHBAddMessageViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/1/8.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "DHBAddMessageService.h"

@interface DHBAddMessageViewController : DHBCommonViewController<DHBAddMessageService_Delegate>
@property(nonatomic, retain) DHBAddMessageService *mainService;
@property(nonatomic, retain) NSString *titleStr;
@property(nonatomic, assign) BOOL is_feedback; ////是否是系统建议与反馈（YES:是系统建议与反馈，NO:不是）
@end
