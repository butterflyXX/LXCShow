//
//  LXCViewController.m
//  LXCShow
//
//  Created by butterflyXX on 05/11/2018.
//  Copyright (c) 2018 butterflyXX. All rights reserved.
//

#import "LXCViewController.h"
#import "LXCAdvertisingFloatView.h"
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
    LXCAdvertisingFloatView *adv = [[LXCAdvertisingFloatView alloc] initWithFrame:CGRectZero andImageUrlString:@"http://img.wdjimg.com/image/video/945fa937f0955b31224314a4eeef59b8_0_0.jpeg" andtapImageAction:^{
        NSLog(@"图片点击");
    }];
    [adv show];
}

@end
