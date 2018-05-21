//
//  LXCCollectionViewCell.m
//  LXCRollingView_Example
//
//  Created by 刘晓晨 on 2018/5/9.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "LXCCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"


@interface LXCCollectionViewCell ()
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation LXCCollectionViewCell

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
    self.imageView = [UIImageView new];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
}

-(void)setCellModel:(LXCRollingModel *)cellModel {
    _cellModel = cellModel;
    NSURL *url = [NSURL URLWithString:cellModel.imageUrlString];
    [self.imageView sd_setImageWithURL:url];
}

-(void)addPlayer:(LXCPlayerView *)player {
    if (self.cellModel.VideoUrlString) {
        [self.contentView addSubview:player];
        [player mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        player.urlString = self.cellModel.VideoUrlString;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//        });
        
    }
}
@end
