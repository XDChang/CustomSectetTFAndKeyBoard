//
//  SecretTextField.m
//  StationCooperation
//
//  Created by XDChang on 2017/9/23.
//  Copyright © 2017年 XDChang. All rights reserved.
//

#import "SecretTextField.h"

@interface SecretTextField()<UITextFieldDelegate>

@end
@implementation SecretTextField


- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.secretTFArr = [[NSMutableArray alloc]init];
        self.backgroundColor = [UIColor grayColor];
        self.userInteractionEnabled = YES;
        for (int i = 0; i< 6; i ++) {
           
            UITextField *secretTF = [[UITextField alloc]initWithFrame:CGRectMake(0.5+i*(40 + 0.5), 0.5, 40, 40)];
            secretTF.secureTextEntry = YES;
            secretTF.backgroundColor = [UIColor whiteColor];
            secretTF.textAlignment = NSTextAlignmentCenter;
            secretTF.enabled = NO;
            secretTF.font = [UIFont boldSystemFontOfSize:18];
            secretTF.delegate = self;
            [self addSubview:secretTF];
            [self.secretTFArr addObject:secretTF];
        }
  
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if ([_delegate respondsToSelector:@selector(secretTextFieldDelegateWithSecretTFArr:)]) {

        [self.delegate secretTextFieldDelegateWithSecretTFArr:self.secretTFArr];
    }
}

// 点击密码TF 弹起自定义键盘 将tf对象传出
- (void)actionBySecretTFEvent{

    
}

@end
