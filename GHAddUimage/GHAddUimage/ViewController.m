//
//  ViewController.m
//  GHAddUimage
//
//  Created by apple on 15/1/2.
//  Copyright © 2015年 yejin. All rights reserved.
//

#import "ViewController.h"
#import "OpinionFeedbackViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addImageBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.addImageBtn addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>
    
    OpinionFeedbackViewController *opinionF = [[OpinionFeedbackViewController alloc] init];
    opinionF.view.frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:opinionF.view];
}



@end
