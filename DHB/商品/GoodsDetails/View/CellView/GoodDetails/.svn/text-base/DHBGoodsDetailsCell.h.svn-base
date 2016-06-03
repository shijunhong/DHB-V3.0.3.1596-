//
//  DHBProductDetailsCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/11/6.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBEightBannerView.h"
#import "HomeFloorDTO.h"
#import "DHBGoodsDetailsCell.h"
#import "GoodsModuleDTO.h"

@protocol DHBGoodsDetailsCellDelegate <DHBTableCellDelegate>

-(void)selectMulti:(NSString*)multiId;

-(void)selectGoods:(GoodsModuleDTO*)goods;

//-(void)DHBGoodsDetailsCell_textFieldShouldBeginEditing:(UITextField *)textField;
@end

@interface DHBGoodsDetailsCell : UITableViewCell<EGOImageViewDelegate>

@property (nonatomic, strong) HomeFloorDTO *floorDTO;
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) id <DHBGoodsDetailsCellDelegate>  delegate;

@property (weak, nonatomic) IBOutlet UIImageView *activity_img;
@property (weak, nonatomic) IBOutlet UILabel *describe_lb;
@property (nonatomic ,strong)UIWebView *webView;

@end
