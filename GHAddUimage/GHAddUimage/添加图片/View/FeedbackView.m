//
//  FeedbackView.m
//  parkplus
//
//  Created by Mac on 16/7/12.
//  Copyright © 2016年 yejin. All rights reserved.
//

#import "FeedbackView.h"
#import "ShowImageCollectionViewCell.h"
#import "ShowImage.h"

#define ShowImageCollectionCell @"ShowImageCollectionViewCell"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface FeedbackView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

//@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end

@implementation FeedbackView

- (void)awakeFromNib{
    self.sureBtn.layer.cornerRadius = 4.0;
    self.sureBtn.layer.masksToBounds = YES;
    [self setupImageCollectView];
}

- (void)setupImageCollectView{
    
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.itemSize = CGSizeMake((ScreenW - 10) / 4, (ScreenW - 10) / 4);
    
    self.imageCollectView.delegate = self;
    self.imageCollectView.dataSource = self;
    self.imageCollectView.scrollEnabled = NO;
    [self.imageCollectView registerNib:[UINib nibWithNibName:NSStringFromClass([ShowImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ShowImageCollectionCell];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.iconArr.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShowImageCollectionCell forIndexPath:indexPath];
    cell.indexPath = indexPath;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowImageCollectionViewCell *imageCell = (ShowImageCollectionViewCell *)cell;
    if (indexPath.row < self.iconArr.count) {
        imageCell.indexPath = indexPath;
        __weak typeof(self) weakSelf = self;
        [imageCell setCloseBlock:^(ShowImageCollectionViewCell *imageCell1) {
            NSIndexPath *indexPath1 = [collectionView indexPathForCell:imageCell1];
            [weakSelf.iconArr removeObjectAtIndex:indexPath1.row];
            [collectionView deleteItemsAtIndexPaths:@[indexPath1]];
            [collectionView reloadData];
            weakSelf.countLabel.text = [NSString stringWithFormat:@"%ld/4", (unsigned long)self.iconArr.count];
            
        }];
        [imageCell.icon setImage:self.iconArr[indexPath.row]];
        imageCell.icon.highlighted = NO;
        imageCell.closeBtn.hidden = NO;
        
    }else{
        imageCell.icon.highlighted = YES;
        imageCell.closeBtn.hidden = YES;
    }
    __weak typeof(imageCell) weakCell = imageCell;
    __weak typeof(self) weakSelf = self;
    [imageCell setIconClickBlock:^(NSIndexPath *indexPath2){
        if (indexPath.row != weakSelf.iconArr.count) {
            
            [ShowImage showImageToScreen:weakCell.icon];
            weakCell.icon.highlighted = NO;
            weakCell.closeBtn.hidden = NO;
        }
        if (indexPath.row == weakSelf.iconArr.count) {
            if (self.addImageBlock) {
                self.addImageBlock(weakCell.icon);
            }
            weakCell.closeBtn.hidden = YES;
        }
    }];
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShowImageCollectionViewCell *cell = (ShowImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.icon.highlighted = NO;
    cell.closeBtn.hidden = NO;
}

- (void)setIconArr:(NSMutableArray *)iconArr{
    _iconArr = iconArr;
    
    self.countLabel.text = [NSString stringWithFormat:@"%ld/4", iconArr.count];
    [self.imageCollectView reloadData];
}

+ (instancetype)feedbackView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
