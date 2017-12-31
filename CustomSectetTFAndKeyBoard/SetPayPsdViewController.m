//
//  SetPayPsdViewController.m
//  CustomSectetTFAndKeyBoard
//
//  Created by 徐德昌 on 2017/12/31.
//  Copyright © 2017年 徐德昌. All rights reserved.
//

#import "SetPayPsdViewController.h"
#import "PayPasswordInputTF.h"
#import "UIView+Extension.h"

#define CURSRCEENLENGTH(iphone6length)     iphone6length * [UIScreen mainScreen].bounds.size.width / 375
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define KinitView(kClass)           [[kClass alloc]initWithFrame:FRAME]
#define FRAME                 CGRectMake(x,y,w,h)
//iPhone6尺寸，以屏幕宽为基准缩放，获取当前屏幕字体
#define FONT(font)            [UIFont systemFontOfSize:CURSRCEENLENGTH(font)]
#define kColorTitle                       [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
#define KAddSubview(view1,view2)    [view1 addSubview:view2]
#define    kCustomColor(a,b,c)     [UIColor colorWithRed:a/255.0f green:b/255.0f blue:c/255.0f alpha:1.0f]
#define KColorLineColor              kCustomColor(236.0,236.0,236.0)
@interface SetPayPsdViewController ()<UITextFieldDelegate,PayPasswordInputTFDelegate>
@property (nonatomic,strong) NSMutableArray *tfArr;
@property (nonatomic,strong) PayPasswordInputTF *tfBottomView;
@property (nonatomic,strong) UILabel *tipsLabel;
@end

@implementation SetPayPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSubviews];
}
- (void)createSubviews{
    
    float x = 0;
    float y = 0;
    float w = 0;
    float h = 0;
    
    x = 0;
    y = CURSRCEENLENGTH(80);
    w = kScreenW;
    h = CURSRCEENLENGTH(20);
    UILabel *tipsLabel = KinitView(UILabel);
    tipsLabel.text = @"请设置支付密码";
    tipsLabel.font = FONT(15);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.textColor = kColorTitle;
    KAddSubview(self.view, tipsLabel);
    self.tipsLabel = tipsLabel;
    
    x = CURSRCEENLENGTH(15);
    y = tipsLabel.bottom + CURSRCEENLENGTH(5);
    w = kScreenW - CURSRCEENLENGTH(30);
    h = CURSRCEENLENGTH(60);
    self.tfBottomView = KinitView(PayPasswordInputTF);
    _tfBottomView.delegate = self;
    _tfBottomView.payPasswordDelegate = self;
    [_tfBottomView becomeFirstResponder];
    _tfBottomView.keyboardType = UIKeyboardTypeNumberPad;
    _tfBottomView.returnKeyType = UIReturnKeyDone;
    _tfBottomView.backgroundColor = KColorLineColor;
    _tfBottomView.secureTextEntry = YES;
    _tfBottomView.textColor = [UIColor clearColor];
    _tfBottomView.tintColor = [UIColor clearColor];
    KAddSubview(self.view, _tfBottomView);
    
    self.tfArr = [[NSMutableArray alloc]init];
    CGFloat lineW = 1;
    CGFloat tfWifth = (_tfBottomView.width - 7 * lineW)/6;
    for (int i =0; i < 6; i ++) {
        
        x = lineW + i *(tfWifth + lineW);
        y = lineW;
        w = tfWifth;
        h = _tfBottomView.height - 2 * lineW;
        
        UITextField *tf = KinitView(UITextField);
        tf.font = FONT(24);
        tf.secureTextEntry = YES;
        tf.enabled = NO;
        tf.textAlignment = NSTextAlignmentCenter;
        tf.backgroundColor = [UIColor whiteColor];
        KAddSubview(_tfBottomView, tf);
        [self.tfArr addObject:tf];
    }
}



#pragma mark --- delegate

/*!
 @method  密码输入时触发的协议方法
 @abstract 密码输入时触发的协议方法，遍历tf 进行赋值
 @discussion 注意点，delete事件也会进入这个方法 但string是nil 所以会给要赋值的tf 置为nil, 符合delete逻辑。
 @param textField textField
 @result bool
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    self.tipsLabel.text = @"请设置支付密码";
    for (UITextField *tf in self.tfArr) {
        if ([tf.text isEqualToString:@""]||tf.text == nil) {
            tf.text = string;
            if (textField.text.length==5) {
                [self textFieldShouldReturn:textField];
            }
            return YES;
        }
    }
    return YES;
}
/*!
 @method  payPasswordTFDeleteEvent
 @abstract 键盘delete触发的协议方法
 @discussion 自定义的协议方法，键盘delete触发的协议方法。
 
 */
- (void)payPasswordTFDeleteEvent{
    
    [self.tfArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *tf = (UITextField *)obj;
        if (![tf.text isEqualToString:@""] && tf.text !=nil) {
            tf.text = @"";
            *stop = YES;
        }
    }];
}
/*!
 @method  textFieldShouldReturn
 @abstract  textField协议方法，点击return 触发的协议方法
 @discussion 在这里处理更多逻辑，判断，跳转。
 @param textField textField
 @result bool
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *password;
        for (UITextField *tf in self.tfArr) {
            if (![tf.text isEqualToString:@""]|| tf.text !=nil) {
                if (password !=nil) {
                    password = [password stringByAppendingString:tf.text];
                }else{
                    password = tf.text;
                }
            }
        }
        
        //跳转到再次输入密码界面
        if (password.length == 6) {
            self.tipsLabel.text = @"设置成功！";
        }
    });
    [self.view endEditing:YES];
    return YES;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.tfArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        UITextField *tf = (UITextField *)obj;
//        tf.text = @"";
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
