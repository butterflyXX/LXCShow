//
//  LXCAdvertisingFloatView.h
//  LXCRollingView_Example
//
//  Created by 刘晓晨 on 2018/5/10.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void((^LXCImageAction)(void));
@interface LXCAdvertisingFloatView : UIView
- (instancetype)initWithFrame:(CGRect)frame andImageUrlString:(NSString *)imageUrlString andtapImageAction:(LXCImageAction)block;
-(void)show;
@end
