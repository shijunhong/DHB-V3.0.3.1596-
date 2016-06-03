//
//  DHBPaymentRecordDetailsTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/27/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "DHBPaymentRecordModuleDTO.h"
//@protocol DHBPaymentRecordDetailsTableViewCell_Delegate <NSObject>
//-(void)DHBPaymentRecordDetailsTableViewCell_imageLoaded:(UITableViewCell *) cell;
//@end

@interface DHBPaymentRecordDetailsTableViewCell : UITableViewCell<EGOImageViewDelegate>
@property(nonatomic, strong) EGOImageView *voucherImageView;

@property(nonatomic, retain) HomeFloorDTO *floorDTO;
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;
@end
