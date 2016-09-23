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

static NSString *downloadingID = @"DownloadingCell";
static NSString *downloadedID = @"DownloadedCell";


@interface DownloadViewCtrl ()<DownloadDelegate>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UITableView *downloadTableView;
@property (nonatomic, assign) BOOL isDownloading;//界面判读字段
@property (nonatomic, strong) NSMutableArray *myDataArr;
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

    [self getDownLoadData];
    
//    self.title = @"下载";
    self.isDownloading = YES;
    self.view.backgroundColor = [UIColor orangeColor];
    [self buildUI];
}

- (void)getDownLoadData{
    FilesDownManage *fileDownManage = [FilesDownManage sharedFilesDownManage];
    NSMutableArray *dicArr = [NSMutableArray arrayWithCapacity:5];//下载队列（字典）

    for (ASIHTTPRequest *request in fileDownManage.downinglist) {
        
        DownloadModel *file = [request.userInfo objectForKey:@"File"];
        
//        NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 file.period,@"period",
//                                 file.downProgress,@"downProgress",
//                                 file.size,@"size",
//                                 file.userid,@"userid",
//                                 file.lastTime,@"lastTime" ,
//                                 file.courseId,@"courseId",
//                                 file.image,@"image",
//                                 file.downloadState,@"downloadState",
//                                 file.title,@"title",
//                                 nil];
        
        [dicArr addObject:file];
        
    }
    
    
    self.myDataArr = dicArr;
    
    
    @synchronized(self.myDataArr)
    {
        self.myDataArr = dicArr;
    }
    
    
    [self.downloadTableView reloadData];

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
        NSLog(@"%ld",seg.selectedSegmentIndex);
        self.isDownloading = NO;
    }else{
        NSLog(@"%ld",seg.selectedSegmentIndex);
        self.isDownloading = YES;
    }
    [self.downloadTableView reloadData];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.isDownloading) {
        DownloadingCell *cell = [tableView dequeueReusableCellWithIdentifier:downloadedID];
        if (cell == nil) {
            UINib *nib = [UINib nibWithNibName:@"DownloadedCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:downloadedID];
            cell = [tableView dequeueReusableCellWithIdentifier:downloadedID];
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }else{
        
        DownloadedCell *cell = [tableView dequeueReusableCellWithIdentifier:downloadingID];
        if (cell == nil) {
            UINib *nib = [UINib nibWithNibName:@"DownloadingCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:downloadingID];
            cell = [tableView dequeueReusableCellWithIdentifier:downloadingID];
        }
        cell.backgroundColor = [UIColor orangeColor];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}









#pragma mark - 代理
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
    
    [self getDownLoadData];
    
    [self.downloadTableView reloadData];
    
//    //正在下载的
//    if ([self.myDataArr count] == 0)
//    {
//        self.myInfoLable.hidden = NO;
//    }
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
