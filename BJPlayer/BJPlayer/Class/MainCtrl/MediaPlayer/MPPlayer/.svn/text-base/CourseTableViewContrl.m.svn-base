//
//  CourseTableViewContrl.m
//  MobileStudy
//
//  Created by chenxili on 14/12/11.
//
//

#import "CourseTableViewContrl.h"
//#import "CourseDetailCell.h"
#import "CourseTableCell.h"


@interface CourseTableViewContrl ()

@end

@implementation CourseTableViewContrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.view.backgroundColor=[UIColor clearColor];
    
    
//    UIView *topView=[[UIView alloc] init];
//    topView.backgroundColor=RGBACOLOR(100, 100, 100, 0.85);
//    topView.frame=CGRectMake(0, 0, self.view.frame.size.width, 60);
//    
//    //题目
//    UILabel *titleLab=[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
//    titleLab.text=@"目录";
//    titleLab.backgroundColor=[UIColor clearColor];
//    titleLab.textColor=[UIColor blackColor];
//    titleLab.font=[UIFont systemFontOfSize:20];
//    titleLab.textColor=[UIColor whiteColor];
//    [topView addSubview:titleLab];
//    
//    //收起
//    self.backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [GlobalFunc SetImageButton:self.backBtn Normal:@"video_back_b.png" Highlight:@"video_back_b0.png" Clicked:@""];
//    [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:self.backBtn];

    UIView * vieww=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 2)];
    vieww.backgroundColor=[UIColor clearColor];
    
    self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.tableFooterView=vieww;
//    self.tableView.tableHeaderView=topView;
    
}

-(void)backBtn:(id)sender//收起
{
    [_delegate PackUpCourseTable];
    
}

-(void)UpdateFrame;
{
    self.backBtn.frame=CGRectMake(self.view.frame.size.width-60, 20, 40, 40);
}


#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
#if ISMobile_Version
    
    return 50;
#else
    float height;
    NSString *fileType=nil;
    NSMutableDictionary *dic = [self.myCourseArr objectAtIndex:indexPath.row];
    
    NSString *titleStr = [dic objectForKey:@"title"];
    //先获取课件类型
    NSString *url = [dic objectForKey:@"url"];
    NSArray *tmpArr = [url componentsSeparatedByString:@"."];
    //文件类型
    fileType = [[tmpArr lastObject] lowercaseString];
    NSString *type=[GlobalFunc AttachType:fileType];
    //获取修改结尾类型后的字符串
    NSString *titleImageStr = [GlobalFunc titleString:titleStr AppendSourceType:type WithImageClassType:0];
    //生成RClabel
    RCLabel *tempLabel = [[RCLabel alloc]initWithFrame:CGRectMake(25, 15, 272+GB_HorizonDifference-50, 80)];
    tempLabel.backgroundColor = [UIColor clearColor];
    [tempLabel setTextAlignment:RTTextAlignmentLeft];
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [tempLabel setTextColor:CreateColorByRGB(@"(144,144,144)")];
    //计算RClabel结构体并传入参数
    RTLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:titleImageStr];
    tempLabel.componentsAndPlainText = componentsDS;
    
    
    //计算出的cell高度 并保证最低高度
    height = [tempLabel optimumSize].height+30;
    if (height <40) {
        height = 40;
    }
    //        将计算好的 RClabel和cell高度写入dic 节约计算
    [dic setObject:componentsDS forKey:@"componentsDS"];
    [dic setObject:tempLabel forKey:@"tempLabel"];
#endif


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myCourseArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.myCourseArr objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"coursetable";
    CourseTableCell *cell = (CourseTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[CourseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"coursetable"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.titleLabel.textColor=[UIColor darkGrayColor];

    NSString *state=[dic objectForKey:@"trackingType"];
#if ISMobile_Version
    NSString *title = [dic objectForKey:@"title"];
    cell.titleLabel.text = title;

#else
    NSString *state=[dic objectForKey:@"trackingType"];
    //获取计算好的RClabel参数并刷新数据
    [cell UpdateRtLabel:[dic objectForKey:@"tempLabel"]];

#endif
    NSString *chapterID = [dic objectForKey:@"chapterId"];
    //首次进入当前就要播放或正在播放的Cell
    if ([chapterID isEqualToString:[[GlobalData GetInstance].curPlayDic objectForKey:@"chapterId"]]) {
        cell.stateImage.image=[UIImage imageNamed:@"playing.png"];
        cell.titleLabel.textColor = CreateColorByRGB(TitleBgImgViewColor);//绿
        
    }
    else{
        //完成
        if ([state isEqualToString:@"C"]) {
            cell.stateImage.image=[UIImage imageNamed:@"over_play.png"];
            cell.titleLabel.textColor=[UIColor darkGrayColor];
            
        }
        else {//未学习
            cell.stateImage.image=[UIImage imageNamed:@"no_play.png"];
            cell.titleLabel.textColor=[UIColor darkGrayColor];
            
        }
    }

    
    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [GlobalData GetInstance].isSourseClick=NO;
    [_delegate HaveCourseClicked:indexPath.row];//点击课程列表
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
