//
//  LXCAdvertisingFloatView.m
//  LXCRollingView_Example
//
//  Created by 刘晓晨 on 2018/5/10.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "LXCAdvertisingFloatView.h"
#import <Masonry/Masonry.h>

@interface LXCAdvertisingFloatView ()

@property (nonatomic,strong)UIView *backShadowView;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UIButton *cancelButton;

@property (nonatomic,copy)LXCImageAction actionBlock;

@property (nonatomic,copy)NSString *imageUrlString;




@end

@implementation LXCAdvertisingFloatView

- (instancetype)initWithFrame:(CGRect)frame andImageUrlString:(NSString *)imageUrlString andtapImageAction:(LXCImageAction)block {
    self = [super initWithFrame:frame];
    self.actionBlock = block;
    self.imageUrlString = imageUrlString;
    [self setupUI];
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setupUI];
    return self;
}
-(void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0;
    [self addSubview:self.backShadowView];
    [self addSubview:self.imageView];
    [self addSubview:self.cancelButton];
    
    //MARK:自动布局
    [self.backShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageView).offset(70);
        make.centerX.equalTo(self.imageView);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    if (self.imageUrlString) {
        NSURL *imageUrl = [NSURL URLWithString:self.imageUrlString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        UIImage *image = [UIImage imageWithData:imageData];
        self.imageView.image = image;
    }
    
}

-(void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        [self layoutIfNeeded];
    }];
    
}

#pragma marks - 点击图片
-(void)tapAction {
    if (self.actionBlock) {
        self.actionBlock();
    }
    
}

#pragma marks - 查查点击
-(void)cancelButtonAction {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma marks - 懒加载
-(UIView *)backShadowView {
    if (!_backShadowView) {
        self.backShadowView = [[UIView alloc]init];
        self.backShadowView.backgroundColor = [UIColor blackColor];
        self.backShadowView.alpha = 0.5;
    }
    return _backShadowView;
}
-(UIImageView *)imageView {
    if (!_imageView) {
        self.imageView = [[UIImageView alloc]init];
        self.imageView.backgroundColor = [UIColor whiteColor];
        self.imageView.layer.cornerRadius = 10;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.userInteractionEnabled = YES;
        //给图片添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self.imageView addGestureRecognizer:tap];
    }
    return _imageView;
}
-(UIButton *)cancelButton {
    if (!_cancelButton) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSURL *url = [bundle URLForResource:@"LXCShow" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        UIImage *image = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.cancelButton = [[UIButton alloc]init];
        [self.cancelButton setImage:image forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

@end

