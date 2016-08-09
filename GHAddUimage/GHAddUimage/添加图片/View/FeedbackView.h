//
//  FeedbackView.h
//  parkplus
//
//  Created by Mac on 16/7/12.
//  Copyright © 2016年 yejin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlacehodeTextView.h"


@interface FeedbackView : UIView

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet PlacehodeTextView *feedbackTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectView;

@property (nonatomic, strong)NSMutableArray *iconArr;

@property (nonatomic, copy) void(^addImageBlock)(UIImageView *);

+ (instancetype)feedbackView;

@end
