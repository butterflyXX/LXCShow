//
//  LXCPlayerView.m
//  LXCRollingView_Example
//
//  Created by 刘晓晨 on 2018/5/10.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "LXCPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "TBloaderURLConnection.h"

@interface LXCPlayerView ()<TBloaderURLConnectionDelegate>
@property (nonatomic,strong)NSURL *url;
/**播放器*/
@property (nonatomic, strong)AVPlayer *player;
/**playerLayer*/
@property (nonatomic, strong)AVPlayerLayer *playerLayer;
/**播放器item*/
@property (nonatomic, strong)AVPlayerItem *playerItem;

@property (nonatomic, strong)TBloaderURLConnection *resouerLoader;

@property (nonatomic,strong)AVURLAsset *videoURLAsset;

@property (nonatomic,strong)NSCache *videoCache;
@end
@implementation LXCPlayerView

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
    self.videoCache = [NSCache new];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:
(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                NSLog(@"item 有误");
                break;
            case AVPlayerItemStatusReadyToPlay:
                NSLog(@"准好播放了");
                [self.player play];
                break;
            case AVPlayerItemStatusUnknown:
                NSLog(@"视频资源出现未知错误");
                break;
            default:
                break;
        }
    }
    //移除监听（观察者）
    [object removeObserver:self forKeyPath:@"status"];
}

-(void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    NSString *videoPath = [self localVideo];
    //判断沙盒有没有
    if (videoPath) {
        NSLog(@"本地播放");
        self.url = [NSURL fileURLWithPath:videoPath];
        self.playerItem = [AVPlayerItem playerItemWithURL:self.url];
    } else {
        NSLog(@"网络播放");
        self.url = [NSURL URLWithString:urlString];
        self.resouerLoader = [[TBloaderURLConnection alloc] init];
        self.resouerLoader.delegate = self;
        NSURL *playUrl = [_resouerLoader getSchemeVideoURL:self.url];
        self.videoURLAsset = [AVURLAsset URLAssetWithURL:playUrl options:nil];
        [_videoURLAsset.resourceLoader setDelegate:_resouerLoader queue:dispatch_get_main_queue()];
        self.playerItem = [AVPlayerItem playerItemWithAsset:_videoURLAsset];
    }
    
    if (!self.player) {
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    } else {
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    }
    //按比例填满屏幕
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.playerLayer];
    [self setNeedsLayout];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
}
#pragma marks - 查看是否有本地音频
-(NSString *)localVideo {
    NSString *lastUrlString = [_urlString lastPathComponent];
    NSString *cacheFilePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *videoPath =  [cacheFilePath stringByAppendingPathComponent:lastUrlString];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL hasVideo = [fileManager fileExistsAtPath:videoPath];
    return hasVideo == YES ? videoPath : nil;
}
#pragma mark - 暂停播放
- (void)pausePlay{
    [self.player pause];
}

#pragma mark - TBloaderURLConnectionDelegate

- (void)didFinishLoadingWithTask:(TBVideoRequestTask *)task
{
//    _isFinishLoad = task.isFinishLoad;
    NSLog(@"下载完成");
}

//网络中断：-1005
//无网络连接：-1009
//请求超时：-1001
//服务器内部错误：-1004
//找不到服务器：-1003
- (void)didFailLoadingWithTask:(TBVideoRequestTask *)task WithError:(NSInteger)errorCode
{
    NSString *str = nil;
    switch (errorCode) {
        case -1001:
            str = @"请求超时";
            break;
        case -1003:
        case -1004:
            str = @"服务器错误";
            break;
        case -1005:
            str = @"网络中断";
            break;
        case -1009:
            str = @"无网络连接";
            break;
            
        default:
            str = [NSString stringWithFormat:@"%@", @"(_errorCode)"];
            break;
    }
    
}

#pragma mark - 销毁播放器
- (void)destroyPlayer{
    [self pausePlay];
    //移除
    [self.playerLayer removeFromSuperlayer];
    [self removeFromSuperview];
    self.playerLayer = nil;
    self.player      = nil;
    self.url = nil;
}

@end
