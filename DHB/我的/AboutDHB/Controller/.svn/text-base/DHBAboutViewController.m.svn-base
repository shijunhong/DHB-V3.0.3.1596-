//
//  DHBAboutViewController.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/13/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//
#define BOTTOM_HEIGHT 60.0F

#import "DHBAboutViewController.h"
@implementation DHBAboutViewController

#pragma mark - init
- (DHBShareView *)shareMainView{
    if(!_shareMainView){
        _shareMainView = [[DHBShareView alloc] init];
        [_shareMainView setDelegate: self];
    }
    return _shareMainView;
}

- (DHBAboutService *)mainService{
    if(!_mainService){
        _mainService = [[DHBAboutService alloc] init];
        [_mainService setDelegate: self];
    }
    return _mainService;
}

- (DHBAboutBottomView *)bottomView{
    if(!_bottomView){
        _bottomView = [[DHBAboutBottomView alloc] initWithFrame: CGRectMake(0.0f, SCREEN_HEIGHT - BOTTOM_HEIGHT - Titel_HEIGHT, SCREEN_WIDTH, BOTTOM_HEIGHT)];
    }
    return _bottomView;
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack: YES];
    [self showTabBar: NO];
    [self showTitel: YES andTitelText: @"关于订货宝"];
    ///
    [self.tableView setFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT - Titel_HEIGHT - BOTTOM_HEIGHT)];
    [self.tableView setSeparatorColor: HEX_RGB(0xe4e4e4)];
    if([self.tableView respondsToSelector: @selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector: @selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset: UIEdgeInsetsZero];
    }
    ///
    [self.mainService queryData];
    //
    [self.view addSubview: self.bottomView];
}

#pragma mark - DHBAboutService_Delegate
- (void)aboutService_Complete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        self.mainService = service;
        [self.bottomView updateViewWithDTO: [self.mainService aboutDTO]];
        [self.tableView reloadData];
    }
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mainService floorsArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DHBAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ListCell"];
    if(!cell){
        cell = [[DHBAboutTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"ListCell"];
    }
    HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: [indexPath row]];
    [cell updateViewWithFloorDTO: dto];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: [indexPath row]];
    return [dto hight];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([cell respondsToSelector: @selector(setLayoutMargins:)]){
        [cell setLayoutMargins: UIEdgeInsetsZero];
    }
    if([cell respondsToSelector: @selector(setSeparatorInset:)]){
        [cell setSeparatorInset: UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeFloorDTO *dto = [self.mainService.floorsArray objectAtIndex: [indexPath row]];
    if ([dto.floorName isEqualToString:@"推荐好友使用"])
    {
        [self.mainService queryShareData];
    }
    else if([dto.floorName isEqualToString: @"当前版本"])
    {
//        NSString *webUrl = @"itms-apps://itunes.apple.com/us/app/ding-huo-bao+/id1091471537?l=zh&ls=1&mt=8";
//        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: webUrl]];
    }
    else if([dto.floorName isEqualToString: @"查看官网"])
    {
        NSString *webUrl = ([[self.mainService.aboutDTO mobile_website_url] length] > 0 ? [self.mainService.aboutDTO mobile_website_url] : @"http://www.dhb.hk");
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: webUrl]];
    }
}

#pragma mark - DHBShareView_Delegate
- (void)shareView_DidSelectShareDTO:(DHBShareModuleDTO *)dto{
    NSString *type = @"";
    if([[dto name] isEqualToString: @"微博"]){
        type = UMShareToSina;
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url: [self.mainService.shareInfoDTO share_picture]];
        [UMSocialSnsService presentSnsController:self
                                             appKey: UMengKEY
                                          shareText: [self.mainService.shareInfoDTO share_title]
                                         shareImage: nil
                                    shareToSnsNames:@[UMShareToSina]
                                           delegate: nil];
    }
    else{
        UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url: [self.mainService.shareInfoDTO share_picture]];
        if([[dto name] isEqualToString: @"微信好友"]){
            type = UMShareToWechatSession;
            ///设置点击分享内容跳转链接
            [UMSocialData defaultData].extConfig.wechatSessionData.url = [self.mainService.shareInfoDTO share_url];
            [UMSocialData defaultData].extConfig.wechatSessionData.title = [self.mainService.shareInfoDTO share_title];
        }
        else if([[dto name] isEqualToString: @"朋友圈"]){
            type = UMShareToWechatTimeline;
            ///设置点击分享内容跳转链接
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = [self.mainService.shareInfoDTO share_url];
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = [self.mainService.shareInfoDTO share_title];
        }
        else if([[dto name] isEqualToString: @"QQ好友"]){
            type = UMShareToQQ;
            [UMSocialData defaultData].extConfig.qqData.url = [self.mainService.shareInfoDTO share_url];
            [UMSocialData defaultData].extConfig.qqData.title = [self.mainService.shareInfoDTO share_title];
        }
        else if([[dto name] isEqualToString: @"QQ空间"]){
            type = UMShareToQzone;
            [UMSocialData defaultData].extConfig.qzoneData.url = [self.mainService.shareInfoDTO share_url];
            [UMSocialData defaultData].extConfig.qzoneData.title = [self.mainService.shareInfoDTO share_title];
        }
        //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[type] content: [self.mainService.shareInfoDTO share_content] image: nil location:nil urlResource: urlResource presentedController: self completion:^(UMSocialResponseEntity *response){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"温馨提示" message: @"" delegate: nil cancelButtonTitle: @"确定" otherButtonTitles: nil];
            if (response.responseCode == UMSResponseCodeSuccess) {
                [alertView setMessage: @"分享成功!"];
                [alertView show];
            }
            else if(response.responseCode == UMSResponseCodeFaild){
                [alertView setMessage: @"分享失败!"];
                [alertView show];
            }
        }];
    }
}

#pragma mark - 实现分享的回调方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode == UMSResponseCodeSuccess){
    }
}

#pragma mark - 获取分享的信息
- (void)aboutService_ShareInfoComplete:(id)service isSuccess:(BOOL)isSuccess{
    if(isSuccess){
        [self.shareMainView show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
