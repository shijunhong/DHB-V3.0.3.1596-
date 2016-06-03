//
//  DHBSearchBar.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DHBSearchBarDelegate;

@interface DHBSearchBar : UIView<UITextFieldDelegate>
@property (weak,nonatomic) id<DHBSearchBarDelegate> delegate;
@property (nonatomic, strong) UITextField   *searchTextField;
@property (nonatomic, strong) UIImageView   *searchImgView;
@property (nonatomic, strong) UIImageView   *searchImg;
@property (nonatomic, strong) UIButton      *shaoMaImg;
@end


@protocol DHBSearchBarDelegate <NSObject>

- (void)searchFieldSearchButtonClicked:(UITextField *)searchField;

@end