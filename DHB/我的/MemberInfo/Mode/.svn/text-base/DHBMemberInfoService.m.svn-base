//
//  DHBMemberInfoService.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 12/30/15.
//  Copyright © 2015 阿商信息技术有限公司. All rights reserved.
//
#define CELL_HEIGHT1 45.0f
#define CELL_HEIGHT2 60.0f

#import "DHBMemberInfoService.h"

@implementation DHBMemberInfoService
- (NSMutableArray *)floorsArray{
    if(!_floorsArray){
        _floorsArray = [NSMutableArray array];
    }
    return _floorsArray;
}

#pragma mark - 查询数据
- (void)queryData{
    [self insertFirstFloor];//添加第一层
    [self insertFifthFloor];//第五层
    [self insertSecondFloor];//添加第二层
    [self insertThirdFloor];//添加第三层
    [self insertFourthFloor];//添加第四层
    
    if ([_delegate respondsToSelector:@selector(memberInfoService_Complete:isSuccess:)]) {
        [_delegate memberInfoService_Complete:self isSuccess:YES];
    }
}

- (void)insertFirstFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"账号";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.memberDTO];
    floorDTO.hight = CELL_HEIGHT1;
    floorDTO.templateID = @"1";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertSecondFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"姓名";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.memberDTO];
    floorDTO.hight = CELL_HEIGHT2;
    floorDTO.templateID = @"2";
    floorDTO.orderNO = @"1";
    floorDTO.sectionHeight = DEFAULT_SECTION_HEIGHT;
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertThirdFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"电话";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.memberDTO];
    floorDTO.hight = CELL_HEIGHT2;
    floorDTO.templateID = @"2";
    floorDTO.orderNO = @"2";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertFourthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"邮箱";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.memberDTO];
    floorDTO.hight = CELL_HEIGHT2;
    floorDTO.templateID = @"2";
    floorDTO.orderNO = @"3";
    floorDTO.floors =1;
    [self.floorsArray addObject:floorDTO];
}

- (void)insertFifthFloor{
    HomeFloorDTO *floorDTO= [[HomeFloorDTO alloc] init];
    floorDTO.floorName = @"修改密码";
    floorDTO.moduleList =[NSMutableArray arrayWithObject: self.memberDTO];
    floorDTO.hight = CELL_HEIGHT1;
    floorDTO.templateID = @"3";
    floorDTO.floors =1;
    floorDTO.sectionHeight = 0.0f;
    [self.floorsArray addObject:floorDTO];
}

#pragma mark - 修改个人资料
- (void)submitMemberInfoData{
    
    DHBMemberInfoRequest *request = [[DHBMemberInfoRequest alloc] init];
    request.memberInfo = self.memberDTO;
    [request postDataSuccess:^(DHBBaseNetworkRequest *DAO, id data) {
        NSDictionary *dic = (NSDictionary*)data;
        BOOL isSuccess = ([[dic objectForKey:@"code"] intValue] ==100 ? YES :NO);
        if(isSuccess){
            isSuccess = [[[dic objectForKey:@"data"] objectForKey:@"is_success"] integerValue] == 0 ? NO : YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([_delegate respondsToSelector:@selector(memberInfoService_ModifyMemberInfoResult:)]) {
                [_delegate memberInfoService_ModifyMemberInfoResult: isSuccess];
            }
        });
    } failure:^(DHBBaseNetworkRequest *DAO, NSError *error) {
        NSLog_Red(@"error=%@",error.userInfo[NSLocalizedDescriptionKey]);
        self.error = error;
        if ([_delegate respondsToSelector:@selector(memberInfoService_ModifyMemberInfoResult:)]) {
            [_delegate memberInfoService_ModifyMemberInfoResult: NO];
        }
    }];
}
@end
