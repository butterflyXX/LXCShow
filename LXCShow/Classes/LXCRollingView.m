//
//  LXCRollingView.m
//  LXCRollingView_Example
//
//  Created by 刘晓晨 on 2018/5/9.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "LXCRollingView.h"
#import "Masonry.h"
#import "LXCCollectionView.h"
#import "LXCCollectionViewFlowLayout.h"
#import "LXCCollectionViewCell.h"
#import "LXCPlayerView.h"


@interface LXCRollingView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)LXCCollectionView *collctionView;
@property (nonatomic,strong)LXCPlayerView *playerView;
@end

@implementation LXCRollingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupUI];
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setupUI];
    return self;
}

-(void)setupUI {
    self.playerView = [LXCPlayerView new];
    self.backgroundColor = [UIColor whiteColor];
    LXCCollectionViewFlowLayout *layout = [[LXCCollectionViewFlowLayout alloc] init];
    self.collctionView = [[LXCCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collctionView.dataSource = self;
    self.collctionView.delegate = self;
    self.collctionView.pagingEnabled = YES;
    [self.collctionView registerClass:[LXCCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self addSubview:self.collctionView];
    [self.collctionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

-(void)setDataArray:(NSArray<LXCRollingModel *> *)dataArray {
    _dataArray = dataArray;
    [self.collctionView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LXCCollectionViewCell *cell = (LXCCollectionViewCell *)[self.collctionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        [cell addPlayer:self.playerView];
        NSTimer *timer = [NSTimer timerWithTimeInterval:dataArray[0].timeCount repeats:NO block:^(NSTimer * _Nonnull timer) {
            [timer invalidate];
            timer = nil;
            CGFloat currentOffSetX = self.collctionView.contentOffset.x/self.bounds.size.width;
            [self.collctionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentOffSetX + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//            [self.collctionView layoutIfNeeded];
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    });
    
}

#pragma marks - UICollectionViewDelegate,UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count * 2;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LXCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:indexPath.row/20.0 alpha:1];
    cell.cellModel = self.dataArray[indexPath.row % self.dataArray.count];
    return cell;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    CGFloat offX = scrollView.contentOffset.x;
    int index = (int)(offX/self.bounds.size.width);
    
    
    if (offX >= self.dataArray.count * self.bounds.size.width) {
        scrollView.contentOffset = CGPointMake(0, 0);
        index = 0;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LXCCollectionViewCell *currentCell = (LXCCollectionViewCell *)[self.collctionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [self.playerView destroyPlayer];
        [currentCell addPlayer:self.playerView];
        NSTimer *timer = [NSTimer timerWithTimeInterval:self.dataArray[index % self.dataArray.count].timeCount repeats:NO block:^(NSTimer * _Nonnull timer) {
            [timer invalidate];
            timer = nil;
            CGFloat currentOffSetX = self.collctionView.contentOffset.x/self.bounds.size.width;
            [self.collctionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentOffSetX + 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
//            [self.collctionView layoutIfNeeded];
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    });
    
    
}

@end









