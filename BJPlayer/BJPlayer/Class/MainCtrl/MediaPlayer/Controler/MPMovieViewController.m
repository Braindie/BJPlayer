//
//  MPMovieViewController.m
//  BJPlayer
//
//  Created by 张文军 on 2019/12/11.
//  Copyright © 2019 zhangwenjun. All rights reserved.
//

#import "MPMovieViewController.h"
#import "MainTableViewCell.h"
#import "DownloadViewCtrl.h"
#import "FilesDownManage.h"
#import "MainTableModel.h"
#import "PlayerViewController.h"
#import "DownloadModel.h"

static NSString *cellId = @"MainTableViewCell";


@interface MPMovieViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *myDataArr;
@property (nonatomic, strong) NSMutableArray *myModelArr;
@property (nonatomic, strong) MainTableModel *model;
@end

@implementation MPMovieViewController

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}

- (NSArray *)myDataArr{
    if (!_myDataArr) {
        _myDataArr =        @[@{@"title":@"急速追杀",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1491214025476&di=e366ae73a26c02deb8b9ee93c63cca7b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fw%253D580%2Fsign%3Defe9a6aa0e55b3199cf9827d73a88286%2F537a84d6277f9e2f4722f7a31b30e924b999f37c.jpg",@"sourceUrl":@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"},
                       @{@"title":@"鸟人",@"imageUrl":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1491213920149&di=9fa27faa5762da18f1c94011f31614e6&imgtype=0&src=http%3A%2F%2Fs2.sinaimg.cn%2Fmw690%2F001IJYmRgy71QZoRVUB51%26690",@"sourceUrl":@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"}
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

#pragma mark - cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"MPMoviePlayer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildUI];
}

#pragma mark - UI
- (void)buildUI{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"离线" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn:)];
    [rightBarItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self.view addSubview:self.myTableView];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    vc.isLocalPlayer = YES;
    MainTableModel *mainModel = self.myModelArr[indexPath.row];
    DownloadModel *downloadModel = [[DownloadModel alloc] init];
    downloadModel.savePath = mainModel.sourceUrl;
    vc.downloadModel = downloadModel;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击事件
- (void)downBtnAction:(UIButton *)sender{
    MainTableModel *model = self.myModelArr[0];
    NSString *string = model.sourceUrl;
    //下载参数(第一个字典无用，第二个字典中有URL）
    NSMutableDictionary *downDic = [NSMutableDictionary dictionaryWithCapacity:6];
    NSMutableDictionary *courseDic = [NSMutableDictionary dictionaryWithCapacity:16];
    [courseDic setValue:string forKey:@"savePath"];
    
    NSMutableArray *downloadDataArray = [NSMutableArray arrayWithObjects:downDic, courseDic, nil];
    
    //去下载
    [[FilesDownManage sharedFilesDownManage] performSelectorInBackground:@selector(downFileArray:) withObject:downloadDataArray];
}

- (void)onClickedOKbtn:(UIButton *)btn{
    DownloadViewCtrl *downloadViewCtrl = [[DownloadViewCtrl alloc] init];
    downloadViewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:downloadViewCtrl animated:YES];
}

@end
