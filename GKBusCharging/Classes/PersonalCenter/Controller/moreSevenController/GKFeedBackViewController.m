//
//  GKFeedBackViewController.m
//  GKBusCharging
//
//  Created by 王宁 on 2018/9/29.
//  Copyright © 2018年 goockr. All rights reserved.
//


#import "GKFeedBackViewController.h"

// Controllers
#import "GKNavigationController.h"
#import "DCGMScanViewController.h"
#import "JFCityViewController.h"
#import "SDCycleScrollView.h"
#import "GKFeedBackRecordViewController.h"

//#import "DCTabBarController.h"
////#import "DCRegisteredViewController.h"
// Models

// Views
//#import "DCAccountPsdView.h" //账号密码登录
////#import "DCVerificationView.h" //验证码登录
#import "GKPersonalHeaderView.h"
#import "GKCustomFlowLayout.h"
#import "GKFeedbackCell.h"

// Vendors

// Categories

#import "GKUpDownButton.h"
#import "DCZuoWenRightButton.h"
// Others
//#import "AFNetPackage.h"

#import "UITextView+ZWPlaceHolder.h"
#import <ZWLimitCounter/UITextView+ZWLimitCounter.h>

#define HeaderImageHeight ScreenW/2

#define kLineSpacing DCMargin/2

@interface GKFeedBackViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
{
    UILabel *titleHeaderLabel;
    DCZuoWenRightButton *feedbackRecordBtn;
//    UIButton *feedbackRecordBtn;
}

@property (nonatomic,strong) NSMutableArray *titleListArray;

@property (nonatomic,strong) NSMutableArray *imagesListArray;



//@property (strong, nonatomic) GKCustomFlowLayout *flowLayout;

@property(nonatomic,strong) UICollectionView *collectionView;


@property (nonatomic,strong) UIView *writeToInfoview;
@property (nonatomic ,strong) UIButton *endingBtn;
@property (nonatomic, assign) Boolean isCommitOrNot;

@property (nonatomic,strong) UITextView *opinionContentTV;
@property (nonatomic,strong) UITextField * phoneTF;
@property (nonatomic,strong) UITextField * nameTF;



@end

@implementation GKFeedBackViewController
#pragma mark - LazyLoad

- (void)loadCollectionView
{
    
    /**
     创建layout
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    /**
     创建collectionView
     */
    UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH-64) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor cyanColor];
    /**
     注册item和区头视图、区尾视图
     */
    [collectionView registerClass:[GKFeedbackCell class] forCellWithReuseIdentifier:@"GKFeedbackCell"];
    //    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyCollectionViewHeaderView"];
    //    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"MyCollectionViewFooterView"];
    [self.view addSubview:collectionView];
    //    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    ////        make.top.mas_equalTo(headerView.mas_bottom).with.offset(FixHeightNumber(10));
    //        make.top.mas_equalTo(self.view).with.offset(K_HEIGHT_NAVBAR+(ScreenH-K_HEIGHT_NAVBAR)/4+DCMargin);
    //        make.left.right.equalTo(self.view);
    //        make.height.mas_equalTo(SCREEN_HEIGHT - K_HEIGHT_STATUSBAR - K_HEIGHT_NAVBAR);
    //    }];
    //    self.collectionView = collectionView;
    
    //    self.flowLayout = [[GKCustomFlowLayout alloc] init];
    ////    _customLayout = [[UICollectionViewLayout alloc] init]; // 自定义的布局对象
    //    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    //    _collectionView.backgroundColor = [UIColor whiteColor];
    //    _collectionView.dataSource = self;
    //    _collectionView.delegate = self;
    //    [self.view addSubview:_collectionView];
    //
    // 注册cell、sectionHeader、sectionFooter
    //    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:GKFeedbackCell];
    //    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    //    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
}

- (void)loadCollectionView2{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake(110, 150);
    //2.初始化collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor redColor];
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [collectionView registerClass:[GKFeedbackCell class] forCellWithReuseIdentifier:@"cellId"];
    
    //4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self getUI];
    [self getData];
}

- (void)getUI{
    
    titleHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    feedbackRecordBtn = [[DCZuoWenRightButton alloc]initWithFrame:CGRectMake(ScreenW - 80, 5, 100, 20)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.collectionView.backgroundColor = TABLEVIEW_BG;
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //设置headerView的尺寸大小
    //layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    //layout.itemSize =CGSizeMake(110, 150);
    
    layout.sectionInset =UIEdgeInsetsMake(0, 0, 0, 0);
    layout.headerReferenceSize =CGSizeMake(ScreenW, 40*ScreenH/667);
    
    //2.初始化collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = RGB(248, 248, 248);
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [collectionView registerClass:[GKFeedbackCell class] forCellWithReuseIdentifier:@"cellId"];
    
    // 注册头视图
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    collectionView.scrollEnabled = NO;
    collectionView.allowsSelection = YES;
    //4.设置代理
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.collectionView = collectionView;
    
    UIView *writeToInfoview = [[UIView alloc]init];
    [self.view addSubview:writeToInfoview];
    [writeToInfoview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(K_HEIGHT_NAVBAR+40+(ScreenH-K_HEIGHT_NAVBAR - DCMargin)/4*9/5);
        make.left.right.equalTo(self.view);
//        make.bottom.equalTo(self.view).offset(-80);
        make.bottom.equalTo(self.view);
    }];
    [writeToInfoview setBackgroundColor:[UIColor whiteColor]];
    [writeToInfoview setHidden:true];
    self.writeToInfoview = writeToInfoview;
    
    //先布局evaluationContentTF评价内容
    UITextView *opinionContentTV = [[UITextView alloc]init];
    [writeToInfoview addSubview:opinionContentTV];
    [opinionContentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(writeToInfoview);
        make.centerY.equalTo(writeToInfoview).offset(8);
        make.width.mas_equalTo(ScreenW-30);
        //        make.height.mas_equalTo(evaluateFooterView.bounds.size.height/2);
        make.height.mas_equalTo(120);
    }];
    opinionContentTV.dataDetectorTypes = UIDataDetectorTypePhoneNumber | UIDataDetectorTypeLink;
    opinionContentTV.backgroundColor = TABLEVIEW_BG;
    opinionContentTV.textColor = [UIColor darkGrayColor];
//    opinionContentTV.text = @"请输入您宝贵的意见.....";
    opinionContentTV.font = [UIFont systemFontOfSize:15.0];
    opinionContentTV.layer.cornerRadius = 6.0;
    opinionContentTV.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    opinionContentTV.layer.borderWidth = 1 / ([UIScreen mainScreen].scale);
    //提示文字及字数统计
    opinionContentTV.zw_placeHolder = @"请输入您宝贵的意见.....";
    opinionContentTV.zw_limitCount = 60;
    opinionContentTV.zw_placeHolderColor = RGBall(204);
    [opinionContentTV.zw_inputLimitLabel setHidden:true];
    self.opinionContentTV = opinionContentTV;
    
    //////
    
    UIView * nameView = [UIView new];
    [writeToInfoview addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(writeToInfoview).with.offset(2);
//        make.left.right.equalTo(writeToInfoview);
        make.left.equalTo(writeToInfoview.mas_left).offset(15);
        make.right.equalTo(writeToInfoview.mas_right).offset(-15);
        make.height.mas_equalTo(30);
    }];
    nameView.backgroundColor = TABLEVIEW_BG;
    
    UILabel * nameTitleLabel = [UILabel new];
    [nameView addSubview:nameTitleLabel];
    [nameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(nameView.mas_left).with.offset(FixWidthNumber(17.5));
        make.left.mas_equalTo(nameView.mas_left).with.offset(15);
        make.centerY.equalTo(nameView);
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
    [nameTitleLabel setText:@"联系人"];
    [nameTitleLabel setFont:GKFont(14)];
    nameTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView * lineView = [UIView new];
    [nameView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameTitleLabel.mas_right).with.offset(12);
//        make.right.equalTo(nameView).with.offset(-15);
        make.centerY.equalTo(nameView);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(1);
    }];
    lineView.backgroundColor = UIColorFromHex(0xF0F0F0);
    
    UITextField * nameTF = [UITextField new];
    [nameView addSubview:nameTF];
    [nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right).with.offset(12);
        make.right.mas_equalTo(nameView).with.offset(-15);
        make.height.centerY.equalTo(nameView);
    }];
    nameTF.placeholder = @"姓名";
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTF.font = GKMediumFont(13);
    self.nameTF = nameTF;
    
    
    
    
    UIView * phoneView = [UIView new];
    [writeToInfoview addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(nameView);
        make.top.mas_equalTo(nameView.mas_bottom).offset(3);
//        make.bottom.mas_equalTo(opinionContentTV.mas_top).offset(-3);
    }];
    phoneView.backgroundColor = TABLEVIEW_BG;
//    self.phoneView = phoneView;
    UILabel * phoneTitleLabel = [UILabel new];
    [phoneView addSubview:phoneTitleLabel];
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(nameView.mas_left).with.offset(FixWidthNumber(17.5));
        make.left.mas_equalTo(phoneView.mas_left).with.offset(15);
        make.centerY.equalTo(phoneView);
        make.size.mas_equalTo(CGSizeMake(60, 22));
    }];
    [phoneTitleLabel setText:@"联系方式"];
    [phoneTitleLabel setFont:GKFont(14)];
    phoneTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    UIView * phoneLineView = [UIView new];
    [phoneView addSubview:phoneLineView];
    [phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneTitleLabel.mas_right).with.offset(12);
        //        make.right.equalTo(nameView).with.offset(-15);
        make.centerY.equalTo(phoneView);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(1);
    }];
    phoneLineView.backgroundColor = UIColorFromHex(0xF0F0F0);
    
   
    
    UITextField * phoneTF = [UITextField new];
    [phoneView addSubview:phoneTF];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLineView.mas_right).with.offset(12);
        make.right.mas_equalTo(nameView).with.offset(-15);
        make.height.centerY.equalTo(phoneView);
    }];
    phoneTF.placeholder = @"手机/QQ/邮箱";
    phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTF.font = GKMediumFont(13);
    self.phoneTF = phoneTF;
    
    ////////////
    
    UIButton *endingBtn = [[UIButton alloc]init];
    [self.view addSubview:endingBtn];
    [endingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-8);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(307, 44));
    }];
    [endingBtn addTarget:self action:@selector(endingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [endingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//0xFCE9B
    [endingBtn setTitle:@"提交" forState:UIControlStateNormal];
    [endingBtn setBackgroundImage:SETIMAGE(@"btn_5_disabled") forState:UIControlStateDisabled];
    [endingBtn setBackgroundImage:SETIMAGE(@"btn_5_normal") forState:UIControlStateNormal];
    endingBtn.enabled = NO;
    self.endingBtn = endingBtn;
    
    [self.nameTF addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
    [self.phoneTF addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingChanged];
}

- (void)updataUI{
    [self.endingBtn setTitle:@"返回首页" forState: UIControlStateNormal];
}

- (void)getData{
    [self getDataFromPlist];
    self.isCommitOrNot = false;
}

- (void)getDataFromPlist{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"FeedBackMenu" ofType:@"plist"];
    
    // [NSBundle mainBundle] 关联的就是项目的主资源包
    //    NSBundle *bundle = [NSBundle mainBundle];
    // 利用mainBundle 获得plist文件在主资源包中的全路径
    //    NSString *file = [bundle pathForResource:@"shops" ofType:@"plist"];
    // 凡是参数名为File，传递的都是文件的全路径
    NSArray *datasArray = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *titleListMuArray = [NSMutableArray new];
    NSMutableArray *imagesListMuArray = [NSMutableArray new];
    for (NSMutableDictionary *dic in datasArray) {
        [titleListMuArray addObject:dic[@"titleName"]];
        [imagesListMuArray addObject:dic[@"imageName"]];
//        NSLog(@"dic[@'titleName'] = %@,dic[@'imageName‘] = %@",dic[@"titleName"],dic[@"imageName"]);
    }
    self.titleListArray = [titleListMuArray copy];
    self.imagesListArray = [imagesListMuArray copy];
    
    //    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GKFeedbackCell *cell = (GKFeedbackCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.titleTV.text = [self.titleListArray objectAtIndex:indexPath.row];
    [cell.gridImageView setImage:[UIImage imageNamed:[self.imagesListArray objectAtIndex:indexPath.row]]];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW/2 - 2, (ScreenH-K_HEIGHT_NAVBAR - DCMargin)/4*3/5);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(ScreenW,40*ScreenH/667);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
#pragma mark ----- 重用的问题
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    header.backgroundColor = RGB(236, 237, 241);
    if (indexPath.section == 0) {
        titleHeaderLabel.text = @"故障描述";
        titleHeaderLabel.font = [UIFont systemFontOfSize:17.0f];
        titleHeaderLabel.textColor = RGB(88, 79, 96);
        [header addSubview:titleHeaderLabel];
//        feedbackRecordBtn.titleLabel.text = @"反馈记录>";
        feedbackRecordBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
        [feedbackRecordBtn setTitle:@"反馈记录" forState:UIControlStateNormal];
        [feedbackRecordBtn setImage:SETIMAGE(@"btn_more_small") forState:UIControlStateNormal];
        feedbackRecordBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [feedbackRecordBtn setTitleColor:RGB(88, 79, 96) forState:UIControlStateNormal];
//        feedbackRecordBtn.titleLabel.textColor = RGB(88, 79, 96);
//        [feedbackRecordBtn setImage:[UIImage imageNamed:@"home_icon_page_more"] forState:UIControlStateNormal];
        [feedbackRecordBtn addTarget:self action:@selector(feedbackRecordBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:feedbackRecordBtn];
        
        [titleHeaderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.navigationController.navigationBar.mas_bottom);
            make.centerY.equalTo(header);
            make.left.mas_equalTo(self.view).offset(4);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        [feedbackRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self->titleHeaderLabel);
            make.centerY.equalTo(header);
            make.right.mas_equalTo(self.view.mas_right).offset(-4);;
            make.width.equalTo(@70);
            make.height.equalTo(@20);
        }];
        
    }else{
        
//        labelTwo.text = @"疾病信息";
//        labelTwo.font = [UIFont systemFontOfSize:14.0f];
//        labelTwo.textColor = MainRGB;
//        [header addSubview:labelTwo];
        
    }
    return header;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    //    GKBaseSetViewController *vc = [[GKBaseSetViewController alloc]init];
    [self reloadDatasAndTable:indexPath];
}

//刷新 tabView 的选择状态
-(void)reloadDatasAndTable:(NSIndexPath *)indexPath{
    for (int i = 0; i<6; i++) {
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:i inSection:0];
        GKFeedbackCell *cell = (GKFeedbackCell *)[self.collectionView cellForItemAtIndexPath:indexPath2];
        if (i == indexPath.row) {
            cell.selected = true;
            cell.backgroundColor = RGB(212, 245, 234);
            cell.titleTV.backgroundColor = RGB(212, 245, 234);
        }else{
            cell.selected = false;
            cell.backgroundColor = Main_Color;
            cell.titleTV.backgroundColor = Main_Color;
        }
    }
    //点击collectionView 后 writeToInfoview 的显示
    [self.writeToInfoview setHidden:false];
    if (indexPath.row != 4) {
        [self.opinionContentTV setHidden:true];
        [self.opinionContentTV.zw_inputLimitLabel setHidden:true];
    }else{
        [self.opinionContentTV setHidden:false];
        [self.opinionContentTV.zw_inputLimitLabel setHidden:false];
    }
}


#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_nameTF.text.length != 0 && _phoneTF.text.length != 0) {
        //        _loginButton.backgroundColor = RGB(252, 159, 149);
        self.endingBtn.enabled = YES;
    }else{
        //        _loginButton.backgroundColor = [UIColor lightGrayColor];
        self.endingBtn.enabled = NO;
    }
}
#pragma mark - 自定义方法
- (void)feedbackRecordBtnAction{
//    NSLog(@"feedbackRecordBtnAction!!!");
    GKFeedBackRecordViewController *vc = [GKFeedBackRecordViewController new];
    vc.title = @"反馈记录";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)endingBtnAction{
    if (self.isCommitOrNot) {
//        [self.navigationController popViewControllerAnimated:YES];
        //返回根视图
        [self.navigationController popToRootViewControllerAnimated:YES];
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];//返回计数为1的页面
        return;
    }
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

-(void)againCommitFeedback{
    [SVProgressHUD showWithStatus:@"正在提交中，请稍后..."];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//        [DCObjManager dc_saveUserData:@"0" forKey:@"isWorking"];
//        [self updataUI];
//        self.isCommitOrNot = true;
//        [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
//        //弹窗评价窗口
//    });
    NSDictionary *dict=@{
                         @"devid":@"9999887712345613",
                         @"cabid":@"4e3937313233341315363137",
                         @"types":@"1",
                         @"msg":@"提交错误信息iOS端测试内容！！！",
                         @"lend":@"37823"    //必填 若报障充电线处于放电状态默认‘lend’字符串 其他状态默认‘ok’字符串
                         };
    [GCHttpDataTool uploadFaultInfoWithDict:dict success:^(id responseObject) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
            
        });
    } failure:^(MQError *error) {
        [SVProgressHUD showErrorWithStatus:error.msg];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
