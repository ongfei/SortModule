//
//  SortModuleCell.h
//  SinoCommunity
//
//  Created by df on 2017/3/2.
//  Copyright © 2017年 df. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    sortModuleCellEditStateAdd,
    sortModuleCellEditStateSub,
} sortModuleCellEditState;
@protocol SortModuleCellDelegate <NSObject>

- (void)sortModuleCellEditState:(sortModuleCellEditState)editState andStr:(NSString *)str andCell:(UICollectionViewCell *)cell;

@end

@interface SortModuleCell : UICollectionViewCell

@property (nonatomic, strong) NSString *str;

@property (nonatomic, weak) id<SortModuleCellDelegate> delegate;

@property (nonatomic, assign) BOOL hideEditBtn;


- (void)showEditBtn:(BOOL)showEdit andSection:(NSInteger)section andEditState:(sortModuleCellEditState)state;


@end
