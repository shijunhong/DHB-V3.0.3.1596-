//
//  DHBShareView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/18/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHBShareCollectionViewCell.h"
#import "DHBShareModuleDTO.h"

@protocol DHBShareView_Delegate <NSObject>
- (void)shareView_DidSelectShareDTO:(DHBShareModuleDTO *) dto;
@end

@interface DHBShareView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, retain) NSMutableArray *shareDataArray;
@property(nonatomic, retain) UIView *mainView;
@property(nonatomic, retain) UICollectionView *shareView;
@property(nonatomic, retain) DHBButton *cancelButton;
@property(nonatomic, assign) id<DHBShareView_Delegate> delegate;

- (void)show;
- (void)dismiss;
@end
