//
//  ShowImageCollectionViewCell.m
//  parkplus
//
//  Created by Mac on 16/7/27.
//  Copyright © 2016年 yejin. All rights reserved.
//

#import "ShowImageCollectionViewCell.h"

@interface ShowImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@end

@implementation ShowImageCollectionViewCell

- (void)awakeFromNib {
    self.icon.highlighted = YES;
    self.closeBtn.hidden = YES;
    [self.closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchDown];
    
    [self.iconBtn addTarget:self action:@selector(iconBtnClick) forControlEvents:UIControlEventTouchDown];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
    [self.icon addGestureRecognizer:tap];
}

- (void)closeBtnClick{
//    [NSNotificationCenter defaultCenter] pos
    if (self.closeBlock) {
        self.closeBlock(self.indexPath);
    }
}

- (void)iconBtnClick{
    if (self.iconClickBlock) {
        self.iconClickBlock(self.indexPath);
    }
}

- (void)tapHandle{
    
}

@end
