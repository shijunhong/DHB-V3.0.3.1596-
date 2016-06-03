//
//  DHBSearchBar.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/10/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#define MAEGIN 5.0f
#import "DHBSearchBar.h"

@implementation DHBSearchBar


-(UIImageView *)searchImgView{
    if (!_searchImgView)
    {
        _searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [_searchImgView setImage:[UIImage imageNamed:@"bt2_normal"]];
    }
    return _searchImgView;
}


-(UIImageView *)searchImg{
    if (!_searchImg)
    {
        _searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(MAEGIN, MAEGIN, self.height - 2* MAEGIN, self.height - 2 * MAEGIN)];
        [_searchImg setImage:[UIImage imageNamed:@"search_normal"]];
    }
    return _searchImg;
}


- (UITextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.searchImg.right+5, 0, self.width-60, self.height)];
        [_searchTextField setTintColor: [UIColor TextRed_Color]];
        _searchTextField.placeholder = L(@"搜索");
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.font = [UIFont boldSystemFontOfSize:14.0];
        _searchTextField.textColor = HEX_RGB(0xeaeaea);
        _searchTextField.delegate = self;
        _searchTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _searchTextField.placeholder = @"商品名称/编号/条形码";
        
    }
    return _searchTextField;
}


-(UIButton *)shaoMaImg{
    if (!_shaoMaImg)
    {
        _shaoMaImg = [[UIButton alloc] initWithFrame:CGRectMake(self.searchTextField.right, 3, 18, 17)];
        [_shaoMaImg setImage:[UIImage imageNamed:@"scanning_normal"] forState:UIControlStateNormal];
        [_shaoMaImg setImage:[UIImage imageNamed:@"scanning_focused"] forState:UIControlStateNormal];
    }
    return _shaoMaImg;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        [self setBackgroundColor:HEX_RGB(0xc63700)];
        self.layer.cornerRadius = 5;
//        [self addSubview:self.searchImgView];
        [self addSubview:self.searchImg];
        [self addSubview:self.searchTextField];
//        [self addSubview:self.shaoMaImg];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_searchTextField);
    TT_RELEASE_SAFELY(_searchImgView);
    TT_RELEASE_SAFELY(_searchImg);
}




#pragma mark UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_delegate respondsToSelector:@selector(searchFieldSearchButtonClicked:)])
    {
        [_delegate searchFieldSearchButtonClicked:textField];
    }
    return YES;
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![string isEqualToString: @""])
    {
        if (range.location >= 50) return NO; //只能输入是50位以内
    }
    return YES;
}

@end
