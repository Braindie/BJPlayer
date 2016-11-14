//
//  DownloadViewCtrl.m
//  BJPlayer
//
//  Created by zhangwenjun on 16/9/19.
//  Copyright © 2016年 zhangwenjun. All rights reserved.
//

#import "DownloadViewCtrl.h"
#import "DownloadingCell.h"
#import "DownloadedCell.h"
#import "FilesDownManage.h"
#import "DownloadModel.h"
#import "PlayerViewController.h"

static NSString *downloadingID = @"DownloadingCell";
static NSString *downloadedID = @"DownloadedCell";


@interface DownloadViewCtrl ()<DownloadDelegate>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *downloadTableView;
@property (nonatomic, assign) BOOL isDownloading;//界面判读字段
@property (nonatomic, strong) NSMutableArray *myDownLoadingArr;
@property (nonatomic, strong) NSMutableArray *myDownLoadOverArr;

@end

@implementation DownloadViewCtrl

- (UITableView *)downloadTableView{
    if (!_downloadTableView) {
        _downloadTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _downloadTableView.backgroundColor = [UIColor lightGrayColor];
        _downloadTableView.delegate = self;
        _downloadTableView.dataSource = self;
    }
    return _downloadTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [FilesDownManage sharedFilesDownManage].downloadDelegate = self;
    self.isDownloading = YES;
    self.view.backgroundColor = [UIColor orangeColor];
    [self buildUI];

    //刷新数据
    [self getDownLoadData];
    //刷新单元格
    [self.downloadTableView reloadData];
}

- (NSMutableArray *)myDownLoadingArr{
    if (!_myDownLoadingArr) {
        _myDownLoadingArr = [[NSMutableArray alloc] init];
    }
    return _myDownLoadingArr;
}
- (NSMutableArray *)myDownLoadOverArr{
    if (!_myDownLoadOverArr) {
        _myDownLoadOverArr = [[NSMutableArray alloc] init];
    }
    return _myDownLoadOverArr;
}
//获取未下载和已下载列表
- (void)getDownLoadData{
    
    [self.myDownLoadingArr removeAllObjects];
    [self.myDownLoadOverArr removeAllObjects];
    
    //未下载列表
    FilesDownManage *fileDownManage = [FilesDownManage sharedFilesDownManage];
    NSMutableArray *downingArr = [NSMutableArray arrayWithCapacity:5];//下载队列（字典）
    for (ASIHTTPRequest *request in fileDownManage.downinglist) {
        
        DownloadModel *file = [request.userInfo objectForKey:@"File"];
        
        [downingArr addObject:file];
        
    }
    self.myDownLoadingArr = downingArr;
    
    //已下载列表
    NSMutableArray *downOverArr = [NSMutableArray arrayWithCapacity:5];//下载队列（字典）
    downOverArr = (NSMutableArray *)[DownloadModel findByCriteria:@""];
    for (DownloadModel *model in downOverArr) {
        if (model.downloadState == DownloadOver) {
            [self.myDownLoadOverArr addObject:model];
        }
    }
}

- (void)buildUI{
    NSArray *segmentedData = [[NSArray alloc] initWithObjects:@"下载中",@"已下载", nil];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedData];
    _segmentedControl.frame = CGRectMake(self.navigationController.view.frame.size.width/2-60, 25, 120, 30);
    
    _segmentedControl.tintColor = [UIColor orangeColor];
    _segmentedControl.selectedSegmentIndex = 0;
    
    NSDictionary *highlightAttributes = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [_segmentedControl setTitleTextAttributes:highlightAttributes forState:UIControlStateHighlighted];
    [_segmentedControl addTarget:self action:@selector(doSomethingInSegment:) forControlEvents:UIControlEventValueChanged];
    
    [self.navigationController.view addSubview:_segmentedControl];
    
    
    //
    [self.view addSubview:self.downloadTableView];
}



- (void)doSomethingInSegment:(UISegmentedControl *)seg{
    if (seg.selectedSegmentIndex) {
        NSLog(@"已下载%ld",seg.selectedSegmentIndex);
        self.isDownloading = NO;
    }else{
        NSLog(@"未下载%ld",seg.selectedSegmentIndex);
        self.isDownloading = YES;
    }
    [self.downloadTableView reloadData];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isDownloading) {
        return self.myDownLoadingArr.count;
    }else{
        return self.myDownLoadOverArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isDownloading) {
        DownloadingCell *cell = [tableView dequeueReusableCellWithIdentifier:downloadingID];
        if (cell == nil) {
            UINib *nib = [UINib nibWithNibName:@"DownloadingCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:downloadingID];
            cell = [tableView dequeueReusableCellWithIdentifier:downloadingID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        
        DownloadedCell *cell = [tableView dequeueReusableCellWithIdentifier:downloadedID];
        if (cell == nil) {
            UINib *nib = [UINib nibWithNibName:@"DownloadedCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:downloadedID];
            cell = [tableView dequeueReusableCellWithIdentifier:downloadedID];
        }
        cell.backgroundColor = [UIColor orangeColor];
        
        DownloadModel *model = [self.myDownLoadOverArr objectAtIndex:indexPath.row];
        cell.titleLabel.text = model.title;
        cell.sizeLabel.text = [NSString stringWithFormat:@"%@B",model.size];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isDownloading) {
        
    }else{
        PlayerViewController *vc = [[PlayerViewController alloc] init];
        vc.downLoadModel = self.myDownLoadOverArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}






#pragma mark - DownloadDelegate
- (void)updateCellProgress:(NSString *)title withDownProgress:(NSString *)downProgress withTotalSize:(NSString *)size{
    NSArray* cellArr = [self.downloadTableView visibleCells];//获取单元格视图的cell数组
    
    for(id obj in cellArr){
        
        if([obj isKindOfClass:[DownloadingCell class]]){
            
            DownloadingCell *cell=(DownloadingCell *)obj;
            
            
            //总大小
            float totalSize = [size floatValue];
            
            //当前大小
            float currentSize = [downProgress floatValue];
            
            //计算下载百分比
            float tmpProgerss = currentSize * 100 / totalSize;
            NSString *progerssValue = [NSString stringWithFormat:@"%.f%%",tmpProgerss];
            NSString *progerssV = [NSString stringWithFormat:@"100%%"];
            //进度值
            if (tmpProgerss <= 100) {
                cell.percent.text = progerssValue;
            }else{
                cell.percent.text = progerssV;
            }
            //进度条
            float tmpProgressView = currentSize / totalSize;
            cell.progress.progress = tmpProgressView;
            
            
            //文件总大小
            float total = [size floatValue]/1024.0/1024.0;
            NSLog(@"size = %f", totalSize);
            if (total < 1 && cell.fileSize.text == nil) {
                cell.fileSize.text= [NSString stringWithFormat:@"大小：%.fK",total*1024];
            }
            else {
                cell.fileSize.text= [NSString stringWithFormat:@"大小：%.1fM",total];
            }
            
            cell.title.text = title;
            if([cell.title.text isEqualToString: title]){
            }
        }
    }
}
- (void)finishedDownload{
    
    //更新下载中和已下载的数据
    [self getDownLoadData];
    //刷新单元格
    [self.downloadTableView reloadData];
    
//    //正在下载的
//    if ([self.myDataArr count] == 0)
//    {
//        self.myInfoLable.hidden = NO;
//    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.segmentedControl.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.segmentedControl.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.segmentedControl.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    self.segmentedControl.hidden = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
