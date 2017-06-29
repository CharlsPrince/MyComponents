//
//  HYCViewController.m
//  MyComponents
//
//  Created by CharlsPrince on 06/26/2017.
//  Copyright (c) 2017 CharlsPrince. All rights reserved.
//

#import "HYCViewController.h"
#import <MyComponents/MyComponents.h>

@interface TObject : NSObject

@property (nonatomic, assign) int currentIndex;
@property (nonatomic, assign) int cIndex;

- (void)start;

@end

@implementation TObject

- (void)start {
    [NSTimer scheduledTimerWithTimeInterval:.5f repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.currentIndex ++;
        self.cIndex ++;
        if (self.currentIndex >= 10) {
            [self easy_removeAllObservers];
            [timer invalidate];
        }
    }];
}

-(void)dealloc {
    NSLog(@"销毁");
//    [self easy_removeAllObservers];
}

@end

@interface HYCViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *viewControllers;
@end

@implementation HYCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"组件库";
    
    TestObject *obj = [[TestObject alloc] init];
    [obj sayHello];
    
    TObject *t = [[TObject alloc] init];
    t.currentIndex = 0;
    [t start];
    
    TObject *b = [[TObject alloc] init];
    b.currentIndex = 0;
    [b start];
    
    [t easy_addObserver:self forKeyPath:@"currentIndex" easyBlock:^(id oldValue, id newValue) {
        NSLog(@"%@---%@",oldValue,newValue);
    }];
    
    
    [b easy_addObserver:self forKeyPath:@"currentIndex" easyBlock:^(id oldValue, id newValue) {
        NSLog(@"%@+++%@",oldValue,newValue);
    }];
    
    [b easy_addObserver:obj forKeyPath:@"currentIndex" easyBlock:^(id oldValue, id newValue) {
        NSLog(@"%@++++++%@",oldValue,newValue);
    }];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:_tableView];
    
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    
    _viewControllers = @[
                         @[@{@"class":@"HYCRewardSuccessViewController",@"title":@"爆米花"}],
                         @[@{@"class":@"HYCKVOViewController",@"title":@"EasyKVO"}],
                         ];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGFloat y = [change[@"new"] CGPointValue].y;
    if (y >= 100) {
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    } else {
        self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _viewControllers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewControllers[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    NSDictionary *dict = _viewControllers[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.detailTextLabel.text = dict[@"class"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = _viewControllers[indexPath.section][indexPath.row];
    Class class = NSClassFromString(dict[@"class"]);
    UIViewController *vc = [[class alloc] init];
    vc.title = dict[@"title"];
    
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = 1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //过渡效果
    animation.type = @"pageCurl";
    //过渡方向
    animation.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
