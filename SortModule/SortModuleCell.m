//
//  SortModuleCell.m
//  SinoCommunity
//
//  Created by df on 2017/3/2.
//  Copyright © 2017年 df. All rights reserved.
//

#import "SortModuleCell.h"
#import <Masonry.h>

@interface SortModuleCell ()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, assign) sortModuleCellEditState editState;

@property (nonatomic, assign) BOOL canSub;


@end

@implementation SortModuleCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareLayout];
    }
    return self;
}

- (void)prepareLayout {
    
    
    self.imageV = [UIImageView new];
    
//    self.imageV.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
//                                            saturation:( arc4random() % 128 / 256.0 ) + 0.5
//                                            brightness:( arc4random() % 128 / 256.0 ) + 0.5
//                                                 alpha:1];
    
    self.imageV.image = [UIImage imageNamed:@"add"];
    [self.contentView addSubview:self.imageV];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(3);
        make.height.mas_equalTo(self.contentView.mas_height).offset(-30);
        make.width.equalTo(self.imageV.mas_height);
        make.centerX.equalTo(self.contentView);
    }];
    
    self.imageV.userInteractionEnabled = YES;
    
    self.label = [self CustomWithFontNumber:14 andSuperV:self.contentView andIsAuto:NO andInteract:YES andAlign:(NSTextAlignmentCenter)];
    
    
    self.label.userInteractionEnabled = YES;
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    
    self.editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [self.contentView addSubview:self.editBtn];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-3);
        make.top.equalTo(self.contentView).offset(3);
        make.width.height.equalTo(@20);
    }];
    
    [self.editBtn addTarget:self action:@selector(editBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.editBtn.hidden = YES;
    
}

- (void)showEditBtn:(BOOL)showEdit andSection:(NSInteger)section andEditState:(sortModuleCellEditState)state {
    
    if (showEdit) {
        
        self.editBtn.hidden = NO;
        
        self.contentView.layer.borderWidth = 1;
        
        self.contentView.layer.borderColor = [[UIColor colorWithRed:0.9 green:0.93 blue:0.92 alpha:1] CGColor];
        
        if (section == 0) {
            
            self.editState = state;
            
            self.canSub = YES;
            
            [self.editBtn setImage:[UIImage imageNamed:@"subtract"] forState:(UIControlStateNormal)];
            
        }else {
            
            if (state == sortModuleCellEditStateAdd) {
                
                self.editState = state;
                
                [self.editBtn setImage:[UIImage imageNamed:@"add"] forState:(UIControlStateNormal)];
                
            }else {
                
                self.editState = state;
                
                self.canSub = NO;
                
                [self.editBtn setImage:[UIImage imageNamed:@"subtract"] forState:(UIControlStateNormal)];
            }
        }
    }else {
        
        self.contentView.layer.borderWidth = 0;
        
        self.editBtn.hidden = YES;
    }
}

- (void)editBtnClick {
    
    if (self.editState == sortModuleCellEditStateSub && !self.canSub) {
        
        return;
        
    }else {
        
        if ([self.delegate respondsToSelector:@selector(sortModuleCellEditState:andStr:andCell:)]) {
            
            [self.delegate sortModuleCellEditState:self.editState andStr:self.str andCell:self];
        }
        
    }
    
}

- (void)setStr:(NSString *)str {
    
    _str = nil;
    
    _str = str;
    
    self.label.text = str;
}


- (UILabel *)CustomWithFontNumber:(NSInteger)fontN andSuperV:(UIView *)sView andIsAuto:(BOOL)isAuto andInteract:(BOOL)interact andAlign:(NSTextAlignment)align {
    
    UILabel *label = [UILabel new];
    
    label.font = [UIFont systemFontOfSize:fontN];
    
    [sView addSubview:label];
    
    if (isAuto) {
        
        label.numberOfLines = 0;
        
    }
    if (interact) {
        label.userInteractionEnabled = YES;
    }
    
    label.textAlignment = align;
    return label;
}

- (void)setHideEditBtn:(BOOL)hideEditBtn {
    
    self.editBtn.hidden = hideEditBtn;
}

- (BOOL)hideEditBtn {
    return self.editBtn.hidden;
}

@end
