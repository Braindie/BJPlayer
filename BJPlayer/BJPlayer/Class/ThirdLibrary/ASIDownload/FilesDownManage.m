//
//  FilesDownManage.m
//  MobileStudy
//
//  Created by sniper_yj on 15/10/29.
//
//

#import "FilesDownManage.h"
//#import "ZipArchive.h"
//#import "ZipManager.h"

#define kTHDownLoadTask_TempSuffix  @".TempDownload"
#define  Operation_Max_count 2


@implementation FilesDownManage


+(FilesDownManage *) sharedFilesDownManage{

    static   FilesDownManage *sharedFilesDownManage = nil;

    @synchronized(self){
        if (sharedFilesDownManage == nil) {
            sharedFilesDownManage = [[self alloc] init];
        }
    }
    return  sharedFilesDownManage;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        _filelistArr = [[NSMutableArray alloc] init];
        _downinglist = [[NSMutableArray alloc] init];
        _myCourseDic = [[NSDictionary alloc] init];

//        _downLoadingArr = [[NSMutableArray alloc] init];
//        _downLoadedArr = [[NSMutableArray alloc] init];

    }
    return self;
}


#pragma mark - 点击下载按钮时的外部接口
//-(void)downFileArray:(NSMutableArray *)downArray{
//    [self loadDownFile];
//}
//点击下载按钮后传来的下载数据（数组中有两个元素courseDic和downDic）
-(void)downFileArray:(NSMutableArray *)downArray{
    
//    _fileInfo = [[FileModel alloc] init];
    
    self.myCourseDic = [downArray firstObject];//9包含URL
    NSDictionary *course = [downArray lastObject];//25
    
    ///将传来的数据保存到数据库
//        [_fileInfo saveDataToDataBase:course withDownDic:self.myCourseDic];

    
    
    
    //***************通过URL得到文件名fileName和路径filePath
    //指定文件url
    self.urlString = [course objectForKey:@"savePath"];//URL
    self.url = [NSURL URLWithString:self.urlString];
    //未指定文件名,路径的最后字段设为文件名
    if (!self.fileName)
    {
        //        NSString *urlStr = [self.url absoluteString];
        //        self.fileName = [urlStr lastPathComponent];
        self.fileName = [self.urlString lastPathComponent];
        self.fileName = [self.fileName lastPathComponent];
        if ([self.fileName length] > 32)
            self.fileName = [self.fileName substringFromIndex:[self.fileName length]-32];
    }
    
    //未指定下载路径
    if (!self.filePath){
        NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        self.filePath = documentsDir;
    }
    NSString *filepathstring = [NSString stringWithFormat:@"%@/%@",self.filePath,self.fileName];
//    [self.myCourseDic setValue:filepathstring forKey:@"filePath"];
    
    
    //将传来的数据保存在model（和保存到数据库的数据不同，model中多了下载路径filePath)
    //更新数据库，把修改后的filePath（文件本地路径）和
//    _fileInfo = [_fileInfo initWithContentsOfDic:self.myCourseDic];
//    _fileInfo = [_fileInfo initWithContentsOfDic:course];
    
    
    //把下载数据保存在数组中
    //    [self.filelistArr addObject:_fileInfo];
    
    //如果用多线程，获取不到刚刚的数据
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSMutableArray *array = [NSMutableArray array];
//        for (int i = 0; i < 1; i++) {
//            DownloadModel *downloadModel = [[DownloadModel alloc] init];
//            downloadModel.title = self.fileName;
//            downloadModel.savePath = [course objectForKey:@"savePath"];//网络路径
//            downloadModel.filePath = self.filePath;//本地路径
//            downloadModel.downloadState = @"0";
//            [array addObject:downloadModel];
//        }
//        [DownloadModel saveObjects:array];
//    });
    
    
    NSMutableArray *array = [NSMutableArray array];
    DownloadModel *downloadModel = [[DownloadModel alloc] init];
    downloadModel.title = self.fileName;
    downloadModel.savePath = [course objectForKey:@"savePath"];//网络路径
    downloadModel.filePath = self.filePath;//本地路径
    downloadModel.downloadState = @"0";
    [array addObject:downloadModel];
    [DownloadModel saveObjects:array];

    
    [self loadDownFile];

}





#pragma mark - 筛选出正在下载的数据
- (void)loadDownFile{
    
    [self.filelistArr removeAllObjects];

    //通过本地获取下载队列
    NSArray *tmpArr = [DownloadModel findByCriteria:@""];///////**********////////数组中为字典
    NSLog(@"数据库文件的总个数 === %@",tmpArr);

    
    //计算需要下载个数
    int downingCount = 0;
    for (DownloadModel *fileModel in tmpArr) {
        int downing = [fileModel.downloadState intValue];
        if (downing == Downloading) {
            downingCount++;
        }
    }

    //
    int hasDowning = 0;//正在下载的个数
    for(DownloadModel *filemodel in tmpArr){
        int downState = [filemodel.downloadState intValue];

        NSMutableDictionary *mulDic = [NSMutableDictionary dictionaryWithCapacity:10];
        if (downingCount == 1) {
        }else{

            if(downState == DownloadWaiting && hasDowning < 1 && downingCount != 1){

                ++hasDowning;

                [mulDic setValue:[NSString stringWithFormat:@"%d",Downloading] forKey:@"downloadState"];

            }else if(downState == Downloading && hasDowning >= 1){

                ++hasDowning;

                [mulDic setValue:[NSString stringWithFormat:@"%d",DownloadWaiting] forKey:@"downloadState"];

            }else if(downState == DownloadWaiting && hasDowning < 1 ){

                ++hasDowning;
                
                [mulDic setValue:[NSString stringWithFormat:@"%d",Downloading] forKey:@"downloadState"];
                
            }
        }
        filemodel.downloadState = [mulDic objectForKey:@"downloadState"];
//            filemodel = [filemodel initWithContentsOfDic:mulDic];//插入下载参数（两个字典中都有size，mulDic中的size有值，为防止被覆盖，在courseDic写入后再写入）
        //本界面获取的下载数组
        [self.filelistArr addObject:filemodel];
        
        
        
        //保存到本地
//        [DownloadModel updateObjects:self.filelistArr];
    }

    [self readyStartLoad];//从数据库中加载model后进行下载
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"DownLoadNeedUpdate" object:nil];
}


#pragma mark - 将数据库中的数据取出，并添加地址等字段
-(void)readyStartLoad{

    for (DownloadModel *fileModel in self.filelistArr) {

        NSLog(@"将要下载的文件个数=%ld",self.filelistArr.count);
        //URL，文件名，保存地址
        NSURL *url = [NSURL URLWithString:fileModel.savePath];

        NSString *urlStr = [url absoluteString];
        self.fileName = [urlStr lastPathComponent];
        if ([self.fileName length] > 32){
            self.fileName = [self.fileName substringFromIndex:[self.fileName length]-32];
        }

        if (!self.filePath){
//            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            NSString *docDir = [paths objectAtIndex:0];
            NSArray  *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDir = [documentPaths objectAtIndex:0];
            self.filePath = documentsDir;
        }


        //文件地址
        NSString *filepathstring = [NSString stringWithFormat:@"%@/%@",self.filePath,self.fileName];
        fileModel.filePath = filepathstring;
        //临时地址
//        self.temporaryPath=[self.destinationPath stringByAppendingFormat:kTHDownLoadTask_TempSuffix];
//        NSString *temporarypath = [self.destinationPath stringByAppendingFormat:kTHDownLoadTask_TempSuffix];
        NSString *pathstring = [NSString stringWithFormat:@"%@/ZBD/%@",self.filePath,self.fileName];
        fileModel.tempPath = pathstring;
        //目标地址
//        self.destinationPath=[self.filePath stringByAppendingPathComponent:self.fileName];
//        NSArray *temArr = [pathstring componentsSeparatedByString:@"."];
//        NSString *destinationPath = [temArr firstObject];
        fileModel.targetPath = filepathstring;



//        int downState = [fileModel.downloadState intValue];
        int downState = 0;
        //准备网络下载
        if (downState == 0) {
            [self beginRequest:fileModel withIsBegin:YES];
        }else if(downState == 2 ||downState == 1){
            [self beginRequest:fileModel withIsBegin:NO];
        }
    }
}

#pragma mark - 网络下载请求
-(void)beginRequest:(DownloadModel *)fileInfo withIsBegin:(BOOL)isBigin{

//    NSLog(@"start down::下载个数：%d",self.downinglist.count);

    //1.获取下载队列
//    NSLog(@"%d",self.downinglist.count);

    for(ASIHTTPRequest *tempRequest in self.downinglist)//遍历下载队列
    {
        if([[fileInfo.filePath lastPathComponent] isEqualToString:[[tempRequest.url absoluteString] lastPathComponent]])
        {
            if ([tempRequest isExecuting] && isBigin) {//存在已下载文件，正在下载的文件,
                return;

            }else if([tempRequest isExecuting] && !isBigin){//存在已下载文件，继续下载的文件

                [tempRequest setUserInfo:[NSDictionary dictionaryWithObject:fileInfo forKey:@"File"]];
                [tempRequest clearDelegatesAndCancel];
                return;
            }
        }
    }

    //获取已下文件的大小
    if ([fileInfo.downProgress integerValue] == 0) {

        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSData *fileData=[fileManager contentsAtPath:fileInfo.tempPath];
        NSInteger receivedDataLength=[fileData length];
        fileInfo.downProgress = [NSString stringWithFormat:@"%ld",receivedDataLength];

//        NSLog(@"start down:已经下载：%@",fileInfo.downProgress);
    }



    //创建下载请求数据
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fileInfo.savePath]];
    request.delegate = self;
    //注：临时文件的保存地址和下载完成时的保存地址不能相同，相同会调用下载失败方法，下载完成后临时文件会自动删除
    [request setDownloadDestinationPath:fileInfo.tempPath];//下载完成时的保存地址
    [request setTemporaryFileDownloadPath:fileInfo.targetPath];//临时文件的保存地址
    [request setDownloadProgressDelegate:self];
    [request setNumberOfTimesToRetryOnTimeout:2];
//    [request setShouldContinueWhenAppEntersBackground:YES];
//    [request setDownloadProgressDelegate:downCell.progress];//设置进度条的代理,这里由于下载是在AppDelegate里进行的全局下载，所以没有使用自带的进度条委托，这里自己设置了一个委托，用于更新UI
    [request setAllowResumeForFileDownloads:YES];//支持断点续传
    [request setUserInfo:[NSDictionary dictionaryWithObject:fileInfo forKey:@"File"]];//设置上下文的文件基本信息
    [request setTimeOutSeconds:30.0f];

    //开启异步下载
    if (isBigin) {
        [request startAsynchronous];
    }


    BOOL exit = NO;
    for(ASIHTTPRequest *tempRequest in self.downinglist){
//        NSLog(@"start down::下载个数：%d",self.downinglist.count);
//        NSLog(@"!!!!---::%@",[tempRequest.url absoluteString]);

        if([[fileInfo.savePath lastPathComponent] isEqualToString:[[tempRequest.url absoluteString] lastPathComponent]])
        {
            [self.downinglist replaceObjectAtIndex:[_downinglist indexOfObject:tempRequest] withObject:request ];

            exit = YES;
            break;
        }
    }

    //加到下载队列里
    if (!exit)
    {
        [self.downinglist addObject:request];
    }
//    NSLog(@"start down::下载个数：%d",self.downinglist.count);


//    [self.downloadDelegate updateCellProgress:fileInfo.title withDownProgress:fileInfo.downProgress withTotalSize:fileInfo.size];

}



#pragma mark - 下载代理

- (void)requestStarted:(ASIHTTPRequest *)request{
    NSLog(@"开始了!");
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders{

    NSLog(@"收到回复了！");
    
    DownloadModel *fileInfo=[request.userInfo objectForKey:@"File"];
    //文件的大小
    NSString *len = [responseHeaders objectForKey:@"Content-Length"];

    //这个信息头，首次收到的为总大小，那么后来续传时收到的大小为肯定小于或等于首次的值，则忽略
    if ([fileInfo.size longLongValue] < [len longLongValue]){
        fileInfo.size = [NSString stringWithFormat:@"%lld", [len longLongValue]];
    }

//    fileInfo.fileSize = [NSString stringWithFormat:@"%lld", [len longLongValue]];
    fileInfo.downloadState = [NSString stringWithFormat:@"%d",Downloading];


//    fileInfo.isFirstReceived = YES;

//    [fileInfo receiveModel:fileInfo];
    NSArray *array = [NSArray arrayWithObject:fileInfo];
    [DownloadModel updateObjects:array];

}


- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes{
    
    NSLog(@"收到的数据=%lld",bytes);

    DownloadModel *fileInfo=[request.userInfo objectForKey:@"File"];
    
//    NSString *title = fileInfo.title;
//    if (fileInfo.isFirstReceived) {
//        fileInfo.isFirstReceived = NO;
//        fileInfo.downProgress =[NSString stringWithFormat:@"%lld",bytes];
//    }else{
//        fileInfo.downProgress=[NSString stringWithFormat:@"%lld",[fileInfo.downProgress longLongValue]+bytes];
//    }
    fileInfo.downProgress=[NSString stringWithFormat:@"%lld",[fileInfo.downProgress longLongValue]+bytes];

    //代理传进度
    if([self.downloadDelegate respondsToSelector:@selector(updateCellProgress:withDownProgress:withTotalSize:)]){
        [self.downloadDelegate updateCellProgress:fileInfo.title withDownProgress:fileInfo.downProgress withTotalSize:fileInfo.size];
    }
}



- (void)requestFinished:(ASIHTTPRequest *)request{

    NSLog(@"下载结束了！");


    DownloadModel *fileModel = [request.userInfo objectForKey:@"File"];
    NSString *size = [NSString stringWithFormat:@"%@",fileModel.size];

    //当前下载的时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
//    fileModel.lastTime = now;

    fileModel.downloadState = [NSString stringWithFormat:@"%d",DownloadOver];
    fileModel.size = size;
    fileModel.downProgress = size;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateDownloadState" object:nil];//改变详情的下载按钮图片

    
    //更新数据
    NSArray *array = [NSArray arrayWithObject:fileModel];
    [DownloadModel updateObjects:array];
//    [fileModel finishedDataToDataBase:fileModel];


    //删除要删除的对象,(删除downinglist中的内容）
    for (int i = 0; i < self.downinglist.count; i++) {
        ASIHTTPRequest *req = self.downinglist[i];
        DownloadModel *file = [req.userInfo objectForKey:@"File"];

        if (file.title == fileModel.title) {
            [self.downinglist removeObjectAtIndex:i];
        }
    }


    
    
    
//    if([GlobalData GetInstance].GB_ProductVesion == Mobile_Version)
//    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateDownloadSize" object:self.myDownDic];
//    }
//    if (isUnzingShow == NO) {
//        [self performSelectorInBackground:@selector(DoZipManager:) withObject:fileModel.targetPath];
//    }



//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    [delegate BeginDownload];


    
    //显示下载完成后的提示框
    [self performSelectorOnMainThread:@selector(ShowDownloadFinish:) withObject:request waitUntilDone:NO];

}


-(void) DoZipManager:(NSString *)path
{
//    [[ZipManager GetInstance] AddZipFile:path Dic:self.myCourseDic];

}


- (void)requestFailed:(ASIHTTPRequest *)request{

//    NSError *error=[request error];
//    NSLog(@"ASIHttpRequest出错了!%@",error);
//    if (error.code==4) {
//        return;
//    }
    NSLog(@"下载失败了！");


    DownloadModel *fileModel = [request.userInfo objectForKey:@"File"];

    NSString *message = [NSString stringWithFormat:@"由于网络连接已中断或发生错误，%@ 下载失败，请稍后重试！",fileModel.title];
    UIAlertView *alertView = [[UIAlertView alloc]  initWithTitle:@"下载失败" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertView show];
//    [GlobalFunc AddStatusLabelWithText:message];
    
    
    self.isFirstFailed = YES;

//    for (FileModel *filemodel in self.filelistArr) {
//        filemodel.downloadState = [NSString stringWithFormat:@"%d",DownloadPause];
//        [filemodel receiveModel:filemodel];
//    }

    
    //下载失败时，再开启别的下载进程
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    [delegate BeginDownload];

    //代理通知单元格刷新
    if ([self.downloadDelegate respondsToSelector:@selector(finishedDownload)]){
        [self.downloadDelegate finishedDownload];
    }
}



#pragma mark - 暂停，继续下载
//从下载界面传来的（单元格标识）（下载状态）
/*
-(void)stopDownload:(int)row Pause:(Download_State)state{


    ASIHTTPRequest *request = [self.downinglist objectAtIndex:row];
    FileModel *fileInfo=[request.userInfo objectForKey:@"File"];

    switch (state)
    {
        case Downloading:
        {
            fileInfo.downloadState = [NSString stringWithFormat:@"%d",DownloadPause];
            break;
        }
        case DownloadWaiting:
        {
            fileInfo.downloadState = [NSString stringWithFormat:@"%d",DownloadWaiting];
            break;
        }
        case DownloadPause:
        {
            fileInfo.downloadState = [NSString stringWithFormat:@"%d",DownloadWaiting];
            break;
        }
        case Download_Failed:
        {
            fileInfo.downloadState = [NSString stringWithFormat:@"%d",DownloadPause];
            break;
        }
        default:
            break;
    }

    //在Model类中保存model到数据库
    [fileInfo receiveModel:fileInfo];

    if([fileInfo.downloadState integerValue] == DownloadPause)//文件正在下载，点击之后暂停下载 有可能进入等待状态
    {
        //暂停
        [self stopRequest:fileInfo.courseId];
        NSLog(@"%@---暂停了",fileInfo.title);


    }else if([fileInfo.downloadState integerValue] == Downloading){
        //继续下载
        [self resumeRequest:fileInfo.courseId];
        NSLog(@"%@---又开始了",fileInfo.title);

    }
}


//暂停
-(void)stopRequest:(NSString *)request{

    NSString *str = [[NSString alloc] init];
    str = [NSString stringWithString:request];

    for (ASIHTTPRequest *request in self.downinglist) {

        FileModel *fileInfo=[request.userInfo objectForKey:@"File"];

        if ([fileInfo.courseId isEqual:str]) {

            [request clearDelegatesAndCancel];
            
        }
    }
}

//暂停后继续下载
-(void)resumeRequest:(NSString *)request{

//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
//    [delegate BeginDownload];
}

#pragma mark - 删除
- (void)deleteDownload:(int)row{


    ASIHTTPRequest *request = [self.downinglist objectAtIndex:row];
    FileModel *fileModel = [request.userInfo objectForKey:@"File"];

//    NSMutableArray *needDeleteArr = [NSMutableArray arrayWithCapacity:1];//记录需要删除的对象
    //先暂停，再删除
//    @synchronized(self.downinglist)
//    {
//        for(FileModel *file in self.downinglist)
//        {
//            if(file.title == fileModel.title)
//            {
//                //                [loader Clear];
//                [needDeleteArr addObject:fileModel];
//
//            }
//        }
//    }

    //删除下载request
    [self deleteRequest:fileModel.courseId];

    //删除要删除的对象,(删除downinglist中的内容）
    if ([self.downinglist count] > 0) {
        [self.downinglist removeObjectAtIndex:row];
    }

    //已下载的文件夹名
    NSString *folderName = fileModel.courseId;//待解决bug
//    LOG_CINFO(folderName);

//    NSDictionary *courseDic = [self.courseTb GetOneRecordWithKeys:[NSArray arrayWithObjects:@"courseId", nil] Values:[NSArray arrayWithObjects:[dic objectForKey:@"courseId"], nil] UseUser:NO];
//    LOG_CINFO(courseDic);
//    //正在下载的临时zip文件名
//    NSString *tmpZipName = [courseDic objectForKey:@"tbcId"];
//    LOG_CINFO(tmpZipName);

    if (fileModel == nil) {
        return;
    }

    NSString *tmpZipName = fileModel.tbcId;

    //删除前暂停
    fileModel.downloadState = [NSString stringWithFormat:@"%d",DownloadPause];
    [fileModel receiveModel:fileModel];

    NSString *downPath = [NSString stringWithFormat:@"%@/Documents/Download", NSHomeDirectory()];

    //删除本地临时文件
//    NSString *zipTmpName = [tmpZipName stringByAppendingString:@".zip.TempDownload"];
    NSString *zipName = [tmpZipName stringByAppendingString:@".zip"];
//    LOG_CINFO(zipName);
//    [GlobalFunc DeleteFolderWithPath:downPath folderName:zipName];//解压后的文件


//    [GlobalFunc DeleteFileWithName:zipName];
//    [GlobalFunc DeleteFileWithName:zipTmpName];
    //    [[NSFileManager defaultManager] removeItemAtPath:self.destinationPath error:nil];

    //删除数据库中的这条记录
    NSString *courseId = fileModel.courseId;
    [fileModel deleteDataFromDataBase:courseId];
}

//判断是否已下载
- (BOOL)ISExist:(NSArray *)arr{
    
    NSDictionary *course = [arr lastObject];//25
    NSString *string = [course objectForKey:@"courseId"];
    
    
    FileModel *tmpModel = [[FileModel alloc] init];
    NSDictionary *tmpDic = [tmpModel searchIsDownloaded:string];
    
    
    
    if (tmpDic != nil) {
        return YES;
    }else{
        return NO;
    }
}



//删除
-(void)deleteRequest:(NSString *)nsstring{

    NSString *str = [[NSString alloc] init];
    str = [NSString stringWithString:nsstring];

    for (ASIHTTPRequest *request in self.downinglist) {

        FileModel *fileInfo=[request.userInfo objectForKey:@"File"];

        if ([fileInfo.courseId isEqual:str]) {

            [request clearDelegatesAndCancel];

        }
    }
}
*/

#pragma mark - 显示解压等待画面
-(void)ShowDownloadFinish:(ASIHTTPRequest *)request{

    DownloadModel *fileInfo=[request.userInfo objectForKey:@"File"];

    float totalSize = [fileInfo.size floatValue]/1024.0/1024.0;
    NSString *titleName = fileInfo.title;
    

    UIAlertView *alertView = [[UIAlertView alloc]  initWithTitle:@"下载完成" message:[NSString stringWithFormat:@"%@下载完成\n大小：%.fM",titleName,totalSize] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alertView show];
//    LOG_CFLTVALUE(@"size", totalSize);
//    if (totalSize < 1) {
//        [[GlobalData GetInstance] DoGCDQueue:[NSString stringWithFormat:@"%@下载完成\n大小：%.fK",titleName,totalSize*1024]];
//    }
//    else {
//        [[GlobalData GetInstance] DoGCDQueue:[NSString stringWithFormat:@"%@下载完成\n大小：%.1fM",titleName,totalSize]];
//    }

//    [[NSNotificationCenter defaultCenter] postNotificationName:@"downloadFinish" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateDownloadState" object:nil];

    //代理通知单元格刷新
    if ([self.downloadDelegate respondsToSelector:@selector(finishedDownload)]){
        [self.downloadDelegate finishedDownload];
    }
}



@end
