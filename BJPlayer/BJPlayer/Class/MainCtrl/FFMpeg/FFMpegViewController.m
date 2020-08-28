//
//  FFMpegViewController.m
//  
//
//  Created by zhangwenjun on 2018/7/3.
//

#import "FFMpegViewController.h"
#import "KxMovieViewController.h"
#import "BJFFMpegPlayerViewController.h"

@interface FFMpegViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *myDataArr;
@end

@implementation FFMpegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"FFMpeg";
    self.view.backgroundColor = [UIColor whiteColor];

    [self buildUI];
}

- (void)buildUI{
    [self.view addSubview:self.myTableView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSDictionary *dic = [self.myDataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        BJFFMpegPlayerViewController *vc = [[BJFFMpegPlayerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row) {
        NSString *url = @"http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8";
    //    NSString *url = @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
        KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:url parameters:nil];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}

- (NSArray *)myDataArr{
    if (!_myDataArr) {
        _myDataArr = @[@{@"title":@"ffmpeg",@"imageUrl":@""},
                       @{@"title":@"kxmovie",@"imageUrl":@""},
                       @{@"title":@"",@"imageUrl":@""},
                       @{@"title":@"",@"imageUrl":@""}];
    }
    return _myDataArr;
}


@end
