//
//  DHBCorporateFinancialFooterView.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 1/6/16.
//  Copyright © 2016 阿商信息技术有限公司. All rights reserved.
//

#import "DHBCorporateFinancialFooterView.h"

@implementation DHBCorporateFinancialFooterView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if(self){
        [self setBackgroundColor: [UIColor UIViewBackGroundColor]];
        ///
        UILabel *contentLabel = [[UILabel alloc] initWithFrame: CGRectMake(10.0f, 5.0f, self.size.width - 20.0f, self.size.height / 2.0f)];
        [contentLabel setText: @"说明：请填写正确的财务信息，以便您的合作伙伴为您开具增值税发票"];
        [contentLabel setNumberOfLines: 2];
        [contentLabel setLineBreakMode: NSLineBreakByTruncatingTail];
        [contentLabel setFont: [UIFont systemFontOfSize: 14.0f]];
        [contentLabel setTextColor: [UIColor TextGray_Color]];
        [self addSubview: contentLabel];
    }
    return self;
}
@end
