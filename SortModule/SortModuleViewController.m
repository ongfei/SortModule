//
//  SortModuleViewController.m
//  SinoCommunity
//
//  Created by df on 2017/3/2.
//  Copyright © 2017年 df. All rights reserved.
//

#import "SortModuleViewController.h"
#import "SortModuleCell.h"
#import <Masonry.h>

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)

@interface SortModuleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SortModuleCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionV;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@property (nonatomic, strong) NSMutableDictionary *sourceDic;

@property (nonatomic, assign) BOOL editState;


@end

@implementation SortModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"模块管理";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:(UIBarButtonItemStyleDone) target:self action:@selector(editCell)];
    
    
    [self prepareLayout];
    
    [self requestData];
    
}

- (void)requestData {
    
    NSMutableArray *mineArr = [NSMutableArray arrayWithObjects:@"aa",@"bb",@"gg",@"dd",@"kk", nil];
    
    NSArray *otherArr = [NSArray arrayWithObjects:@"aa",@"bb",@"cc",@"dd",@"ee",@"ff",@"gg",@"hh",@"ii",@"jj",@"kk", nil];
    
    self.sourceDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:mineArr,@"mine",otherArr,@"other", nil];
    
    [self.collectionV reloadData];
}

- (void)prepareLayout {
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.layout.itemSize = CGSizeMake((ScreenWidth - 10)/4, (ScreenWidth - 10)/4);
    
    self.layout.minimumLineSpacing = 1;
    self.layout.minimumInteritemSpacing = 1;
    
    self.layout.sectionInset = UIEdgeInsetsMake(2, 1, 1, 2);
    
    self.layout.headerReferenceSize = CGSizeMake(ScreenWidth, 30);
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.layout];
    
    [self.view addSubview:self.collectionV];
    
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];

    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    
    self.collectionV.backgroundColor = [UIColor whiteColor];
    
    [self.collectionV registerClass:[SortModuleCell class] forCellWithReuseIdentifier:@"SortModuleCell"];
    
    [self.collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
    [self.collectionV addGestureRecognizer:_longPress];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sourceDic.allKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return [self.sourceDic[@"mine"] count];
    }else
        
    return [self.sourceDic[@"other"] count];;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SortModuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SortModuleCell" forIndexPath:indexPath];

    cell.delegate = self;
    
    NSString *str = indexPath.section == 0 ? [self.sourceDic[@"mine"] objectAtIndex:indexPath.item] : [self.sourceDic[@"other"] objectAtIndex:indexPath.item];
    
    if ([self.sourceDic[@"mine"] containsObject:str]) {
        
        [cell showEditBtn:self.editState andSection:indexPath.section andEditState:(sortModuleCellEditStateSub)];
        
    }else {
        
        [cell showEditBtn:self.editState andSection:indexPath.section andEditState:(sortModuleCellEditStateAdd)];
        
    }
    
    
    cell.str = str;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
     // 最好自定义视图 继承 UICollectionReusableView
        UICollectionReusableView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 30)];
        
        if (indexPath.section == 0) {
            
            lable.text = @"首页模块";
        }else {
            lable.text = @"其他模块";
        }
        
        while (headerV.subviews.count){
            UIView *child = headerV.subviews.lastObject;
            [child removeFromSuperview];
        }

        
        [headerV addSubview:lable];
        
        return headerV;

    }
    
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return YES;
        
    }else {
        
        return NO;
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    

    NSIndexPath *selectIndexPath = [self.collectionV indexPathForItemAtPoint:[_longPress locationInView:self.collectionV]];
    // 找到当前的cell
    SortModuleCell *cell = (SortModuleCell *)[self.collectionV cellForItemAtIndexPath:selectIndexPath];

    cell.hideEditBtn = YES;
    
    NSString *str = self.sourceDic[@"mine"][sourceIndexPath.item];
    
    [self.sourceDic[@"mine"] removeObjectAtIndex:sourceIndexPath.item];
    
    [self.sourceDic[@"mine"] insertObject:str atIndex:destinationIndexPath.item];
    
    
    [self.collectionV reloadData];
    
}

- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress {
    
    if (!self.editState) {
        
        return;
    }
    
    NSIndexPath *selectIndexPath = [self.collectionV indexPathForItemAtPoint:[longPress locationInView:self.collectionV]];

    // 找到当前的cell
    SortModuleCell *cell = (SortModuleCell *)[self.collectionV cellForItemAtIndexPath:selectIndexPath];
    
    
    switch (longPress.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            [self.collectionV beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            
            [self.collectionV updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
            
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            
            if (selectIndexPath.section != 0) {
                
                [self.collectionV cancelInteractiveMovement];
                
            }else {
                
                [self.collectionV endInteractiveMovement];
            }
            
            break;
        }
            
        default:
            
            [self.collectionV cancelInteractiveMovement];
            
            break;
    }
}
#pragma mark - cellDelegate

- (void)sortModuleCellEditState:(sortModuleCellEditState)editState andStr:(NSString *)str andCell:(UICollectionViewCell *)cell {
    
    if (editState == sortModuleCellEditStateAdd) {
        
        [self.sourceDic[@"mine"] addObject:str];
        
        [UIView animateWithDuration:0.4 animations:^{
            
            cell.transform = CGAffineTransformMakeScale(1.75, 1.75);
            
            cell.alpha = 0.5;
            
        } completion:^(BOOL finished) {
            
            [self.collectionV reloadData];

        }];
        
    }else {
        
        [self.sourceDic[@"mine"] removeObject:str];
        
        [UIView animateWithDuration:0.4 animations:^{
            
            cell.transform = CGAffineTransformMakeScale(0.1, 0.1);
            
        } completion:^(BOOL finished) {
            
            [self.collectionV reloadData];
            
        }];

    }
    
}

#pragma mark - 编辑状态

- (void)editCell {
    
    self.navigationItem.rightBarButtonItem.title = [self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"] ? @"完成" : @"编辑";
    
    self.editState = !self.editState;
    
    [self.collectionV reloadData];
    
}

@end
