//
//  WithdrawView.m
//  StationCooperation
//
//  Created by XDChang on 2017/9/23.
//  Copyright © 2017年 XDChang. All rights reserved.
//

#import "WithdrawView.h"
#import "SecretTextField.h"
@implementation WithdrawView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, frame.size.width, 20)];
        titleLabel.text = @"提现";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:titleLabel];
        
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, frame.size.width, 40)];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.text = @"¥100.34";
        moneyLabel.font = [UIFont boldSystemFontOfSize:30];
        moneyLabel.textColor = [UIColor blackColor];
        [self addSubview:moneyLabel];
        
        UILabel *deductMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, frame.size.width, 20)];
        deductMoneyLabel.textAlignment = NSTextAlignmentCenter;
        deductMoneyLabel.text = @"扣除¥0.10手续费";
        deductMoneyLabel.font = [UIFont systemFontOfSize:16];
        deductMoneyLabel.textColor = [UIColor grayColor];
        [self addSubview:deductMoneyLabel];
        
        SecretTextField *secTF = [[SecretTextField alloc]initWithFrame:CGRectMake((frame.size.width-243.5)/2, frame.size.height-70, 243.5, 41)];
        secTF.delegate = self;
        [self addSubview:secTF];
        self.secreTFArr = secTF.secretTFArr;
    }
    return self;
}

@end
