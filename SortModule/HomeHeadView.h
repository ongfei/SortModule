//
//  HomeHeadView.h
//  SinoCommunity
//
//  Created by df on 2017/2/17.
//  Copyright © 2017年 df. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeHeadViewDelegate <NSObject>

- (void)homeHeadViewdidSelectItemWithModelText:(NSString *)module andIndex:(NSInteger)index;

@end
@interface HomeHeadView : UIView


@property (nonatomic, weak) id<HomeHeadViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate andModuleArr:(NSArray *)arr;

@end
