//
//  LXCCollectionViewCell.h
//  LXCRollingView_Example
//
//  Created by 刘晓晨 on 2018/5/9.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXCRollingModel.h"
#import "LXCPlayerView.h"

@interface LXCCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)LXCRollingModel *cellModel;

-(void)addPlayer:(LXCPlayerView *)player;

@end
