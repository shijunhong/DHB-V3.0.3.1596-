//
//  ReturnedSubmitViewController.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/25.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCommonViewController.h"
#import "ReturnedSubmitService.h"
@interface ReturnedSubmitViewController : DHBCommonViewController
{
    id firstResposer;
}
@property(nonatomic,strong)ReturnedSubmitService *service;
@end
