//
//  DHBHomePageTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/21.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "DHBHomePageTableViewCell.h"
#import "DHBHomePageViewController.h"
#import "DHBMessageWebViewController.h"
#import "DHBGoodsDetailsViewController.h"

@implementation DHBHomePageTableViewCell
#pragma mark - update
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_floorDTO != dto)
    {
        _floorDTO = dto;
    }
    self.indexPath = indexPath;
    //移除旧的视图
    NSArray *viewArray = [self.contentView subviews];
    [viewArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    //获取模板ID
    int floorType = -1;
    if (NotNilAndNull(dto.templateID)) {
        floorType = [dto.templateID intValue];
    }
    NSString *methodName = [NSString stringWithFormat:@"addFloor_%d", floorType];
    SEL selectorMethod = NSSelectorFromString(methodName);
    if ([self respondsToSelector:selectorMethod]) {
        objc_msgSend(self, selectorMethod);
    }
}

#pragma mark - banner滚动视图
- (void)addFloor_1 {
    DHBEightBannerView *bannerView = [[DHBEightBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _floorDTO.hight)];
    bannerView.delegate = self;
    [bannerView updateViewWithDTO:_floorDTO UseingViewBlock:^UIView *(NSObject *obj,int i) {
        ActivityModuleDTO *dto = (ActivityModuleDTO*)obj;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, bannerView.frame.size.width, bannerView.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        [imageView setContentMode: UIViewContentModeScaleAspectFill];
        [imageView.layer setMasksToBounds: YES];
        [imageView sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@", dto.img]] placeholderImage:  [UIImage imageNamed: @"default_banner"]];
        return imageView;
    }];
    [self.contentView addSubview:bannerView];
}

#pragma mark - 首页功能菜单
- (void)addFloor_2 {
    DHBHomeFunctionView *functionView = [[DHBHomeFunctionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _floorDTO.hight)];
    functionView.delegate = self;
    [functionView updateViewWithDTO_Version3: _floorDTO];
    [self.contentView addSubview:functionView];
    
    //顶部划线
    [self initLineisBottom:NO];
    //底部还需要划线
    [self initLineisBottom:YES];
}

#pragma mark - 推荐商品标题
- (void)addFloor_3{
    DHBFloorView *titleView = [[DHBFloorView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _floorDTO.hight)];
    WS(weakSelf);
    [titleView updateViewWithDTO:self.floorDTO callback:^{
        if (weakSelf.delegate && [_delegate respondsToSelector:@selector(homePageTableViewCell_DidGoodsListButtonClick)])
        {
            [weakSelf.delegate homePageTableViewCell_DidGoodsListButtonClick];
        }
    }];
    [self.contentView addSubview: titleView];
}

#pragma mark - 推荐商品列表
- (void)addFloor_5 {
    DHBGoodsViewCell_2 *cell = [[DHBGoodsViewCell_2 alloc] initWithFrame: CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, _floorDTO.hight)];
    [cell setDelegate: self];
    GoodsModuleDTO *goods = (GoodsModuleDTO *)[_floorDTO.moduleList safeObjectAtIndex:[self.indexPath row]];
    [cell updateViewWithProductDTO: goods];
    [cell showShoppingCarButton: NO];
    [self.contentView addSubview: cell];
}

#pragma mark - DHBGoodsViewCellDelegate
- (void)DHBGoodsViewCell:(UITableViewCell *)cell didTouchShoppingCar:(UIButton *)sender GoodsModule:(GoodsModuleDTO *)goods{
}

- (void)DHBGoodsViewCell_didSelectRow:(UITableViewCell *)cell{
    if([_delegate respondsToSelector: @selector(DHBHomePageTableViewCell_didSelectRow:)]){
        [_delegate DHBHomePageTableViewCell_didSelectRow: self];
    }
}

#pragma mark - 首页功能模板Delegate(DHBHomeFunctionViewDelegate)
- (void)functionSelectedDTO:(FunctionDTO*)functionDTO{
    if (_delegate && [_delegate respondsToSelector:@selector(selectHomeFloor:WithModuleDTO:)])
    {
        [_delegate selectHomeFloor:_floorDTO WithModuleDTO:functionDTO];
    }
}

- (void)DHBTableViewCellBeginEditing:(UITableViewCell *)cell{
}

-(void)eightBannerSelectedDTO:(ActivityModuleDTO *)activity{
    DHBHomePageViewController *controller;
    id next = [self nextResponder];
    while (next != nil && controller == nil) {
        next = [next nextResponder];
        if ([next isKindOfClass:[DHBHomePageViewController class]])
        {
            controller = next;
        }
    }
    if ([activity.link isEqualToString:@"notice"])
    {
        DHBMessageWebViewController *messageWeb = [[DHBMessageWebViewController alloc] init];
        messageWeb.ids = activity.item;
        messageWeb.action = @"msgAfficheContent";
        [controller.navigationController pushViewController:messageWeb animated:YES];
    }
    else if ([activity.link isEqualToString:@"goods"])
    {
        DHBGoodsDetailsViewController *goodsDetails = [[DHBGoodsDetailsViewController alloc] init];
        goodsDetails.goodsDetailsService.goods_id = [activity.item integerValue];
        [controller.navigationController pushViewController:goodsDetails animated:YES];
    }
}
@end
