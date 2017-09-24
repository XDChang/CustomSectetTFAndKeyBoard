//
//  CustomKeyBoard.h
//  StationCooperation
//
//  Created by XDChang on 2017/9/23.
//  Copyright © 2017年 XDChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomKeyBoard : UIView

@property (nonatomic,assign) id delegate;
@end

@protocol CustomKeyBoardDelegate <NSObject>
// 键盘数字点击 响应代理回调
- (void)customKeyBoardDelegateWithNumBtn:(UIButton *)btn;
// 键盘响应事件 delete pack up confirm
- (void)customKeyBoardDelegateEventWithBtn:(UIButton *)btn;
@end
