//
//  FFMpegViewController.m
//  
//
//  Created by zhangwenjun on 2018/7/3.
//

#import "FFMpegViewController.h"
//#import "KxMovieViewController.h"

@interface FFMpegViewController ()

@end

@implementation FFMpegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"FFMpegViewController";
    self.view.backgroundColor = [UIColor whiteColor];

    [self addRightBtn];
    

}

- (void)addRightBtn{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"直播" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn:)];
    //    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [rightBarItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}


- (void)onClickedOKbtn:(UIButton *)sender{
//    NSString *url = @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
//    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:url parameters:nil];
//    [self presentViewController:vc animated:YES completion:nil];
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
