//
//  VideoViewController.m
//  VR_world
//
//  Created by XZB on 16/3/15.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoCell.h"
#import "VideoDataHelper.h"
#import "VideoModel.h"
#import "AVPlayerViewController.h"

@interface VideoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
{
    int num;
}
@property (nonatomic, strong) UIActivityIndicatorView *activity; // 菊花
@property (nonatomic, strong) UIImageView *navImgView; // 导航栏
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *leftLine; // 左边的横线
@property (nonatomic, strong) UIView *rightLine; // 右边的横线
@property (nonatomic, strong) UIImageView *backView; // 背景图
@property (nonatomic, strong) UIView *movieView; // 电影筛选栏
@property (nonatomic, strong) UIView *videoView; // 视频筛选栏
@property (nonatomic, strong) UICollectionView *videoCollectionView; // 视频列表
@property (nonatomic, strong) UIImageView *videoBack; // 背景图

// 筛选按钮
// 电影
@property (nonatomic, strong) UIButton *IMAXBtn;
@property (nonatomic, strong) UIButton *D3Btn;
@property (nonatomic, strong) UIButton *actionBtn;
@property (nonatomic, strong) UIButton *riskBtn;
@property (nonatomic, strong) UIButton *terrorBtn;
@property (nonatomic, strong) UIButton *taleBtn;
@property (nonatomic, strong) UIButton *loveBtn;
@property (nonatomic, strong) UIButton *crimeBtn;
@property (nonatomic, strong) UIButton *SFBtn;
@property (nonatomic, strong) UIButton *comedyBtn;
// 视频
@property (nonatomic, strong) UIButton *IMAXBtn2;
@property (nonatomic, strong) UIButton *D3Btn2;
@property (nonatomic, strong) UIButton *IMAXBtn22;
@property (nonatomic, strong) UIButton *D3Btn22;
@property (nonatomic, strong) UIButton *actionBtn2;
@property (nonatomic, strong) UIButton *riskBtn2;
@property (nonatomic, strong) UIButton *terrorBtn2;
@property (nonatomic, strong) UIButton *taleBtn2;
@property (nonatomic, strong) UIButton *loveBtn2;
@property (nonatomic, strong) UIButton *crimeBtn2;
@property (nonatomic, strong) UIButton *SFBtn2;
@property (nonatomic, strong) UIButton *comedyBtn2;
@property (nonatomic, strong) UIButton *PEBtn2;
@property (nonatomic, strong) UIButton *gameBtn2;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *moviewArray; // 电影数组
@property (nonatomic, strong) NSMutableArray *videoArray; // 视频数组

@end

@implementation VideoViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.videoCollectionView reloadData];
    // 控制屏幕常亮
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    num = 1;

    // 创建导航栏view
    _navImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 5.242, 0, SCREEN_WIDTH - SCREEN_WIDTH / 5.242, SCREEN_HEIGHT / 5.9)];
    UIImage *img = [UIImage imageNamed:@"bg_titlebar.png"];
    _navImgView.image = img;
    [self.view addSubview:_navImgView];
    _navImgView.userInteractionEnabled = YES;
    
    // 在navImgView上添加按钮
    _leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftBtn.frame = CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 23, SCREEN_HEIGHT / 16.56, 70, SCREEN_HEIGHT / 16.56);
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_HEIGHT / 16.56];
    [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _leftBtn.enabled = NO;
    
    [_leftBtn setTitle:NSLocalizedString(@"video1", nil) forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [_navImgView addSubview:_leftBtn];
    
    _leftLine = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 14, _leftBtn.bottom + 5, 50, 6)];
    _leftLine.layer.cornerRadius = 3;
    _leftLine.layer.masksToBounds = YES;
    _leftLine.backgroundColor = RGB_COLOR(49, 174, 176, 1);
    [_navImgView addSubview:_leftLine];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightBtn.frame = CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH / 5.242) - (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 24, SCREEN_HEIGHT / 16.56, 68, SCREEN_HEIGHT / 16.56);
    [_rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setTitle:NSLocalizedString(@"video2", nil) forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:SCREEN_HEIGHT / 16.56];
    [_navImgView addSubview:_rightBtn];
    _rightLine = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - SCREEN_WIDTH / 5.242) - (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 15, _rightBtn.bottom + 5, 50, 6)];
    _rightLine.layer.masksToBounds = YES;
    _rightLine.layer.cornerRadius = 3;
    _rightLine.backgroundColor = RGB_COLOR(49, 174, 176, 1);
    [_navImgView addSubview:_rightLine];
    _rightLine.hidden = YES;
    
    // 视频的背景图
    _backView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 5.242, _navImgView.bottom, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242), SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9)];
    UIImage *backImg = [UIImage imageNamed:@"bg_2.jpg"];
    _backView.image = backImg;
    _backView.userInteractionEnabled = YES;
    [self.view addSubview:_backView];
    
    // 添加视频列表
    [self drawCollectionView];
#pragma mark UICollectionView 上下拉刷新
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 下拉刷新
    weakSelf.videoCollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;//页码初始值
        if (num == 1) {
            // 电影
            [MBProgressHUD showHUDWithMeg:@"正在加载" toView:weakSelf.videoCollectionView];
            [weakSelf.moviewArray removeAllObjects];
            [weakSelf.videoCollectionView reloadData];
            [weakSelf getMovieUrlPage:[NSString stringWithFormat:@"%d",_page]];
        } else {
            // 视频
            [MBProgressHUD showHUDWithMeg:@"正在加载" toView:weakSelf.videoCollectionView];
            [weakSelf.videoArray removeAllObjects];
            [weakSelf.videoCollectionView reloadData];
            [weakSelf getVideoUrlPage:[NSString stringWithFormat:@"%d",_page]];
        }
        
        // 结束刷新
        [weakSelf.videoCollectionView.mj_header endRefreshing];
    }];
    [weakSelf.videoCollectionView.mj_header beginRefreshing];
    
    // 上拉刷新
    weakSelf.videoCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

            if (num == 1) {
                // 电影
                _page+=12;
                [weakSelf getMovieUrlPage:[NSString stringWithFormat:@"%d",_page]];
            } else {
                // 视频
                _page+=12;
                [weakSelf getVideoUrlPage:[NSString stringWithFormat:@"%d",_page]];
            }
        
        // 结束刷新
        [weakSelf.videoCollectionView.mj_footer endRefreshing];
    }];
    // 默认先隐藏footer
    weakSelf.videoCollectionView.mj_footer.hidden = YES;
    
//    [self drawMovieSelectView];
//    [_backView addSubview:_movieView];
//    [self videoSelect];
}

// 滚到最顶端
- (void)scrollToTop:(BOOL)animated {
    [self.videoCollectionView setContentOffset:CGPointMake(0,70) animated:animated];
}

// 电影按钮
- (void)leftAction
{
    [self.videoArray removeAllObjects];
    [self.videoCollectionView reloadData];
    num = 1;
    _page = 0;
    [MBProgressHUD showHUDWithMeg:@"正在加载" toView:_backView];
    [self scrollToTop:YES];
    _leftLine.hidden = NO;
    _leftBtn.enabled = NO;
    _rightLine.hidden = YES;
    _rightBtn.enabled = YES;
    // 电影
    [self getMovieUrlPage:@"0"];
//    [_backView addSubview:_movieView];
//    [_videoView removeFromSuperview];

}

// 视频按钮
- (void)rightAction
{
    [self.moviewArray removeAllObjects];
    [self.videoCollectionView reloadData];
    num = 2;
    _page = 0;
    [MBProgressHUD showHUDWithMeg:@"正在加载" toView:_backView];
    [self getVideoUrlPage:@"0"];
    [self scrollToTop:YES];
    _rightLine.hidden = NO;
    _rightBtn.enabled = NO;
    _leftLine.hidden = YES;
    _leftBtn.enabled = YES;
   
//    [_backView addSubview:_videoView];
//    [_movieView removeFromSuperview];

}

// 电影的筛选栏
- (void)drawMovieSelectView
{
    _movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    
    // 最新
    UILabel *news = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 34, 17)];
    news.text = @"最新";
    news.textColor = [UIColor whiteColor];
    [_movieView addSubview:news];
    
    // IMAX
    _IMAXBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _IMAXBtn.frame = CGRectMake(news.right + 30, news.top, 37, 17);
    [_IMAXBtn setTitle:@"IMAX" forState:UIControlStateNormal];
    [_movieView addSubview:_IMAXBtn];
    [_IMAXBtn addTarget:self action:@selector(IMAXBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_IMAXBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    
    // 3D
    _D3Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _D3Btn.frame = CGRectMake(_IMAXBtn.right + 10, news.top, 30, 17);
    [_D3Btn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_D3Btn addTarget:self action:@selector(D3BtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_D3Btn setTitle:@"3D" forState:UIControlStateNormal];
    [_movieView addSubview:_D3Btn];
    
    // 全部
    UILabel *all = [[UILabel alloc] initWithFrame:CGRectMake(30, news.bottom + 10, 34, 17)];
    all.text = @"全部";
    all.textColor = [UIColor whiteColor];
    [_movieView addSubview:all];
    
    // 动作
    _actionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_actionBtn setTitle:@"动作" forState:UIControlStateNormal];
    _actionBtn.frame = CGRectMake(all.right + 30, all.top, 30, 17);
    [_actionBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_actionBtn addTarget:self action:@selector(actionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_movieView addSubview:_actionBtn];
    
    // 冒险
    _riskBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_riskBtn setTitle:@"冒险" forState:UIControlStateNormal];
    [_riskBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_riskBtn addTarget:self action:@selector(riskBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _riskBtn.frame = CGRectMake(_actionBtn.right + 10, all.top, 30, 17);
    [_movieView addSubview:_riskBtn];
    
    // 恐怖
    _terrorBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _terrorBtn.frame = CGRectMake(_riskBtn.right + 10, all.top, 30, 17);
    [_terrorBtn setTitle:@"恐怖" forState:UIControlStateNormal];
    [_terrorBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_terrorBtn addTarget:self action:@selector(terrorBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_movieView addSubview:_terrorBtn];
    
    // 武侠
    _taleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _taleBtn.frame = CGRectMake(_terrorBtn.right + 10, all.top, 30, 17);
    [_taleBtn setTitle:@"武侠" forState:UIControlStateNormal];
    [_taleBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_taleBtn addTarget:self action:@selector(taleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_movieView addSubview:_taleBtn];
    
    // 爱情
    _loveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loveBtn.frame = CGRectMake(_taleBtn.right + 10, all.top, 30, 17);
    [_loveBtn setTitle:@"爱情" forState:UIControlStateNormal];
    [_loveBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_loveBtn addTarget:self action:@selector(loveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_movieView addSubview:_loveBtn];
    
    // 犯罪
    _crimeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _crimeBtn.frame = CGRectMake(_loveBtn.right + 10, all.top, 30, 17);
    [_crimeBtn setTitle:@"犯罪" forState:UIControlStateNormal];
    [_crimeBtn addTarget:self action:@selector(crimeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_crimeBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_movieView addSubview:_crimeBtn];
    
    // 科幻
    _SFBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _SFBtn.frame = CGRectMake(_crimeBtn.right + 10, all.top, 30, 17);
    [_SFBtn setTitle:@"科幻" forState:UIControlStateNormal];
    [_SFBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_SFBtn addTarget:self action:@selector(SFBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_movieView addSubview:_SFBtn];
    
    // 喜剧
    _comedyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _comedyBtn.frame = CGRectMake(_SFBtn.right + 10, all.top, 30, 17);
    [_comedyBtn setTitle:@"喜剧" forState:UIControlStateNormal];
    [_comedyBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_comedyBtn addTarget:self action:@selector(comedyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_movieView addSubview:_comedyBtn];
    
}

// 视频栏的筛选
- (void)videoSelect
{
    _videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    
    // 最新
    UILabel *news = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 34, 17)];
    news.text = @"最新";
    news.textColor = [UIColor whiteColor];
    [_videoView addSubview:news];
    
    // 360/IMAX
    _IMAXBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _IMAXBtn2.frame = CGRectMake(news.right + 30, news.top, 80, 17);
    [_IMAXBtn2 setTitle:@"360/IMAX" forState:UIControlStateNormal];
    [_IMAXBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_IMAXBtn2 addTarget:self action:@selector(IMAXBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    _IMAXBtn2.backgroundColor = RGB_COLOR(49, 176, 223, 1);
    _IMAXBtn2.layer.cornerRadius = 5;
    _IMAXBtn2.layer.masksToBounds = YES;
    [_videoView addSubview:_IMAXBtn2];
    
    // 360VR
    _D3Btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _D3Btn2.frame = CGRectMake(_IMAXBtn2.right + 10, news.top, 56, 17);
    [_D3Btn2 setTitle:@"360VR" forState:UIControlStateNormal];
    [_D3Btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_D3Btn2 addTarget:self action:@selector(D3Btn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_D3Btn2];
    
    // IMAX
    _IMAXBtn22 = [UIButton buttonWithType:UIButtonTypeSystem];
    _IMAXBtn22.frame = CGRectMake(_D3Btn2.right + 10, news.top, 50, 17);
    [_IMAXBtn22 setTitle:@"IMAX" forState:UIControlStateNormal];
    [_IMAXBtn22 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_IMAXBtn22 addTarget:self action:@selector(IMAXBtn22Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_IMAXBtn22];
    
    // 3D
    _D3Btn22 = [UIButton buttonWithType:UIButtonTypeSystem];
    _D3Btn22.frame = CGRectMake(_IMAXBtn22.right + 10, news.top, 34, 17);
    [_D3Btn22 setTitle:@"3D" forState:UIControlStateNormal];
    [_D3Btn22 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_D3Btn22 addTarget:self action:@selector(D3Btn22Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_D3Btn22];
    
    // 全部
    UILabel *all = [[UILabel alloc] initWithFrame:CGRectMake(30, news.bottom + 10, 34, 17)];
    all.text = @"全部";
    all.textColor = [UIColor whiteColor];
    [_videoView addSubview:all];
    
    // 恐怖
    _actionBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_actionBtn2 setTitle:@"恐怖" forState:UIControlStateNormal];
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_actionBtn2 addTarget:self action:@selector(actionBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_actionBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    _actionBtn2.frame = CGRectMake(all.right + 30, all.top, 30, 17);
    [_videoView addSubview:_actionBtn2];
    
    // 科幻
    _riskBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [_riskBtn2 setTitle:@"科幻" forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 addTarget:self action:@selector(riskBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    _riskBtn2.frame = CGRectMake(_actionBtn2.right + 10, all.top, 30, 17);
    [_videoView addSubview:_riskBtn2];
    
    // 喜剧
    _terrorBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _terrorBtn2.frame = CGRectMake(_riskBtn2.right + 10, all.top, 30, 17);
    [_terrorBtn2 setTitle:@"喜剧" forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 addTarget:self action:@selector(terrorBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_terrorBtn2];
    
    // 奇幻
    _taleBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _taleBtn2.frame = CGRectMake(_terrorBtn2.right + 10, all.top, 30, 17);
    [_taleBtn2 setTitle:@"奇幻" forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 addTarget:self action:@selector(taleBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_taleBtn2];
    
    // 热舞
    _loveBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _loveBtn2.frame = CGRectMake(_taleBtn2.right + 10, all.top, 30, 17);
    [_loveBtn2 setTitle:@"热舞" forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 addTarget:self action:@selector(loveBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_loveBtn2];
    
    // 动作
    _crimeBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _crimeBtn2.frame = CGRectMake(_loveBtn2.right + 10, all.top, 30, 17);
    [_crimeBtn2 setTitle:@"动作" forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 addTarget:self action:@selector(crimeBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_crimeBtn2];
    
    // 娱乐
    _SFBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _SFBtn2.frame = CGRectMake(_crimeBtn2.right + 10, all.top, 30, 17);
    [_SFBtn2 setTitle:@"娱乐" forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 addTarget:self action:@selector(SFBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_SFBtn2];
    
    // 汽车
    _comedyBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _comedyBtn2.frame = CGRectMake(_SFBtn2.right + 10, all.top, 30, 17);
    [_comedyBtn2 setTitle:@"汽车" forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 addTarget:self action:@selector(comedyBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_comedyBtn2];
    
    // 体育
    _PEBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _PEBtn2.frame = CGRectMake(_comedyBtn2.right + 10, all.top, 30, 17);
    [_PEBtn2 setTitle:@"体育" forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 addTarget:self action:@selector(PEBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_PEBtn2];
    
    // 游戏
    _gameBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _gameBtn2.frame = CGRectMake(_PEBtn2.right + 10, all.top, 30, 17);
    [_gameBtn2 setTitle:@"游戏" forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 addTarget:self action:@selector(gameBtn2Action) forControlEvents:UIControlEventTouchUpInside];
    [_videoView addSubview:_gameBtn2];
}

#pragma 筛选按钮点击事件
// 电影
- (void)IMAXBtnAction
{
    [_IMAXBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_D3Btn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
}

- (void)D3BtnAction
{
    [_IMAXBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_D3Btn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
}

- (void)actionBtnAction
{
    [_actionBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_riskBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_terrorBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_taleBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_loveBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_crimeBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_SFBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_comedyBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
}

- (void)riskBtnAction
{
    [_actionBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_riskBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_terrorBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_taleBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_loveBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_crimeBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_SFBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_comedyBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
}

- (void)terrorBtnAction
{
    [_actionBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_riskBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_terrorBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_taleBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_loveBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_crimeBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_SFBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_comedyBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
}

- (void)taleBtnAction
{
    [_actionBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_riskBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_terrorBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_taleBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_loveBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_crimeBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_SFBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_comedyBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
}

- (void)loveBtnAction
{
    [_actionBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_riskBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_terrorBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_taleBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_loveBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_crimeBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_SFBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_comedyBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
}

- (void)crimeBtnAction
{
    [_actionBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_riskBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_terrorBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_taleBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_loveBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_crimeBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_SFBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_comedyBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
}

- (void)SFBtnAction
{
    [_actionBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_riskBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_terrorBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_taleBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_loveBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_crimeBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_SFBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_comedyBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
}

- (void)comedyBtnAction
{
    [_actionBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_riskBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_terrorBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_taleBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_loveBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_crimeBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_SFBtn setTitleColor:RGB_COLOR(211, 209, 209, 1) forState:UIControlStateNormal];
    [_comedyBtn setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
}

// 视频
- (void)IMAXBtn2Action
{
    _IMAXBtn2.backgroundColor = RGB_COLOR(49, 176, 223, 1);
    _IMAXBtn2.layer.cornerRadius = 5;
    _IMAXBtn2.layer.masksToBounds = YES;
    _D3Btn2.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _D3Btn2.layer.cornerRadius = 5;
    _D3Btn2.layer.masksToBounds = YES;
    _IMAXBtn22.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _IMAXBtn22.layer.cornerRadius = 5;
    _IMAXBtn22.layer.masksToBounds = YES;
    _D3Btn22.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _D3Btn22.layer.cornerRadius = 5;
    _D3Btn22.layer.masksToBounds = YES;
    
}

- (void)D3Btn2Action
{
    _IMAXBtn2.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _IMAXBtn2.layer.cornerRadius = 5;
    _IMAXBtn2.layer.masksToBounds = YES;
    _D3Btn2.backgroundColor = RGB_COLOR(49, 176, 223, 1);
    _D3Btn2.layer.cornerRadius = 5;
    _D3Btn2.layer.masksToBounds = YES;
    _IMAXBtn22.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _IMAXBtn22.layer.cornerRadius = 5;
    _IMAXBtn22.layer.masksToBounds = YES;
    _D3Btn22.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _D3Btn22.layer.cornerRadius = 5;
    _D3Btn22.layer.masksToBounds = YES;

}

- (void)IMAXBtn22Action
{
    _IMAXBtn2.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _IMAXBtn2.layer.cornerRadius = 5;
    _IMAXBtn2.layer.masksToBounds = YES;
    _D3Btn2.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _D3Btn2.layer.cornerRadius = 5;
    _D3Btn2.layer.masksToBounds = YES;
    _IMAXBtn22.backgroundColor = RGB_COLOR(49, 176, 223, 1);
    _IMAXBtn22.layer.cornerRadius = 5;
    _IMAXBtn22.layer.masksToBounds = YES;
    _D3Btn22.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _D3Btn22.layer.cornerRadius = 5;
    _D3Btn22.layer.masksToBounds = YES;
}

- (void)D3Btn22Action
{
    _IMAXBtn2.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _IMAXBtn2.layer.cornerRadius = 5;
    _IMAXBtn2.layer.masksToBounds = YES;
    _D3Btn2.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _D3Btn2.layer.cornerRadius = 5;
    _D3Btn2.layer.masksToBounds = YES;
    _IMAXBtn22.backgroundColor = RGB_COLOR(4, 20, 44, 1);
    _IMAXBtn22.layer.cornerRadius = 5;
    _IMAXBtn22.layer.masksToBounds = YES;
    _D3Btn22.backgroundColor = RGB_COLOR(49, 176, 223, 1);
    _D3Btn22.layer.cornerRadius = 5;
    _D3Btn22.layer.masksToBounds = YES;
}

- (void)actionBtn2Action
{
    [_actionBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)riskBtn2Action
{
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)terrorBtn2Action
{
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)taleBtn2Action
{
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)loveBtn2Action
{
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)crimeBtn2Action
{
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)SFBtn2Action
{
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)comedyBtn2Action
{
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)PEBtn2Action
{
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)gameBtn2Action
{
    [_actionBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_riskBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_terrorBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_taleBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loveBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_crimeBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_SFBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comedyBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_PEBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_gameBtn2 setTitleColor:RGB_COLOR(49, 176, 223, 1) forState:UIControlStateNormal];
}

#pragma collectionView
// collectionView
static NSString *cellID = @"cellID";
- (void)drawCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置单元格尺寸
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 25, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 4 - 25 + SCREEN_HEIGHT / 6.9);
    _videoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242), SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9) collectionViewLayout:flowLayout];
    
    // 每行之间最小间距
    flowLayout.minimumLineSpacing = 30;
    // 每个item直接最小间距
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10);
    _videoCollectionView.dataSource = self;
    _videoCollectionView.delegate = self;
    [_backView addSubview:_videoCollectionView];
    
    // 添加背景
    _videoBack = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 5.242, SCREEN_HEIGHT / 5.9, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242), SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9)];
    UIImage *VideoImg = [UIImage imageNamed:@"bg_2.jpg"];
    _videoBack.image = VideoImg;
    _videoCollectionView.backgroundView = _videoBack;
    
//    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    _activity.center = _videoCollectionView.center;
//    [_videoBack addSubview:_activity];
//    [_activity startAnimating];
    
    // 注册
    [self.videoCollectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:cellID];
}

// 返回个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (num == 1) {
        // 设置尾部控件的显示和隐藏
        self.videoCollectionView.mj_footer.hidden = self.moviewArray.count == 0;
        return  self.moviewArray.count;
    
    } else {
        // 设置尾部控件的显示和隐藏
        self.videoCollectionView.mj_footer.hidden = self.videoArray.count == 0;
        return  self.videoArray.count;
    }
    return 0;
}

// 展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (num == 1) {
        VideoModel *model = self.moviewArray[indexPath.row];
        [cell setVideoModel:model];
    } else {
        VideoModel *model = self.videoArray[indexPath.row];
        [cell setVideoModel:model];

    }
    
    return cell;
    
}

// item点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AVPlayerViewController *avPlayerVC = [[AVPlayerViewController alloc] init];
    if (num == 1) {
        VideoModel *model = self.moviewArray[indexPath.row];
        avPlayerVC.playUrl = [NSString stringWithFormat:@"%@",model.downurl];
        avPlayerVC.titleName = [NSString stringWithFormat:@"%@",model.title];
        [self.navigationController pushViewController:avPlayerVC animated:NO];
    } else {
        VideoModel *model = self.videoArray[indexPath.row];
        avPlayerVC.playUrl = [NSString stringWithFormat:@"%@",model.downurl];
        avPlayerVC.titleName = [NSString stringWithFormat:@"%@",model.title];
        [self.navigationController pushViewController:avPlayerVC animated:NO];
    }

    
}

- (void)getMovieUrlPage:(NSString *)page
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/gameapi/movieonline",DEFAULT_SERVER_IP] params:@{@"classify":@"1",@"num":@"12",@"page":page} success:^(id responseObj) {
        NSDictionary *dic = responseObj;
        if ([dic[@"errno"] integerValue] == 20001) {
            self.videoCollectionView.mj_footer.hidden = YES;
            [MBProgressHUD showHUDWithMeg:@"无更多资源" toView:self.videoCollectionView];
        } else {
            NSArray *arr = dic[@"data"];
            for (NSDictionary *dict in arr) {
                VideoModel *model = [[VideoModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.moviewArray addObject:model];
            }
        }
        
//        [_activity stopAnimating];
        [self.videoCollectionView reloadData];
    } failure:^(NSError *error) {
        
    }];

}

- (void)getVideoUrlPage:(NSString *)page
{
    [HttpNetworkingTool post:[NSString stringWithFormat:@"%@api/gameapi/movieonline",DEFAULT_SERVER_IP] params:@{@"classify":@"0",@"num":@"12",@"page":page} success:^(id responseObj) {
        NSDictionary *dic = responseObj;
        if ([dic[@"errno"] integerValue] == 20001) {
            self.videoCollectionView.mj_footer.hidden = YES;
            [MBProgressHUD showHUDWithMeg:@"无更多资源" toView:_backView];
        } else {
            NSArray *arr = dic[@"data"];
            for (NSDictionary *dict in arr) {
                VideoModel *model = [[VideoModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.videoArray addObject:model];
            }
        }
        [self.videoCollectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
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
#pragma mark-lazy-
-(NSMutableArray*)moviewArray{
    if (_moviewArray==nil) {
        _moviewArray = [NSMutableArray new];
    }
    return _moviewArray;
}

-(NSMutableArray*)videoArray{
    if (_videoArray==nil) {
        _videoArray = [NSMutableArray new];
    }
    return _videoArray;
}


@end
