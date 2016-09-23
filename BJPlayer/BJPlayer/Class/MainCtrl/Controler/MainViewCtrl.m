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
    self.myDataArr = [NSArray arrayWithObjects:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4",
                      @"http://120.25.226.186:32812/resources/videos/minion_02.mp4",
                      @"http://120.25.226.186:32812/resources/videos/minion_03.mp4",nil];
}

- (void)buildUI{
    
    [self.view addSubview:self.myTableView];
}

- (void)addRightBtn{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"下载" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn:)];
    [rightBarItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn:(UIButton *)btn{
    DownloadViewCtrl *downloadViewCtrl = [[DownloadViewCtrl alloc] init];
    [self.navigationController pushViewController:downloadViewCtrl animated:YES];
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
        //下载参数
        NSMutableDictionary *downDic = [NSMutableDictionary dictionaryWithCapacity:6];
        //    [downDic setValue:[GlobalData GetInstance].GB_UserID forKey:@"userid"];
        //    [downDic setValue:self.myCourseID forKey:@"courseId"];
        //    [downDic setValue:@"1" forKey:@"downloadState"];
        //    [downDic setValue:@"0" forKey:@"downProgress"];
        //    [downDic setValue:[self.myDetailDic objectForKey:@"imgUrl"] forKey:@"image"];
        //    [downDic setValue:[self.myDetailDic objectForKey:@"title"] forKey:@"title"];
        //    [downDic setValue:[self.myDetailDic objectForKey:@"learnedPeriod"] forKey:@"period"];
        //    [downDic setValue:@"0" forKey:@"size"];
        //    [downDic setValue:@"" forKey:@"lastTime"];
        //
        NSMutableDictionary *courseDic = [NSMutableDictionary dictionaryWithCapacity:16];
        [courseDic setValue:string forKey:@"savePath"];

        //    [courseDic setValue:self.myCourseID forKey:@"courseId"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"imgUrl"] forKey:@"image"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"title"] forKey:@"title"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"decribe"] forKey:@"decribe"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"cobject"] forKey:@"cobject"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"target"] forKey:@"ctarget"];
        //    [courseDic setValue:@"" forKey:@"cNum"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"parentRcoId"] forKey:@"tbcId"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"classroomid"] forKey:@"classroomid"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"learnedPeriod"] forKey:@"period"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"level"] forKey:@"level"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"sortName"] forKey:@"sortName"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"stime"] forKey:@"stime"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"etime"] forKey:@"etime"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"dateStr"] forKey:@"dateStr"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"ltimes"] forKey:@"hits"];
        //    [courseDic setValue:@"0" forKey:@"size"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"learningState"] forKey:@"learningState"];
        //    [courseDic setValue:[self.myDetailDic objectForKey:@"learnedPeriod"] forKey:@"learnedPeriod"];
        //
        //    
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
