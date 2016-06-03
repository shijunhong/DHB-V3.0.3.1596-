//
//  DHBDepositPayView.h
//  DHB
//
//  Created by 阿商信息技术有限公司 on 16/3/4.
//  Copyright © 2016年 阿商信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DHBDepositPayView_Delegate <NSObject>
- (void)DHBDepositPayView_PayButtonClick:(UIButton *)sender payValue:(NSString *) payValue;
@end

@interface DHBDepositPayView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UILabel *type_lb;
@property (nonatomic,strong)DHBButton *depositPay_btn;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *data_arr;
@property(nonatomic, assign) id<DHBDepositPayView_Delegate> delegate;

-(void)updateData:(NSMutableArray *)arr;
@end
