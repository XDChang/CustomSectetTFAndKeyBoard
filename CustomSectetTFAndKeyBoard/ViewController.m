//
//  ViewController.m
//  CustomSectetTFAndKeyBoard
//
//  Created by 徐德昌 on 2017/9/24.
//  Copyright © 2017年 徐德昌. All rights reserved.
//

#import "ViewController.h"
#import "CustomKeyBoard.h"
#import "WithdrawView.h"
#import "SetPayPsdViewController.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kWindow  [[UIApplication sharedApplication].delegate window]
@interface ViewController ()<CustomKeyBoardDelegate>

@property (nonatomic,strong) NSMutableArray *tfArr;
@property (nonatomic,strong) CustomKeyBoard *customKB;
@property (nonatomic,strong) WithdrawView *withDrawView;
@property (nonatomic,strong) UIView *shadowView;

@end

static NSTimeInterval const kTransformPart1AnimationDuration = 0.3;
static NSTimeInterval const kTransformPart2AnimationDuration = 0.4;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *withDrawBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 260, kScreenW-120, 45)];
    withDrawBtn.backgroundColor = [UIColor orangeColor];
    withDrawBtn.layer.cornerRadius = 3;
    [withDrawBtn setTitle:@"提现" forState:UIControlStateNormal];
    [withDrawBtn addTarget:self action:@selector(onWithDrawBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:withDrawBtn];
    
    UIButton *nextVCBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW - 100, 80, 60, 40)];
    [nextVCBtn setTitle:@"next" forState:UIControlStateNormal];
    [nextVCBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [nextVCBtn addTarget:self action:@selector(actionByNextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextVCBtn];
    
}

#pragma mark --- actions
- (void)actionByNextBtnClick{
    
    SetPayPsdViewController *vc = [[SetPayPsdViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

// 键盘数字点击 响应代理回调
- (void)customKeyBoardDelegateWithNumBtn:(UIButton *)btn{
    NSLog(@"keyBoardNum=%@",btn.currentTitle);
    for (UITextField *tf in self.tfArr) {
        if ([tf.text isEqualToString:@""] || tf.text ==nil) {
            tf.text = btn.currentTitle;
            return;
        }
    }
}
// 键盘响应事件 delete pack up confirm
- (void)customKeyBoardDelegateEventWithBtn:(UIButton *)btn{
    
    switch (btn.tag) {
        case 11:
            NSLog(@"deleteEvent");
            
            [self.tfArr enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                UITextField *tf = (UITextField *)obj;
                if (![tf.text isEqualToString:@""] && tf.text !=nil) {
                    tf.text = @"";
                    *stop = YES;
                }
            }];
            break;
        case 12:{
            NSLog(@"confirmEvent");
            [UIView animateWithDuration:0.25f animations:^{
                
                _customKB.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
            }];
            
            [UIView animateWithDuration:0.1 animations:^{
                self.withDrawView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    self.withDrawView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
                    _shadowView.alpha = 0;
                } completion:^(BOOL finished) {
                    [self.withDrawView removeFromSuperview];
                    [_shadowView removeFromSuperview];
                }];
            }];
            
        }
            break;
        case 13:{
            NSLog(@"pickupEvent");
            [UIView animateWithDuration:0.25f animations:^{
                _customKB.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
            }];
            
            [UIView animateWithDuration:0.1 animations:^{
                self.withDrawView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.15 animations:^{
                    self.withDrawView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
                    _shadowView.alpha = 0;
                } completion:^(BOOL finished) {
                    [self.withDrawView removeFromSuperview];
                    [_shadowView removeFromSuperview];
                }];
            }];
        }
            break;
        default:
            break;
    }
}
- (void)onWithDrawBtnClick{
    // 阴影view
    self.shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    _shadowView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    [kWindow addSubview:_shadowView];
    // 提现view
    [self createWithDrawView];
    // 自定义键盘
    [self createCustomKeyBoard];
}
/*!
 @method  createWithDrawView。
 @abstract 创建提现view
 @discussion 创建提现view，pop动画弹出。
 
 */
- (void)createWithDrawView{
    
    self.withDrawView = [[WithdrawView alloc]initWithFrame:CGRectMake(30, 120, kScreenW-60, 220)];
    self.tfArr = _withDrawView.secreTFArr;
    [kWindow addSubview:_withDrawView];
    
    self.withDrawView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    [UIView animateWithDuration:kTransformPart1AnimationDuration animations:^{
        self.withDrawView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.05, 1.05);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            self.withDrawView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:kTransformPart2AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.withDrawView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            } completion:nil];
        }];
    }];
}
/*!
 @method  createCustomKeyBoard。
 @abstract 自定义键盘view
 @discussion 自定义键盘view，设置代理。
 
 */
- (void)createCustomKeyBoard{
    
    self.customKB = [[CustomKeyBoard alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200)];
    _customKB.delegate = self;
    [kWindow addSubview:_customKB];
    [self customKeyBoardShow];
}
// 点击密码TF 弹起自定义键盘 将tf对象传出
- (void)customKeyBoardShow{
    
    [UIView animateWithDuration:0.25f animations:^{
        
        _customKB.frame = CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200);
    }];
}
@end
