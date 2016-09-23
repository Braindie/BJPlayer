//
//  FileModel.m
//  MobileStudy
//
//  Created by sniper_yj on 15/10/21.
//
//

#import "FileModel.h"

@implementation FileModel


//- (NSDictionary *)searchIsDownloaded:(NSString *)string{
//
//    downloadTb = [LocalDataBase GetTableWithType:@"downLoadTable" HasUser:NO];
//    NSDictionary *downTmpDic = [downloadTb GetOneRecordWithKeys:[NSArray arrayWithObjects:@"courseId",@"userid", nil] Values:[NSArray arrayWithObjects:string,[GlobalData GetInstance].GB_UserID, nil] UseUser:NO];
//    return downTmpDic;
//}
//
//- (NSArray *)getDownloadArray{
//
//    LocalDataBase *tb = [LocalDataBase GetTableWithType:@"downLoadTable" HasUser:NO];
//    //全部下载队列，找这些里面状态为正在下载的
//    NSString *sql = [NSString stringWithFormat:@"select * from downLoadTable where downloadState <>'3' and userid = '%@'",[GlobalData GetInstance].GB_UserID];
//
//
//    NSArray *tmpArr = [tb GetDataArrWithSql:sql];//从数据库中拿到正在下载的队列数组
//     
//    return tmpArr;
//}

- (NSDictionary *)getDownloadCourseDicFromCourseID:(NSString *)courseID{

//    courseTb = [LocalDataBase GetTableWithType:@"implement_class_relation" HasUser:NO];
//    NSDictionary *courseDic = [courseTb GetOneRecordWithKeys:[NSArray arrayWithObjects:@"courseId", nil] Values:[NSArray arrayWithObjects:courseID, nil] UseUser:NO];
    return nil;
}


//
////把外部传来的下载参数保存到数据库中
//- (void)saveDataToDataBase:(NSDictionary *)courseDic withDownDic:(NSDictionary *)downDic{
//
//    //1.插入课程 信息表
//    courseTb = [LocalDataBase GetTableWithType:@"implement_class_relation" HasUser:NO];
//    //把数据插入表中
////    [courseTb performSelectorInBackground:@selector(InsertDataWithDic:Replace:) withObject:courseDic];
//    [courseTb InsertDataWithDic:courseDic Replace:YES];
//
//    //2.插入课程 下载表
//    downloadTb = [LocalDataBase GetTableWithType:@"downLoadTable" HasUser:NO];
//    //把数据插入表中
////    [downloadTb performSelectorInBackground:@selector(InsertDataWithDic:Replace:) withObject:downDic];
//    [downloadTb InsertDataWithDic:downDic Replace:YES];
//
//}
//
//
//
//- (void) receiveModel:(FileModel *)fileModel{
//
//#if ISUnicom_Version
//
//    NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:
//                             fileModel.period,@"period",
//                             fileModel.downProgress,@"downProgress",
//                             fileModel.size,@"size",
//                             fileModel.userid,@"userid",
//                             fileModel.lastTime,@"lastTime" ,
//                             fileModel.courseId,@"courseId",
//                             fileModel.smallImage,@"smallImage",
//                             fileModel.downloadState,@"downloadState",
//                             fileModel.title,@"title",
//                             nil];
//#else
//    NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:
//                             fileModel.period,@"period",
//                             fileModel.downProgress,@"downProgress",
//                             fileModel.size,@"size",
//                             fileModel.userid,@"userid",
//                             fileModel.lastTime,@"lastTime" ,
//                             fileModel.courseId,@"courseId",
//                             fileModel.image,@"image",
//                             fileModel.downloadState,@"downloadState",
//                             fileModel.title,@"title",
//                             nil];
//
//#endif
//
//    //2.插入课程 下载表
//    downloadTb = [LocalDataBase GetTableWithType:@"downLoadTable" HasUser:NO];
//    //把数据插入表中
//    [downloadTb InsertDataWithDic:filedic Replace:YES];
//    
//}
//
//
//- (void)deleteDataFromDataBase:(NSString *)courseID{
//
//
//    //从本地数据库中删除这条记录
//    downloadTb = [LocalDataBase GetTableWithType:@"downLoadTable" HasUser:NO];
//    [downloadTb DeleteOneRecordWithKeys:[NSArray arrayWithObjects:@"userid",@"courseId", nil]
//                                      Values:[NSArray arrayWithObjects:[GlobalData GetInstance].GB_UserID,courseID, nil] UserUser:NO];
//
//    userCourseTb = [LocalDataBase GetTableWithType:@"learn_enroll" HasUser:NO];
//    [userCourseTb DeleteOneRecordWithKeys:[NSArray arrayWithObjects:@"userid",@"courseId", nil]
//                                        Values:[NSArray arrayWithObjects:[GlobalData GetInstance].GB_UserID,courseID, nil] UserUser:NO];
//
//}
//
//- (void)finishedDataToDataBase:(FileModel *)fileModel{
//
//
//
////    /***************插入下载表*******************/
////    NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:
////                             fileModel.period,@"period",
////                             fileModel.downProgress,@"downProgress",
////                             fileModel.size,@"size",
////                             fileModel.userid,@"userid",
////                             fileModel.lastTime,@"lastTime" ,
////                             fileModel.courseId,@"courseId",
////                             fileModel.image,@"image",
////                             fileModel.downloadState,@"downloadState",
////                             fileModel.title,@"title",
////                             nil];
//
//
//#if ISUnicom_Version
//
//    NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:
//                             fileModel.period,@"period",
//                             fileModel.downProgress,@"downProgress",
//                             fileModel.size,@"size",
//                             fileModel.userid,@"userid",
//                             fileModel.lastTime,@"lastTime" ,
//                             fileModel.courseId,@"courseId",
//                             fileModel.smallImage,@"smallImage",
//                             fileModel.downloadState,@"downloadState",
//                             fileModel.title,@"title",
//                             nil];
//#else
//    NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:
//                             fileModel.period,@"period",
//                             fileModel.downProgress,@"downProgress",
//                             fileModel.size,@"size",
//                             fileModel.userid,@"userid",
//                             fileModel.lastTime,@"lastTime" ,
//                             fileModel.courseId,@"courseId",
//                             fileModel.image,@"image",
//                             fileModel.downloadState,@"downloadState",
//                             fileModel.title,@"title",
//                             nil];
//
//#endif
//
//    //插入课程下载表
//    downloadTb = [LocalDataBase GetTableWithType:@"downLoadTable" HasUser:NO];
//    //把数据插入表中
//    [downloadTb InsertDataWithDic:filedic Replace:YES];
//
//
//
//    /*************插入课程信息表*******************/
//    courseTb = [LocalDataBase GetTableWithType:@"implement_class_relation" HasUser:NO];
//    //看看是否存在这条记录
//    NSDictionary *courseDic = [courseTb GetOneRecordWithKeys:[NSArray arrayWithObjects:@"courseId", nil] Values:[NSArray arrayWithObjects:fileModel.courseId, nil] UseUser:NO];
//
//    if (courseDic != nil) {
//        [courseDic setValue:fileModel.size forKey:@"size"];
//        //把数据插入表中
//        [courseTb InsertDataWithDic:courseDic Replace:YES];
//    }
//
//    
//    /*************插入用户课程关联表*******************/
//    userCourseTb = [LocalDataBase GetTableWithType:@"learn_enroll" HasUser:NO];
//    //看看是否存在这条记录
//    NSDictionary *userCourseDic = [userCourseTb GetOneRecordWithKeys:[NSArray arrayWithObjects:@"courseId",@"userid", nil] Values:[NSArray arrayWithObjects:fileModel.courseId,[GlobalData GetInstance].GB_UserID, nil] UseUser:NO];
//
//    if (userCourseDic != nil) {
//        [userCourseDic setValue:fileModel.targetPath forKey:@"zipSavePath"];
//        [userCourseDic setValue:fileModel.downloadState forKey:@"downloadState"];
//
////        if([size floatValue] == 0.00||[size floatValue]<[fileSize floatValue])
////        {
////            [userCourseDic setValue:[NSString stringWithFormat:@"%d",Download_Failed] forKey:@"downloadState"];
////        }
////        else{
////            [userCourseDic setValue:[NSString stringWithFormat:@"%d",DownloadOver] forKey:@"downloadState"];
////        }
//
//        [userCourseDic setValue:fileModel.lastTime forKey:@"finishDate"];
//        [userCourseDic setValue:@"1" forKey:@"finishNum"];
//        //把数据插入表中
//        [userCourseTb InsertDataWithDic:userCourseDic Replace:YES];
//    }
//}
//
//- (NSArray *)getDownloadedArr{
//
//    //已经下载的
//    NSString *sql = [NSString stringWithFormat:@"select * from downLoadTable where downloadState = '3' and userid = '%@' order by lastTime DESC",[GlobalData GetInstance].GB_UserID];
//    downloadTb = [LocalDataBase GetTableWithType:@"downLoadTable" HasUser:NO];
//    NSMutableArray *tmpArr = [downloadTb GetDataArrWithSql:sql];
//
//    return tmpArr;
//}
//




@end
