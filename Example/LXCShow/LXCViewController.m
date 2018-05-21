//
//  LXCViewController.m
//  LXCShow
//
//  Created by butterflyXX on 05/11/2018.
//  Copyright (c) 2018 butterflyXX. All rights reserved.
//

#import "LXCViewController.h"
#import "LXCAdvertisingFloatView.h"
#import "LXCRollingView.h"
#import "Masonry.h"
@interface LXCViewController ()

@end

@implementation LXCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    LXCAdvertisingFloatView *adv = [[LXCAdvertisingFloatView alloc] initWithFrame:CGRectZero andImageUrlString:@"http://img.wdjimg.com/image/video/945fa937f0955b31224314a4eeef59b8_0_0.jpeg" andtapImageAction:^{
//        NSLog(@"图片点击");
//    }];
//    [adv show];
    LXCRollingView *rollView = [[LXCRollingView alloc] init];
    [self.view addSubview:rollView];
    [rollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.left.offset(0);
        make.height.equalTo(@200);
    }];
    LXCRollingModel *model1 = [LXCRollingModel new];
    model1.imageUrlString = @"http://wimg.spriteapp.cn/picture/2016/0317/56ea981c857df__82.jpg";
    model1.VideoUrlString = @"http://wvideo.spriteapp.cn/video/2016/0317/56ea981c857df_wpd.mp4";
    model1.timeCount = 10;
    LXCRollingModel *model2 = [LXCRollingModel new];
    model2.imageUrlString = @"http://wimg.spriteapp.cn/picture/2016/0616/57620c1f354ae_31.jpg";
    model2.timeCount = 4;
    LXCRollingModel *model3 = [LXCRollingModel new];
    model3.imageUrlString = @"http://wimg.spriteapp.cn/picture/2016/1203/58425ad2a0c1d_wpd_18_91.jpg";
    model3.timeCount = 4;
    rollView.dataArray = @[model1,model2,model3];
}

@end
