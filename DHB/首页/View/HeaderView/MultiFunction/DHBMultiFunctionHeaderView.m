//
//  DHBMultiFunctionHeaderView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/24.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//
#define CATEGORY_WIDTH 75.0f
#define CATEGORY_ICON_MARGIN_LEFT 15.0f
#define CATEGORY_ICON_MARGIN_TOP 18.0f
#define CATEGORY_LABEL_MARGIN 5.0f
#define SEARCH_MARGIN_LEFT 15.0f
#define SEARCH_MARGIN_TOP 10.0f
#define SEARCH_MARGIN_RIGHT 15.0f
#define QR_MARGIN 5.0f
#import "DHBMultiFunctionHeaderView.h"

@implementation DHBMultiFunctionHeaderView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self addCategoryView];
        [self addSearchView];
    }
    return self;
}

#pragma mark -
- (void)addCategoryView{
    if(!_categoryView){
        _categoryView = [[UIView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, CATEGORY_WIDTH,   self.frame.size.height)];
        [_categoryView setBackgroundColor: [UIColor clearColor]];
        [self addSubview: _categoryView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(categoryButtonClick)];
        [_categoryView addGestureRecognizer: tap];
        ///分类图标
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(CATEGORY_ICON_MARGIN_LEFT, CATEGORY_ICON_MARGIN_TOP, self.frame.size.height - 2 * CATEGORY_ICON_MARGIN_TOP, self.frame.size.height - 2 * CATEGORY_ICON_MARGIN_TOP)];
        [imageView setContentMode: UIViewContentModeScaleAspectFit];
        [imageView setImage: [UIImage imageNamed: @"hp_category"]];
        [_categoryView addSubview: imageView];
        ///文字
        CGFloat origin_x = imageView.frame.size.width + imageView.frame.origin.x + CATEGORY_LABEL_MARGIN;
        UILabel *tmpLabel = [[UILabel alloc] initWithFrame: CGRectMake(origin_x, 0.0f, _categoryView.frame.size.width - origin_x, _categoryView.frame.size.height)];
        [tmpLabel setText: @"分类"];
        [tmpLabel setFont: [UIFont systemFontOfSize: 15.0f]];
        [tmpLabel setTextColor: [UIColor TextGray_Color]];
        [_categoryView addSubview: tmpLabel];
    }
    [self addSubview: _categoryView];
}

- (void)addSearchView{
    if(!_searchView){
        CGFloat origin_x = _categoryView.frame.size.width + _categoryView.frame.origin.x + SEARCH_MARGIN_LEFT;
        _searchView = [[UIView alloc] initWithFrame: CGRectMake(origin_x, SEARCH_MARGIN_TOP, self.frame.size.width - origin_x - SEARCH_MARGIN_RIGHT, self.frame.size.height - 2 * SEARCH_MARGIN_TOP)];
        [_searchView setBackgroundColor: [UIColor whiteColor]];
        [_searchView.layer setCornerRadius: 5.0f];
        ///搜索按钮
        UIButton *searchButton = [[UIButton alloc] initWithFrame: CGRectMake(5.0f, 5.0f, _searchView.frame.size.height - 10.0f, _searchView.frame.size.height - 10.0f)];
        [searchButton setImage: [UIImage imageNamed:@"hp_search"] forState: UIControlStateNormal];
        [searchButton addTarget: self action: @selector(searchButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [_searchView addSubview: searchButton];
        ///输入框
        origin_x = searchButton.frame.size.width + searchButton.frame.origin.x + 5.0f;
        UITextField *searchTextFiled = [[UITextField alloc] initWithFrame: CGRectMake(origin_x, 0.0f, _searchView.frame.size.width - origin_x - (_searchView.frame.size.height - 2 * QR_MARGIN) - 2 * QR_MARGIN, _searchView.frame.size.height)];
//        [searchTextFiled setAttributedPlaceholder: [[NSAttributedString alloc] initWithString: @"搜索商品名称/首字母/条形码/编码" attributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize: 13.0f]}]];
        [searchTextFiled setPlaceholder: @"商品名称/编号/条形码"];
        [searchTextFiled setFont: [UIFont systemFontOfSize: 13.0f]];
        [searchTextFiled setTintColor: [UIColor TextRed_Color]];
        [searchTextFiled setDelegate: self];
        [_searchView addSubview: searchTextFiled];
        ///扫描按钮
        origin_x = searchTextFiled.frame.size.width + searchTextFiled.frame.origin.x + 5.0f;
        UIButton *scanButton = [[UIButton alloc] initWithFrame: CGRectMake(origin_x, 5.0f, _searchView.frame.size.height - 10.0f, _searchView.frame.size.height - 10.0f)];
        [scanButton setImage: [UIImage imageNamed:@"hp_sm"] forState: UIControlStateNormal];
        [scanButton addTarget: self action: @selector(scanButtonClick:) forControlEvents: UIControlEventTouchUpInside];
        [_searchView addSubview: scanButton];
    }
    [self addSubview: _searchView];
}

- (void)searchButtonClick:(UIButton *) sender{
    if([_delegate respondsToSelector: @selector(multiFunctionHeaderView_DidSearchButtonClick:)]){
        [_delegate multiFunctionHeaderView_DidSearchButtonClick: sender];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([_delegate respondsToSelector: @selector(multiFunctionHeaderView_TextFieldDidBeginEditing:)]){
        [_delegate multiFunctionHeaderView_TextFieldDidBeginEditing: textField];
    }
    [textField resignFirstResponder];
}

- (void)scanButtonClick:(UIButton *) sender{
    if([_delegate respondsToSelector: @selector(multiFunctionHeaderView_DidScanButtonClick:)]){
        [_delegate multiFunctionHeaderView_DidScanButtonClick: sender];
    }
}

- (void)categoryButtonClick{
    if([_delegate respondsToSelector: @selector(multiFunctionHeaderView_DidCatgoryButtonClick)]){
        [_delegate multiFunctionHeaderView_DidCatgoryButtonClick];
    }
}
@end
