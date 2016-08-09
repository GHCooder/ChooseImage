//
//  ShowImageCollectionViewCell.h
//  parkplus
//
//  Created by Mac on 16/7/27.
//  Copyright © 2016年 yejin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (nonatomic, copy) void(^closeBlock)(NSIndexPath *);
@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, copy) void(^iconClickBlock)(NSIndexPath *);
@end
