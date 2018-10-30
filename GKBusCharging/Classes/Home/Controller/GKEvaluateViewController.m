//
//  GKEvaluateViewController.m
//  GKBusCharging
//
//  Created by L on 2018/10/25.
//  Copyright © 2018年 goockr. All rights reserved.
//

#import "GKEvaluateViewController.h"
#import "GKPriceEvaluationView.h"
#import "GKStarAndLabellingEvaluationView.h"
#import "GKStarAndLabellingEvaluationView2.h"
#import "GKOrderDetailsViewController.h"
#import "GKReturnGuideView01.h"
#import "GKReturnGuideView02.h"

#import "DCNewFeatureCell.h"
#import "DCNewFeatureCell2.h"
@interface GKEvaluateViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionview */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 图片数组 */
@property (nonatomic, copy) NSArray *imageArray;
/** 是否显示跳过按钮, 默认不显示 */
//@property (nonatomic, assign) BOOL showSkip;
/** 是否显示page小圆点, 默认不显示 */
@property (nonatomic, assign) BOOL showPageCount;

/* 小圆点选中颜色 */
@property (nonatomic, strong) UIColor *selColor;
/* 跳过按钮 */
@property (nonatomic, strong) UIButton *skipButton;

/* page */
@property (strong , nonatomic)UIPageControl *pageControl;

@property (nonatomic,strong) GKPriceEvaluationView *priceEvaluationView;
@property (nonatomic,strong) GKStarAndLabellingEvaluationView2 *starAndLabellingEvaluationView2;

@property (nonatomic,strong) GKReturnGuideView01 *returnGuideView01;
@property (nonatomic,strong) GKReturnGuideView02 *returnGuideView02;

//【感谢评价】的 view
@property (nonatomic,strong) UIView *bgView;
@end
static NSString *const DCNewFeatureCellID = @"DCNewFeatureCell";
static NSString *const DCNewFeatureCellID2 = @"DCNewFeatureCell2";
@implementation GKEvaluateViewController
#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        dcFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = [UIScreen mainScreen].bounds;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
//        [self.view insertSubview:_collectionView atIndex:0];
        [_collectionView registerClass:[DCNewFeatureCell class] forCellWithReuseIdentifier:DCNewFeatureCellID];
        [_collectionView registerClass:[DCNewFeatureCell2 class] forCellWithReuseIdentifier:DCNewFeatureCellID2];
    }
    return _collectionView;
}

- (UIButton *)skipButton
{
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.frame = CGRectMake(ScreenW - 85, 30, 65, 30);
//        [_skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _skipButton.hidden = YES;
        _skipButton.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.8];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _skipButton.layer.cornerRadius = 15;
        _skipButton.layer.masksToBounds = YES;
        [_skipButton setHidden:true];
        [self.view addSubview:_skipButton];
    }
    return _skipButton;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl && _imageArray.count != 0) {
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = _imageArray.count;
        _pageControl.userInteractionEnabled = false;
        [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
        UIColor *currColor = (_selColor == nil) ? [UIColor darkGrayColor] : _selColor;
        [self.pageControl setCurrentPageIndicatorTintColor:currColor];
        _pageControl.frame = CGRectMake(0, ScreenH * 0.95, ScreenW, 35);
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:TABLEVIEW_BG];
    self.title = @"评价";
    [self setUI];
    [self addObserver];
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"TEST" style:UIBarButtonItemStyleDone target:self action:@selector(show)];
//    [self.navigationItem setRightBarButtonItem:btn];
    
}

-(void)setUI{
    _priceEvaluationView = [GKPriceEvaluationView dc_viewFromXib];
    [self.view addSubview:_priceEvaluationView];
    _priceEvaluationView.frame = CGRectMake(0, K_HEIGHT_NAVBAR, ScreenW, (ScreenH-K_HEIGHT_NAVBAR)/2);
    [_priceEvaluationView.cheackDetailsBtn addTarget:self action:@selector(cheackDetailsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _starAndLabellingEvaluationView2 = [GKStarAndLabellingEvaluationView2 dc_viewFromXib];
    [self.view addSubview:_starAndLabellingEvaluationView2];
    [_starAndLabellingEvaluationView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceEvaluationView.headerView.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.height.mas_offset((ScreenH-K_HEIGHT_NAVBAR)/2-self.priceEvaluationView.headerView.frame.size.height);
    }];
    [_starAndLabellingEvaluationView2 setHidden:true];
    [_starAndLabellingEvaluationView2.commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
    /*余下背景图变色*/
    UIView *lastView = [[UIView alloc]init];
    [lastView setBackgroundColor:Main_Color];
    [self.view addSubview:lastView];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceEvaluationView.mas_bottom).offset(1);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    //归还指南
    UILabel *returnGuideLabel = [[UILabel alloc]init];
    [returnGuideLabel setText:@"归还指南"];
    [returnGuideLabel setFont:GKFont(12)];
    [returnGuideLabel setTextColor:TEXTMAINCOLOR];
    [self.view addSubview:returnGuideLabel];
    [returnGuideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
//        make.centerY.mas_equalTo((ScreenH-K_HEIGHT_NAVBAR)/2).offset(0);
//        make.centerY.mas_equalTo(self.view).offset(K_HEIGHT_NAVBAR);
        make.centerY.mas_equalTo(self.priceEvaluationView.mas_bottom).offset(K_HEIGHT_NAVBAR/2);
        make.size.mas_equalTo(CGSizeMake(50, 17));
    }];
    //分割线
    UIView *lineView01 = [[UIView alloc]init];
    UIView *lineView02 = [[UIView alloc]init];
    [self.view addSubview:lineView01];
    [self.view addSubview:lineView02];
    [lineView01 setBackgroundColor:TABLEVIEW_BG];
    [lineView02 setBackgroundColor:TABLEVIEW_BG];
    [lineView01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(self.view).offset(15);
        make.right.mas_equalTo(returnGuideLabel.mas_left).offset(-15);
        make.centerY.equalTo(returnGuideLabel);
    }];
    [lineView02 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.right.equalTo(self.view).offset(-15);
        make.left.mas_equalTo(returnGuideLabel.mas_right).offset(15);
        make.centerY.equalTo(returnGuideLabel);
    }];
    
//    _returnGuideView01 = [[GKReturnGuideView01 alloc] init];
//    [self.view addSubview:_returnGuideView01];
//    [_returnGuideView01 mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(returnGuideLabel.mas_bottom).offset(40);
//        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-40);
//        make.left.mas_equalTo(self.view).offset(10);
//        make.right.mas_equalTo(self.view).offset(-10);
////        make.height.equalTo(@220);
//        make.height.equalTo(@0);
////        make.height.mas_offset((ScreenH-K_HEIGHT_NAVBAR)/2-self.priceEvaluationView.headerView.frame.size.height);
//    }];
    self.imageArray = @[@"guide1",@"guide2"];
//    self.showSkip = YES;
    self.showPageCount = YES;
    [self.skipButton setTitle:@"跳过" forState:0];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //    self.automaticallyAdjustsScrollViewInsets = false;
    [lastView addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
//        make.centerY.equalTo(lastView).offset(K_HEIGHT_NAVBAR);
        make.height.mas_equalTo(lastView.mas_height).offset(-K_HEIGHT_NAVBAR);
        //        make.height.equalTo(@0);
    }];
}



#pragma mark - 基础设置
//- (void)setUpFeatureAttribute:(void(^)(NSArray **imageArray,UIColor **selColor,BOOL *showSkip,BOOL *showPageCount))BaseSettingBlock{
//
//    NSArray *imageArray;
//    UIColor *selColor;
//    BOOL showSkip;
//    BOOL showPageCount;
//    if (BaseSettingBlock) {
//        BaseSettingBlock(&imageArray,&selColor,&showSkip,&showPageCount);
////        self.imageArray = imageArray;
//        self.selColor = selColor;
////        self.showSkip = showSkip;
//        self.showPageCount = showPageCount;
//    }
//}


#pragma mark - 是否展示page小圆点
- (void)setShowPageCount:(BOOL)showPageCount
{
    _showPageCount = showPageCount;
    self.pageControl.hidden = !self.showPageCount;
}

-(void)updateUI{
    //移除第二页的评价窗口
    [self.starAndLabellingEvaluationView2 removeFromSuperview];
    //第一页面评价窗口状态发生改变
    self.priceEvaluationView.starView.actualScore = 4;
//    self.priceEvaluationView.starView.isVariable = NO;
    [self.priceEvaluationView.starView removeGestureRecognizer];
    [self.priceEvaluationView.completedEvaluationLabel setHidden:false];
}

- (void) addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starIsChangedAction) name:@"starIsChanged" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//感谢评价的 View
-(void)setUIEndView{
    
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.bgView = bgView;
    [self setKeyBoardListener];
    //整体的布局view
    UIView *mainView = [UIView new];
    [bgView addSubview:mainView];
    [mainView setBackgroundColor:[UIColor whiteColor]];
    [mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView).mas_offset(0);
        make.left.mas_equalTo(bgView.mas_left).with.offset(ScreenW/10);
        make.right.mas_equalTo(bgView.mas_right).with.offset(-ScreenW/10);
        //        make.height.mas_equalTo(mainView.mas_width);
        make.height.mas_equalTo(ScreenH/4);
        //make.width.mas_equalTo(200);
    }];
    mainView.layer.masksToBounds = YES;
    mainView.layer.cornerRadius = 8;
    mainView.userInteractionEnabled = NO;
    //image
    UIImageView *imageView = [[UIImageView alloc]initWithImage:SETIMAGE(@"icon_thanks_evaluate")];
    [mainView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mainView);
        make.centerY.equalTo(mainView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(52, 52));
    }];
    //label
    UILabel *textLabel = [[UILabel alloc]init];
    [textLabel setText:@"感谢评价"];
    [textLabel setFont:GKFont(14)];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [textLabel setTextColor:TEXTGRAYCOLOR];
    [mainView addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mainView.mas_centerY).offset(30);
        make.centerX.equalTo(mainView);
        make.size.mas_equalTo(CGSizeMake(88, 20));
    }];
    
    
}

-(void)close{
    [self.bgView removeFromSuperview];
}
//点击空白处的点击事件
/**
 *  @author 洛忆, 18-10-12 18:09:58
 *
 *  给当前view添加手势识别
 */
- (void)setKeyBoardListener
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(screenClick)];
    [self.bgView addGestureRecognizer:recognizer];
}

/**
 *  @author 洛忆, 18-10-12 18:09:32
 *
 *  点击屏幕预备 removeFromSuperview
 */
- (void)screenClick
{
    [self close];
}

#pragma mark - LifeCyle

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *newCell = [UICollectionViewCell new];
    if (indexPath.row == 0) {
        DCNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCNewFeatureCellID forIndexPath:indexPath];
        newCell = cell;
        return cell;
    }else{
        DCNewFeatureCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCNewFeatureCellID2 forIndexPath:indexPath];
        newCell = cell;
        return cell;
    }
    
    return newCell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW, ScreenH);
}

#pragma mark - 通过代理来让她滑到最后一页再左滑动就切换控制器
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_imageArray.count < 2) return; //一张图或者没有直接返回
    //    _collectionView.bounces = (scrollView.contentOffset.x > (_imageArray.count - 2) * ScreenW) ? YES : NO;
    //    if (scrollView.contentOffset.x >  (_imageArray.count - 1) * ScreenW) {
    //        [self restoreRootViewController:[[GFTabBarController alloc] init]];
    //    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (!_showPageCount) return;
    CGPoint currentPoint = scrollView.contentOffset;
    //    NSInteger page = currentPoint.x / scrollView.dc_width;
    NSInteger page = currentPoint.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
}

- (void)restoreRootViewController:(UIViewController *)rootViewController {
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.7f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
        
    } completion:nil];
}






#pragma mark -页面逻辑方法
#pragma mark -点击事件的方法
// 点击【查看明细】
-(void)cheackDetailsBtnAction{
    [self.navigationController pushViewController:[GKOrderDetailsViewController new] animated:YES];
}
//点击【星星✨】
- (void)starIsChangedAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat actualScore = self.priceEvaluationView.actualScore;
        [self.starAndLabellingEvaluationView2 setHidden:false];
        self.starAndLabellingEvaluationView2.actualScore = actualScore;
        self.starAndLabellingEvaluationView2.starView.actualScore = actualScore;
    });
}
//点击提交【匿名评价】
-(void)commitBtnAction{
    [SVProgressHUD showWithStatus:@"正在提交中，请稍后..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"     " andMessage:@"提交失败，请重新提交"];
        [alertView addButtonWithTitle:@"返回"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  [alertView dismissAnimated:NO];
                              }];
        [alertView addButtonWithTitle:@"重新提交"
                                 type:SIAlertViewButtonTypeDestructive
                              handler:^(SIAlertView *alertView) {
                                  [alertView dismissAnimated:NO];
                                  [self againCommitFeedback];
                              }];
        [alertView show];
    });
}
//点击【再次提交】
-(void)againCommitFeedback{
    [SVProgressHUD showWithStatus:@"正在提交中，请稍后..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
//        [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
        [self setUIEndView];
        [self updateUI];
    });
}

-(void)show{
    [_starAndLabellingEvaluationView2 setHidden:false];
}






@end

