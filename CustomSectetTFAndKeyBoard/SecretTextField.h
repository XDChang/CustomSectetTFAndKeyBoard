//
//  SecretTextField.h
//  StationCooperation
//
//  Created by XDChang on 2017/9/23.
//  Copyright © 2017年 XDChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecretTextField : UIView

@property (nonatomic,strong) NSMutableArray *secretTFArr; //TF数组
@property (nonatomic,assign) id delegate;
@end

@protocol SecretTextFieldDelegate <NSObject>
// 点击密码TF 弹起自定义键盘 将tf对象传出
- (void)secretTextFieldDelegateWithSecretTFArr:(NSMutableArray *)arr;

@end
