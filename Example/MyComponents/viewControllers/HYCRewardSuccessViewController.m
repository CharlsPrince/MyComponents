//
//  HYCRewardSuccessViewController.m
//  MyComponents
//
//  Created by charls on 2017/6/27.
//  Copyright © 2017年 CharlsPrince. All rights reserved.
//

#import "HYCRewardSuccessViewController.h"
#import <MyComponents/MyComponents.h>

@interface HYCRewardSuccessViewController ()

@end

@implementation HYCRewardSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 35)];
    [button setTitle:@"爆米花" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonClicked:(UIButton *)button {
    [RewardSuccess show];
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
