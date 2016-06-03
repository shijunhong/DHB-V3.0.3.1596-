//
//  DHBOptionTableViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/2.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "GoodsNumberView.h"
@protocol DHBOptionTableViewCellDelegate <NSObject>

-(void)selectMulti:(NSString*)multiId;

@end

@interface DHBOptionTableViewCell : UITableViewCell<EGOImageViewDelegate,GoodsNumberViewDelegate>

@property (nonatomic, strong) HomeFloorDTO *floorDTO;
- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id <DHBOptionTableViewCellDelegate> delegate;

@end
