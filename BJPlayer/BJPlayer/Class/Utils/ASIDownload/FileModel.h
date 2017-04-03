//
//  FileModel.h
//  MobileStudy
//
//  Created by sniper_yj on 15/10/21.
//
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface FileModel : BaseModel{


//    //1.插入课程信息表
//    LocalDataBase *courseTb;
//    //2.插入课程下载表
//    LocalDataBase *downloadTb;
//
//    LocalDataBase *userCourseTb;
    
}

@property (nonatomic ,strong) NSString *userid;
@property (nonatomic ,strong) NSString *courseId;
@property (nonatomic ,strong) NSString *downloadState;
@property (nonatomic ,strong) NSString *downProgress;
@property (nonatomic ,strong) NSString *image;
@property (nonatomic ,strong) NSString *smallImage;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *period;
@property (nonatomic ,strong) NSString *size;
@property (nonatomic ,strong) NSString *lastTime;


//@property (nonatomic ,strong) NSString *courseId;
//@property (nonatomic ,strong) NSString *image;
@property (nonatomic ,strong) NSString *savePath;//文件的url
//@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *decribe;
@property (nonatomic ,strong) NSString *cobject;
@property (nonatomic ,strong) NSString *ctarget;
@property (nonatomic ,strong) NSString *cNum;
@property (nonatomic ,strong) NSString *tbcId;
@property (nonatomic ,strong) NSString *classroomid;
//@property (nonatomic ,strong) NSString *period;
@property (nonatomic ,strong) NSString *level;
@property (nonatomic ,strong) NSString *sortName;
@property (nonatomic ,strong) NSString *stime;
@property (nonatomic ,strong) NSString *etime;
@property (nonatomic ,strong) NSString *dateStr;
@property (nonatomic ,strong) NSString *hits;
//@property (nonatomic ,strong) NSString *size;
@property (nonatomic ,strong) NSString *learningState;
@property (nonatomic ,strong) NSString *learnedPeriod;



@property (nonatomic, strong) NSString *filePath;//下载文件的路径
@property (nonatomic, strong) NSString *fileSize;//文件的大小（弃用）


@property (nonatomic, strong) NSString *tempPath;//临时地址
@property (nonatomic, strong) NSString *targetPath;//目标地址


@property(nonatomic,assign)BOOL isFirstReceived;//是否是第一次接受数据，如果是则不累加第一次返回的数据长度，之后变累加

//查询课程是否下载
- (NSDictionary *)searchIsDownloaded:(NSString *)string;


//获取数据库中正在下载的队列
- (NSArray *)getDownloadArray;
- (NSDictionary *)getDownloadCourseDicFromCourseID:(NSString *)courseID;

//获取已下载队列
- (NSArray *)getDownloadedArr;


//添加新下载时保存参数到数据库
- (void)saveDataToDataBase:(NSDictionary *)courseDic withDownDic:(NSDictionary *)downDic;


//传来model进行数据库保存
- (void)receiveModel:(FileModel *)fileModel;


//删除数据库表记录
- (void)deleteDataFromDataBase:(NSString *)courseID;

//下载完成后修改三个表
- (void)finishedDataToDataBase:(FileModel *)fileModel;

//
//NSMutableDictionary *downDic = [NSMutableDictionary dictionaryWithCapacity:6];
//[downDic setValue:[GlobalData GetInstance].GB_UserID forKey:@"userid"];
//[downDic setValue:self.myCourseID forKey:@"courseId"];
//[downDic setValue:@"1" forKey:@"downloadState"];
//[downDic setValue:@"0" forKey:@"downProgress"];
//[downDic setValue:[self.curCourseDic objectForKey:@"image"] forKey:@"image"];
//[downDic setValue:[self.curCourseDic objectForKey:@"title"] forKey:@"title"];
//[downDic setValue:[self.curCourseDic objectForKey:@"period"] forKey:@"period"];
//[downDic setValue:@"0" forKey:@"size"];
//[downDic setValue:@"" forKey:@"lastTime"];
//
//
//NSMutableDictionary *courseDic = [NSMutableDictionary dictionaryWithCapacity:16];
//[courseDic setValue:self.myCourseID forKey:@"courseId"];
//[courseDic setValue:[self.curCourseDic objectForKey:@"image"] forKey:@"image"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"downloadUrl"] forKey:@"savePath"];
//[courseDic setValue:[self.curCourseDic objectForKey:@"title"] forKey:@"title"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"decribe"] forKey:@"decribe"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"cobject"] forKey:@"cobject"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"target"] forKey:@"ctarget"];
//[courseDic setValue:[self.curCourseDic objectForKey:@"cnum"] forKey:@"cNum"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"parentRcoId"] forKey:@"tbcId"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"classroomid"] forKey:@"classroomid"];
//[courseDic setValue:[self.curCourseDic objectForKey:@"period"] forKey:@"period"];
//[courseDic setValue:[self.curCourseDic objectForKey:@"level"] forKey:@"level"];
//[courseDic setValue:[self.curCourseDic objectForKey:@"sortName"] forKey:@"sortName"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"stime"] forKey:@"stime"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"etime"] forKey:@"etime"];
//[courseDic setValue:[self.curCourseDic objectForKey:@"dateStr"] forKey:@"dateStr"];
//[courseDic setValue:[self.curCourseDic objectForKey:@"ltimes"] forKey:@"hits"];
//[courseDic setValue:@"0" forKey:@"size"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"learningState"] forKey:@"learningState"];
//[courseDic setValue:[self.myDetailDic objectForKey:@"learnedPeriod"] forKey:@"learnedPeriod"];


@end
