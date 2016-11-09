//
//  CourseTableViewContrl.h
//  MobileStudy
//
//  Created by chenxili on 14/12/11.
//
//

#import <UIKit/UIKit.h>

@protocol courseTableDelegate <NSObject>

-(void)PackUpCourseTable;//收起课程列表
-(void)HaveCourseClicked:(int)index;//点击事件
@end

@interface CourseTableViewContrl : UITableViewController
@property(nonatomic, weak) id<courseTableDelegate> delegate;
@property(nonatomic,strong)NSArray *myCourseArr;
@property(nonatomic,assign) int myIndex;
@property(nonatomic,assign) BOOL isPlaying;
@property(nonatomic,strong)UIButton *backBtn;

-(void)UpdateFrame;

@end
