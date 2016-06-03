//
//  DHBShareCollectionViewCell.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/18/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBShareModuleDTO.h"

@interface DHBShareCollectionViewCell : UICollectionViewCell
@property(nonatomic, retain) UIImageView *imageView;
@property(nonatomic, retain) UILabel *nameLabel;

- (void)updateViewWithDTO:(DHBShareModuleDTO *) dto;
@end
