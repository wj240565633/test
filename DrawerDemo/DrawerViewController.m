//
//  DrawerViewController.m
//  DrawerDemo
//
//  Created by xalo on 16/1/30.
//  Copyright © 2016年 岳朝逢. All rights reserved.
//

#import "DrawerViewController.h"
#import "UIView+FrameExtension.h"
#import "MenuViewController.h"

@interface DrawerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL isSelectedMenu;// 是否点击了menu
@property (nonatomic, strong) UIViewController *menuVC;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *selectedVCDic;

@end

@implementation DrawerViewController

#pragma mark - 懒加载
- (NSMutableDictionary *)selectedVCDic {
    if (!_selectedVCDic) {
        self.selectedVCDic  =[NSMutableDictionary dictionary];
    }
    return _selectedVCDic;
}

#pragma mark - menuListVC的setter方法
- (void)setMenuListVC:(NSArray *)menuListVC {
    if (_menuListVC != menuListVC) {
        _menuListVC = menuListVC;
        UIViewController *vc1 = menuListVC.firstObject;
        [self setRootVC:vc1 isNeedNavi:YES];
        [self.selectedVCDic setValue:vc1 forKey:self.menuList[0]];
    }
}

#pragma mark - 菜单栏的setter方法
- (void)setMenuList:(NSArray *)menuList {
    if (_menuList != menuList) {
        _menuList = menuList;
        [self setMenuVCContent];
    }
}

#pragma mark - 根视图控制器的setter方法
- (void)setRootVC:(UIViewController *)rootVC {
    if (_rootVC != rootVC) {
        if (_rootVC) {
            [_rootVC removeFromParentViewController];
            [_rootVC.view removeFromSuperview];
        }
        _rootVC = rootVC;
        [self addChildViewController:_rootVC];
        _rootVC.view.frame = self.view.bounds;
        [self.view addSubview:_rootVC.view];
        if ([_rootVC isKindOfClass:[UINavigationController class]]) {
            [self setLeftButton];
        } else {
            [self addGestrueWithView:_rootVC.view];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSelectedMenu = NO;
    [self setLeftButton];
    [self setmenuViewController];
}

#pragma mark - 设置菜单的试图控制器
- (void)setmenuViewController {
    MenuViewController *menuVC = [[MenuViewController alloc] init];
    self.menuVC = menuVC;
    menuVC.view.frame = self.view.bounds;
    [self addChildViewController:menuVC];
    [self.view addSubview:menuVC.view];
}

#pragma mark - 设置左按钮
- (void)setLeftButton {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStyleDone target:self action:@selector(leftItemAction)];
    UINavigationController *navi = (UINavigationController *)self.rootVC;
    UIViewController *rootForNavi = navi.viewControllers.firstObject;
    rootForNavi.navigationItem.leftBarButtonItem = leftItem;
    [self addGestrueWithView:rootForNavi.view];
}

#pragma mark - 设置抽屉下的根视图控制器是否需要导航条
- (void)setRootVC:(UIViewController *)root isNeedNavi:(BOOL)isNeedNavi {
    // 如果需要导航条
    if (isNeedNavi) {
        // 创建一个导航条，并设置为根视图
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:root];
        self.rootVC = navi;
    } else {
        self.rootVC = root;
    }
}

#pragma mark - 菜单栏出现
- (void)setMenuAppearWithAnimation:(BOOL)isAnimation {
    if (isAnimation) {
        // 判断是否需要动画
        [UIView animateWithDuration:0.5 animations:^{
            // 根视图的frame的x向右移动150
            self.rootVC.view.x += 150;
        }];
    } else {
        self.rootVC.view.x += 150;
    }
    self.isSelectedMenu = YES;
}

#pragma mark - 菜单栏消失
- (void)setMenuDisappear {
    // 菜单消失的时候让其动画改变frame
    [UIView animateWithDuration:0.5 animations:^{
        self.rootVC.view.x -= 150;
    }];
    self.isSelectedMenu = NO;
}

#pragma mark - 左按钮的方法
- (void)leftItemAction {
    // 判断左按钮的状态让其调用不同的方法
    if (self.isSelectedMenu == NO) {
        [self setMenuAppearWithAnimation:YES];
    } else {
        [self setMenuDisappear];
    }
}

#pragma mark - 设置菜单控制器里的内容
- (void)setMenuVCContent {
    if (self.tableView == nil) {
        // 创建tableview的frame
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 150, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        [self.menuVC.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
}

#pragma mark - tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.menuList[indexPath.row]];
    return cell;
}

#pragma mark - tableViewDelegate
// 点击单元格方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出视图控制器数组中的某个视图
    UIViewController *vc = self.menuListVC[indexPath.row];
    // 得到对应的标记key值
    NSString *key = self.menuList[indexPath.row];
    // 得到字典的所有key值数组
    NSArray *keyArray = self.selectedVCDic.allKeys;
    // 判断数组内是否包含key值
    BOOL isAppear = [keyArray containsObject:key];
    if (isAppear) {
        // 如果包含，则获取对应的视图控制器
        UIViewController *vcInDic = self.selectedVCDic[key];
        // 设置根视图控制器
        [self setRootVC:vcInDic isNeedNavi:YES];
    } else {
        [self setRootVC:vc isNeedNavi:YES];
        [self.selectedVCDic setValue:vc forKey:key];
    }
    [self setMenuAppearWithAnimation:NO];
}

#pragma mark - 添加手势的方法
- (void)addGestrueWithView:(UIView *)view {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    // 设置轻扫手势的方向
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [view addGestureRecognizer:swipe];
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    // 设置轻扫手势的方向
    swipe1.direction = UISwipeGestureRecognizerDirectionLeft;
    [view addGestureRecognizer:swipe1];
}

#pragma mark - 边缘轻扫手势的方法
- (void)swipeAction:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.isSelectedMenu == NO) {
            [self setMenuAppearWithAnimation:YES];
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.isSelectedMenu == YES) {
            [self setMenuDisappear];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

@end
