//
//  MainViewCtrl.m
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/19.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "MainViewCtrl.h"
#import "MainTableViewCell.h"
#import "DownloadViewCtrl.h"
#import "FilesDownManage.h"
#import "UIImage+GIF.h"
#import "AppDelegate.h"
#import "MainTableModel.h"
#import "PlayerViewController.h"

static NSString *cellId = @"MainTableViewCell";


@interface MainViewCtrl ()
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *myDataArr;
@property (nonatomic, strong) NSMutableArray *myModelArr;
@property (nonatomic, strong) MainTableModel *model;
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
    self.navigationItem.title = @"MPMoviePlayerViewController";
    self.view.backgroundColor = [UIColor whiteColor];

    [self addRightBtn];

    
    [self buildUI];

    [self loadQiDongView];
}

- (NSArray *)myDataArr{
    if (!_myDataArr) {
        _myDataArr = @[@{@"title":@"急速追杀",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1491214025476&di=e366ae73a26c02deb8b9ee93c63cca7b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%253D580%2Fsign%3Defe9a6aa0e55b3199cf9827d73a88286%2F537a84d6277f9e2f4722f7a31b30e924b999f37c.jpg",@"sourceUrl":@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"},
                       @{@"title":@"鸟人",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1491213920149&di=9fa27faa5762da18f1c94011f31614e6&imgtype=0&src=http%3A%2F%2Fs2.sinaimg.cn%2Fmw690%2F001IJYmRgy71QZoRVUB51%26690",@"sourceUrl":@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"},
                       @{@"title":@"死亡占卜",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1491213958804&di=908ac6be1d67a0cf8f8c78ad523701ab&imgtype=0&src=http%3A%2F%2Fcdn.she.com%2Fbuckets%2Fshe%2Fwww%2Fcontents%2F2014%2F10%2Fc14102281_6.jpg",@"sourceUrl":@"http://120.25.226.186:32812/resources/videos/minion_03.mp4"}
                       ];
    }
    return _myDataArr;
}

- (NSMutableArray *)myModelArr{
    if (!_myModelArr) {
        _myModelArr = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in self.myDataArr) {
            MainTableModel *model = [[MainTableModel alloc] init];
            model.title = [dic objectForKey:@"title"];
            model.imageUrl = [dic objectForKey:@"imageUrl"];
            model.sourceUrl = [dic objectForKey:@"sourceUrl"];
            [_myModelArr addObject:model];
        }
    }
    return _myModelArr;
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
    //    [self.view addSubview:qidongImage];
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

- (void)buildUI{
    
    [self.view addSubview:self.myTableView];
}

- (void)addRightBtn{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"离线" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn:)];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [rightBarItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}



#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"MainTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    cell.downBtn.tag = indexPath.row;
    [cell.downBtn addTarget:self action:@selector(downBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = self.myModelArr[indexPath.row];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayerViewController *vc = [[PlayerViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 下载按钮点击事件
- (void)downBtnAction:(UIButton *)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要下载吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (!buttonIndex) {
        NSLog(@"%ld",buttonIndex);//确定
        
        MainTableModel *model = self.myModelArr[buttonIndex];
        NSString *string = model.sourceUrl;
        //下载参数(第一个字典无用，第二个字典中有URL）
        NSMutableDictionary *downDic = [NSMutableDictionary dictionaryWithCapacity:6];
        NSMutableDictionary *courseDic = [NSMutableDictionary dictionaryWithCapacity:16];
        [courseDic setValue:string forKey:@"savePath"];

        NSMutableArray *downloadDataArray = [NSMutableArray arrayWithObjects:downDic, courseDic, nil];
        
        //去下载
        [[FilesDownManage sharedFilesDownManage] performSelectorInBackground:@selector(downFileArray:) withObject:downloadDataArray];
        
    }else{
        NSLog(@"%ld",buttonIndex);//取消
    }
}

#pragma mark - 下载界面点击事件
- (void)onClickedOKbtn:(UIButton *)btn{
    DownloadViewCtrl *downloadViewCtrl = [[DownloadViewCtrl alloc] init];
    downloadViewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:downloadViewCtrl animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
