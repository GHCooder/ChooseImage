//
//  showImage.h
//  test
//
//  Created by zhimoreMac on 16/7/5.
//  Copyright © 2016年 yeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShowImage : NSObject

+ (void)showImage:(UIImageView *)avatarImageView;
+ (void)showImageToScreen:(UIImageView *)avatarImageView;

+ (void)hideImage:(UIImageView *)avatarImageView;
+ (void)hideImageFromScreen:(UITapGestureRecognizer*)tap;
@end
