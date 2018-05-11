//
//  LXCPlayerView.h
//  LXCRollingView_Example
//
//  Created by 刘晓晨 on 2018/5/10.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXCPlayerView : UIView

@property (nonatomic,copy)NSString *urlString;

- (void)destroyPlayer;

@end
