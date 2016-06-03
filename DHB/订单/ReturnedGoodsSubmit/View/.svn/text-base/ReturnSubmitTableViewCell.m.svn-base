//
//  ReturnSubmitTableViewCell.m
//  DHB
//
//  Created by 阿商信息技术有限公司 on 15/12/28.
//  Copyright © 2015年 阿商信息技术有限公司. All rights reserved.
//

#import "ReturnSubmitTableViewCell.h"
#import "DHBUploadImage.h"
@implementation ReturnSubmitTableViewCell

- (NSMutableArray *)imageViewsArray{
    if(!_imageViewsArray){
        _imageViewsArray = [NSMutableArray array];
    }
    return _imageViewsArray;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)addImgAction:(UIButton *)sender {
    [self.delegate selectaddImgReturnSubmitTableViewCell:self];
}

-(void)updateCellData:(NSMutableArray*)img_arr{
    TT_RELEASE_SAFELY(self.img_arr);
    self.img_arr = img_arr;
    self.mark_lb.delegate = self;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.mark_lb.leftView = paddingView;
    self.mark_lb.leftViewMode = UITextFieldViewModeAlways;
    
    [self.images_vi removeAllSubviews];
    
    ///根据屏幕宽度计算视图的大小
    CGFloat size_w = (SCREEN_WIDTH - 90.0f) / 5.0f;
    UIView *addImg_vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size_w, size_w)];
    [self.images_vi addSubview:addImg_vi];
    UIButton *addbtn = [[UIButton alloc] initWithFrame:addImg_vi.frame];
    [addbtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addbtn addTarget:self action:@selector(addImgAction:) forControlEvents:UIControlEventTouchUpInside];
    [addImg_vi addSubview:addbtn];
    
    ////
    [self.imageViewsArray removeAllObjects];
    self.imageViewsArray = [NSMutableArray arrayWithCapacity: [img_arr count]];
    for (int i =0; i<[img_arr count] && i<4; i++)
    {
        DHBUploadImage *image = [img_arr safeObjectAtIndex:i];
        DHBUploadImageView *uploadImageView = [[DHBUploadImageView alloc] initWithFrame: CGRectMake(addImg_vi.right+10+(size_w + 15.0f)*i, addImg_vi.top, addImg_vi.width, addImg_vi.height)];
        [uploadImageView setDelegate: self];
        [uploadImageView UpdateView: image];
        [uploadImageView setTag: i];
        [self.images_vi insertSubview: uploadImageView belowSubview: ([self.imageViewsArray count] > 0 ? [self.imageViewsArray lastObject] : self.images_vi)];
        [self.imageViewsArray insertObject: uploadImageView atIndex: i];
    }
    
    if ([img_arr count] ==5)
    {
        DHBUploadImage *image = [img_arr safeObjectAtIndex:[img_arr count]-1];
        DHBUploadImageView * image_vi = [[DHBUploadImageView alloc] initWithFrame:addImg_vi.frame];
        [image_vi setDelegate: self];
        [image_vi UpdateView: image];
        [image_vi setTag: 4];
        [image_vi setBackgroundColor: [UIColor whiteColor]];
        [self.images_vi addSubview:image_vi];
        
//        UIImageView * image_vi = [[UIImageView alloc] initWithFrame:addImg_vi.frame];
//        [image_vi setImage:[UIImage imageWithData:image.image]];
//        image_vi.layer.borderWidth = 0.5;
//        image_vi.layer.cornerRadius = 2.5;
//        image_vi.layer.borderColor = [UIColor BtnBorder_Color].CGColor;
//        image_vi.layer.masksToBounds = YES;
//        [self.images_vi addSubview:image_vi];
//        UIButton *badge_btn = [[UIButton alloc] initWithFrame:CGRectMake(image_vi.frame.origin.x+image_vi.frame.size.width-80/2, image_vi.frame.origin.y-80/2, 80, 80)];
//        badge_btn.tag = 4;
//        [badge_btn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//        [badge_btn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.images_vi addSubview:badge_btn];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location<300)
    {
        self.textNum_lb.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)range.location];
        return YES;
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.mark_lb resignFirstResponder];
    [self.delegate returnSubmitTableViewCell:self textmark:self.mark_lb.text];
    return YES;
}

//-(void)longPressToDo:(UILongPressGestureRecognizer *)tapRecognizer {
//    if ([tapRecognizer.view isKindOfClass:[UIImageView class]])
//    {
//        UIImageView *image_vi = (UIImageView*)tapRecognizer.view;
//        image_vi.userInteractionEnabled = NO;
//        tapRecognizer.enabled = NO;
//        NSLog_Red(@"image = %@",image_vi.image);
//    }
//}


-(void)DHBUploadImageView_CancelButtonClick:(UIButton *)sender{
    [self.img_arr removeObjectAtIndex:sender.tag];
    [self.delegate deleteImgReturnSubmitTableViewCell:self];
}
@end
