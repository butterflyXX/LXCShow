//
//  LXCCollectionViewFlowLayout.m
//  LXCRollingView_Example
//
//  Created by 刘晓晨 on 2018/5/9.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "LXCCollectionViewFlowLayout.h"

@implementation LXCCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}


@end
