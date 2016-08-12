//
//  OpinionFeedbackViewController.m
//  parkplus
//
//  Created by Mac on 16/7/12.
//  Copyright © 2016年 yejin. All rights reserved.
//

#import "OpinionFeedbackViewController.h"
#import "FeedbackView.h"

// 屏幕尺寸
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define GHFont(fontSize) [UIFont fontWithName:@"Helvetica" size:fontSize]
#define GHColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface OpinionFeedbackViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) UIScrollView *contScrollV;
@property (weak, nonatomic) FeedbackView *feedbackView;
@property (nonatomic, strong)NSMutableArray *iconArr;

@end

@implementation OpinionFeedbackViewController

- (NSMutableArray *)iconArr{
    if (!_iconArr) {
        NSMutableArray *arr = [NSMutableArray array];
        _iconArr = arr;
    }
    return _iconArr;
}

- (UIScrollView *)contScrollV{
    if (!_contScrollV) {
        UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        [self.view addSubview:scrollV];
        _contScrollV = scrollV;
    }
    return _contScrollV;
}

- (FeedbackView *)feedbackView{
    if (!_feedbackView) {
        FeedbackView *feedbackView = [FeedbackView feedbackView];
        feedbackView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
        
        feedbackView.feedbackTextView.myPlaceholder = @"请简要描述您的问题和意见";
        feedbackView.feedbackTextView.myPlaceholderColor = GHColor(191.0, 191.0, 191.0);
        feedbackView.feedbackTextView.font = GHFont(14);
        [self.contScrollV addSubview:feedbackView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        [self.view addGestureRecognizer:tap];
        _feedbackView = feedbackView;
    }
    return _feedbackView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self setContentView];
}

- (void)setContentView{
    __weak typeof(self) weakSelf = self;
    [self.feedbackView setAddImageBlock:^(UIImageView *imageV) {
        UIActionSheet *sheet = nil;
        // 判断是否支持相机
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle: nil otherButtonTitles:@"拍照",@"从相册选择", nil];
        }else {
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
        }
        sheet.tag = 255;
        [sheet showInView:weakSelf.view];
    }];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    // 取消
                    return;
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
            } else {
                return;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    [self.iconArr addObject:image];
    self.feedbackView.iconArr = self.iconArr;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - 监听事件
- (void)tapHandle:(UIGestureRecognizer *)recognizer{
    
    [self.feedbackView.feedbackTextView resignFirstResponder];
}


@end
