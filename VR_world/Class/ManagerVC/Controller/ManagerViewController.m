//
//  ManagerViewController.m
//  VR_world
//
//  Created by davysen on 16/3/25.
//  Copyright © 2016年 davysen. All rights reserved.
//

#import "ManagerViewController.h"
#import "ManagerCell.h"
#import "VersionInfoViewController.h"
#import "UserFeedbackViewController.h"
#import "UseinStructionViewController.h"
#import "OnlineStoreViewController.h"
#import "DownloadListViewController.h"

@interface ManagerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *navImgView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ManagerViewController

static NSString *cellID = @"cellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawCollectionView];
}

- (void)drawCollectionView
{
    // 创建导航栏view
    _navImgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 5.242, 0, SCREEN_WIDTH - SCREEN_WIDTH / 5.242, SCREEN_HEIGHT / 5.9)];
    UIImage *img = [UIImage imageNamed:@"bg_titlebar.png"];
    _navImgView.image = img;
    [self.view addSubview:_navImgView];
    _navImgView.userInteractionEnabled = YES;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置单元格尺寸
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - SCREEN_WIDTH / 5.242) / 2 - 15, SCREEN_HEIGHT / 5.175);
    // 每行之间最小间距
    flowLayout.minimumLineSpacing = 5;
    // 每个item直接最小间距
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.sectionInset = UIEdgeInsetsMake(SCREEN_HEIGHT /8.28, 10, SCREEN_HEIGHT / 13.8, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 5.242, _navImgView.bottom, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242), SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9) collectionViewLayout:flowLayout];
    [self.view addSubview:_collectionView];
    UIImageView *collBack = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 5.242, _navImgView.bottom, (SCREEN_WIDTH - SCREEN_WIDTH / 5.242), SCREEN_HEIGHT - SCREEN_HEIGHT / 5.9)];
    UIImage *collImg = [UIImage imageNamed:@"bg_2.jpg"];
    collBack.image = collImg;
    _collectionView.backgroundView = collBack;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[ManagerCell class] forCellWithReuseIdentifier:cellID];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ManagerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5;
    if (indexPath.row == 0) {
        cell.icon.image = [UIImage imageNamed:@"xiazai"];
        cell.title.text = @"下载任务列表";
    } else if (indexPath.row == 1) {
        cell.title.text = @"使用说明";
        cell.icon.image = [UIImage imageNamed:@"shuoming"];
    } else if (indexPath.row == 2) {
        cell.title.text = @"版本信息";
        cell.icon.image = [UIImage imageNamed:@"banbenxinxi"];
    } else if (indexPath.row == 3) {
        cell.title.text = @"网上商店";
        cell.icon.image = [UIImage imageNamed:@"shangdian"];
    } else if (indexPath.row == 4) {
        cell.title.text = @"用户反馈";
        cell.icon.image = [UIImage imageNamed:@"fankui"];
    }
    return cell;
}

// 点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        DownloadListViewController *downloadVC = [[DownloadListViewController alloc] init];
        [self.navigationController pushViewController:downloadVC animated:YES];
        
    } else if (indexPath.row == 1) {
        
        UseinStructionViewController *useStructVC = [UseinStructionViewController new];
        [self.navigationController pushViewController:useStructVC animated:YES];
        
    } else if (indexPath.row == 2) {
        
        VersionInfoViewController *verSionInfoVC = [[VersionInfoViewController alloc] init];
        [self.navigationController pushViewController:verSionInfoVC animated:YES];
        
    } else if (indexPath.row == 3) {
        
        OnlineStoreViewController *onlineStoreVC = [OnlineStoreViewController new];
        [self.navigationController pushViewController:onlineStoreVC animated:YES];
        
    } else if (indexPath.row == 4) {
        
        UserFeedbackViewController *userBackFeedVC = [[UserFeedbackViewController alloc] init];
        [self.navigationController pushViewController:userBackFeedVC animated:YES];
        
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
