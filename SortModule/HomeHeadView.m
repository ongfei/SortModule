//
//  HomeHeadView.m
//  SinoCommunity
//
//  Created by df on 2017/2/17.
//  Copyright © 2017年 df. All rights reserved.
//

#import "HomeHeadView.h"
#import <Masonry.h>

#define ScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define ScreenHeight ([[UIScreen mainScreen] bounds].size.height)


@interface HomeHeadView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *container;

@property (nonatomic, strong) NSArray *moduleArr;

@end
@implementation HomeHeadView

- (instancetype)initWithFrame:(CGRect)frame andDelegeta:(id)delegat {
    
    HomeHeadView *headView = [self initWithFrame:frame];
    
    
    self.delegate = delegat;
    
    return headView;
}

- (instancetype)initWithFrame:(CGRect)frame andDelegate:(id)delegate andModuleArr:(NSArray *)arr {
    
    self = [super initWithFrame:frame];
    
    self.delegate = delegate;
    
    self.moduleArr = arr;
    
    [self prepareLayout];
    
    return self;
}

- (void)prepareLayout {
    
    
    UIView *container = [UIView new];
    
    self.container = container;
    
    container.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(ScreenWidth/5*2 + 10);
        make.top.equalTo(self.mas_top);
    }];
    
    
    UIView *lastView = nil;
    for ( int i = 0 ; i <= self.moduleArr.count ; ++i ) {
        
        if (i > 9) {
            
            break;
        }
        
        UIView *subv = [UIView new];
        
        [container addSubview:subv];
        
//        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
//                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
//                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
//                                               alpha:1];
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.width.mas_equalTo(ScreenWidth/5);
            
            if (lastView == nil) {
                
                make.top.left.equalTo(container);
                
            }else{
                    
                if (i%5 == 0) {
                    
                    if (i%10 == 0) {
                        
                        make.top.equalTo(container);
                        
                    }else {
                        
                        make.top.equalTo(lastView.mas_bottom);

                    }
                    
                    make.left.equalTo(container).offset(i/10*ScreenWidth);
                    
                }else{
                
                    make.top.equalTo(lastView);
                    
                    make.left.equalTo(lastView.mas_right);
                }
                
                
            }

        }];
        
        lastView = subv;
        
        subv.tag = 10000 + i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        
        [subv addGestureRecognizer:tap];
        
        
        UIImageView *imageV = [UIImageView new];
        
        imageV.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                            saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                            brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                                 alpha:1];
        [subv addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(subv).offset(3);
            make.bottom.equalTo(subv).offset(-18);
            make.width.equalTo(imageV.mas_height);
            make.centerX.equalTo(subv);
        }];
        
        imageV.userInteractionEnabled = YES;
        
        
        UILabel *lable = [self CustomWithFontNumber:14 andSuperV:subv andIsAuto:NO andInteract:YES andAlign:(NSTextAlignmentCenter)];
        
        
        lable.userInteractionEnabled = YES;
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(subv);
            make.top.equalTo(imageV.mas_bottom);
        }];
        
        
        if (i > 8 || self.moduleArr.count == 0 || (i <= 8 && self.moduleArr.count == i)) {
            
            imageV.backgroundColor = [UIColor orangeColor];
            
            lable.text = @"查看更多";
            
        }else {
            
            
            lable.text = self.moduleArr[i];

//            [imageV sd_setImageWithURL:];
        }

    }
    


    
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(homeHeadViewdidSelectItemWithModelText:andIndex:)]) {
        
        [self.delegate homeHeadViewdidSelectItemWithModelText:tap.view.tag - 10000 >= self.moduleArr.count ? @"查看更多" : self.moduleArr[tap.view.tag - 10000] andIndex: tap.view.tag - 10000];
    }
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

@end
