//
//  LXCCollectionView.m
//  LXCRollingView_Example
//
//  Created by 刘晓晨 on 2018/5/9.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "LXCCollectionView.h"

@implementation LXCCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    [self setupUI];
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setupUI];
    return self;
}
-(void)setupUI {
    self.scrollEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
}

@end
