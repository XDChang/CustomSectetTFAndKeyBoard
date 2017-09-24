//
//  CustomKeyBoard.m
//  StationCooperation
//
//  Created by XDChang on 2017/9/23.
//  Copyright © 2017年 XDChang. All rights reserved.
//

#import "CustomKeyBoard.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kColorTitle                            [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
#define kColorSubtitle                         [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]
#define kColorRightTitle                       [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
#define FONT(font)            [UIFont systemFontOfSize:font]
@implementation CustomKeyBoard


- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorSubtitle;
        for (int i = 0; i < 10; i ++) {
    
            // 计算行号  和   列号
            int row = i / 3;
            int col = i % 3;
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(col*(kScreenW/4 + 0.5), row * (50+0.5), kScreenW/4, 50)];
            btn.backgroundColor = [UIColor whiteColor];
            [btn addTarget:self action:@selector(onNumBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[NSString stringWithFormat:@"%d",i+1==10?0:i+1] forState:UIControlStateNormal];
            [btn setTitleColor:kColorTitle forState:UIControlStateNormal];
            [btn setTitleColor:kColorRightTitle forState:UIControlStateHighlighted];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
            [self addSubview:btn];
            
        }
        
        UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(3* (kScreenW/4+0.5), 0, kScreenW/4, 100)];
        deleteBtn.backgroundColor = [UIColor whiteColor];
        [deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        deleteBtn.tag = 11;
        [deleteBtn addTarget:self action:@selector(onKeyBoardEventBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        
        UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(3* (kScreenW/4+0.5), 100, kScreenW/4, 100)];
        confirmBtn.backgroundColor = [UIColor colorWithRed:76/255.0 green:145/255.0 blue:199/255.0 alpha:1];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor colorWithRed:149/255.0 green:200/255.0 blue:226/255.0 alpha:1] forState:UIControlStateHighlighted];
        confirmBtn.tag = 12;
        [confirmBtn addTarget:self action:@selector(onKeyBoardEventBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:confirmBtn];
        
        UIButton *keyboardBtn = [[UIButton alloc]initWithFrame:CGRectMake(1* (kScreenW/4+0.5), 151.5, 2*kScreenW/4+0.5, 50)];
        keyboardBtn.backgroundColor = [UIColor whiteColor];
        [keyboardBtn setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
        keyboardBtn.tag = 13;
        [keyboardBtn addTarget:self action:@selector(onKeyBoardEventBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:keyboardBtn];
        
        
    }
    return self;
}
// 键盘数字点击 响应代理回调
- (void)onNumBtnClick:(UIButton *)btn{

    if ([_delegate respondsToSelector:@selector(customKeyBoardDelegateWithNumBtn:)]) {
        
        [self.delegate customKeyBoardDelegateWithNumBtn:btn];
    }
}
// 键盘响应事件 delete pack up confirm
- (void)onKeyBoardEventBtnClick:(UIButton *)btn{

    if ([_delegate respondsToSelector:@selector(customKeyBoardDelegateEventWithBtn:)]) {
        
        [self.delegate customKeyBoardDelegateEventWithBtn:btn];
    }

}

@end
