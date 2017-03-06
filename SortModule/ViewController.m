//
//  ViewController.m
//  SortModule
//
//  Created by df on 2017/3/6.
//  Copyright © 2017年 df. All rights reserved.
//

#import "ViewController.h"
#import "HomeHeadView.h"
#import "SortModuleViewController.h"

@interface ViewController ()<HomeHeadViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    HomeHeadView *headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 300) andDelegate:self andModuleArr:@[@"111",@"aa",@"aa",@"aa",@"aa",@"aa",@"aa",@"aa"]];
    
    [self.view addSubview:headView];
    

    
}

- (void)homeHeadViewdidSelectItemWithModelText:(NSString *)module andIndex:(NSInteger)index {
    
    NSLog(@"%@-----%ld",module , index);
    if ([module isEqualToString:@"查看更多"]) {
        
        SortModuleViewController *sortModuleVC = [SortModuleViewController new];
        
        sortModuleVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:sortModuleVC animated:YES];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
