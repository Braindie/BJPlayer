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

static NSString *cellId = @"MainTableViewCell";


@interface MainViewCtrl ()
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"视频";
    
    [self getDownloadData];
    
    [self buildUI];
    
    [self addRightBtn];
}

- (void)getDownloadData{
    self.myDataArr = [NSArray arrayWithObjects:
                      @"http://120.25.226.186:32812/resources/videos/minion_02.mp4",
                      @"http://120.25.226.186:32812/resources/videos/minion_01.mp4",
                      @"http://120.25.226.186:32812/resources/videos/minion_03.mp4",nil];
}

- (void)buildUI{
    
    [self.view addSubview:self.myTableView];
}

- (void)addRightBtn{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"离线" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn:)];
    [rightBarItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn:(UIButton *)btn{
    DownloadViewCtrl *downloadViewCtrl = [[DownloadViewCtrl alloc] init];
    [self.navigationController pushViewController:downloadViewCtrl animated:YES];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"MainTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellId];
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    }
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要下载吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (!buttonIndex) {
        NSLog(@"%ld",buttonIndex);//确定
        
        NSString *string = self.myDataArr[buttonIndex];
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
