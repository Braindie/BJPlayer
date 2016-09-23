//
//  FilesDownManage.h
//  MobileStudy
//
//  Created by sniper_yj on 15/10/29.
//
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

//#import "FileModel.h"
#import "DownloadModel.h"



@protocol DownloadDelegate <NSObject>

//-(void)startDownload:(ASIHTTPRequest *)request;
//-(void)updateCellProgress:(ASIHTTPRequest *)request;
//-(void)finishedDownload:(ASIHTTPRequest *)request;
//-(void)allowNextRequest;//处理一个窗口内连续下载多个文件且重复下载的情况

- (void)updateCellProgress:(NSString *)title withDownProgress:(NSString *)downProgress withTotalSize:(NSString *)size;

- (void)finishedDownload;


@end


@interface FilesDownManage : NSObject<ASIHTTPRequestDelegate,ASIProgressDelegate>{

    BOOL       overwrite;

    unsigned long long fileSize;


@private
    unsigned long long  offset;
}


@property(nonatomic,strong)id<DownloadDelegate> downloadDelegate;//下载列表delegate


@property(nonatomic, strong) NSDictionary *myCourseDic;

//@property(nonatomic,strong)FileModel *fileInfo;

@property (nonatomic, assign) NSInteger reConnectTimes;
@property(nonatomic,assign) BOOL isFirstFailed;

@property(nonatomic,assign) BOOL ISXorEncryptData;
@property(nonatomic, strong) NSFileHandle *fileHandle;


@property(nonatomic,strong)NSMutableArray *downinglist;//正在下载的文件列表(ASIHttpRequest对象)
@property(nonatomic,strong)NSMutableArray *filelistArr;//正在下载的文件列表(model对象）


//文件保存的path(不包括文件名),默认路径为DocumentDirectory
@property (nonatomic, strong) NSString *filePath;


//下载文件的名字名，默认为下载原文件名
@property (nonatomic, strong) NSString *fileName;


//下载的地址,当下载地址为nil，下载失败
@property (nonatomic, strong) NSURL *url;


@property (nonatomic, strong) NSString *urlString;
@property(nonatomic, strong) NSString *destinationPath,*temporaryPath;//下载的目标地址和临时地址

@property (nonatomic, strong) NSDictionary *myDownDic;


//@property (nonatomic, strong) LocalDataBase *myTable;
//@property (nonatomic, strong) LocalDataBase *downloadTb;


+(FilesDownManage *) sharedFilesDownManage;


- (BOOL)ISExist:(NSArray *)arr;
//- (BOOL)ISExist:(NSDictionary *)dic;



-(void)deleteDownload:(int)row;//删除
-(void)deleteRequest:(NSString *)nsstring;//下载中删除下载任务


-(void)stopRequest:(NSString *)request;//暂停
-(void)resumeRequest:(NSString *)request;//暂停后继续下载
-(void)stopDownload:(int)row Pause:(Download_State)state;//暂停



//下载流程
-(void)loadDownFile;//从本地数据库加载下载参数
-(void)downFileArray:(NSMutableArray *)downArray;//从下载界面传下载参数

-(void)readyStartLoad;//遍历下载列表中的model，开始下载

//-(void)beginRequest:(FileModel *)fileInfo withIsBegin:(BOOL)isBigin;//开启异步下载
-(void)beginRequest:(DownloadModel *)fileInfo withIsBegin:(BOOL)isBigin;//开启异步下载


@end
