//
//  MainViewCtrl.m
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/19.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "MainViewCtrl.h"
#import "UIImage+GIF.h"
#import "AppDelegate.h"

#import "MPMovieViewController.h"
#import "AVPlayerViewController.h"
#import "FFMpegViewController.h"
#import "BJAudioViewController.h"


@interface MainViewCtrl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *myDataArr;
@end

@implementation MainViewCtrl


- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"多媒体";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildUI];

    [self loadQiDongView];
}

- (NSArray *)myDataArr{
    if (!_myDataArr) {
        _myDataArr = @[@{@"title":@"MPMoviePlayer",@"imageUrl":@""},
                       @{@"title":@"AVPlayer",@"imageUrl":@""},
                       @{@"title":@"基于FFMpeg",@"imageUrl":@""},
                       @{@"title":@"Audio",@"imageUrl":@""}];
    }
    return _myDataArr;
}


- (void)buildUI{
    
    [self.view addSubview:self.myTableView];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSDictionary *dic = [self.myDataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MPMovieViewController *vc = [[MPMovieViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        AVPlayerViewController *vc = [[AVPlayerViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        FFMpegViewController *vc = [[FFMpegViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        BJAudioViewController *vc = [[BJAudioViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - 启动动画
- (void)loadQiDongView{
    //    // 设定位置和大小
    //    CGRect frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    //    //    frame.size = [UIImage imageNamed:@"loading.gif"].size;
    //    // 读取gif图片数据
    //    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"]];
    //    // view生成
    //    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    //    webView.userInteractionEnabled = NO;//用户不可交互
    //    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
    //    webView.backgroundColor = [UIColor blackColor];
    //    webView.opaque = NO;
    //    [self.window addSubview:webView];
    
    CGRect frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    UIImageView *qidongImage = [[UIImageView alloc] initWithFrame:frame];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    qidongImage.image = image;
    UIApplication *app = [UIApplication sharedApplication];
    [app.keyWindow addSubview:qidongImage];
    
    
    //    __block MainViewCtrl *weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            qidongImage.transform = CGAffineTransformMakeScale(0.1, 0.1);
            qidongImage.alpha = 0;
        } completion:^(BOOL finished) {
            [qidongImage removeFromSuperview];
        }];
    });
}

@end
