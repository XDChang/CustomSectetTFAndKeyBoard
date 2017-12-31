//
//  PayPasswordInputTF.h
//  
//
//  Created by XDChang on 2017/9/28.
//  Copyright © 2017年 XDChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayPasswordInputTF : UITextField

@property (nonatomic,assign) id payPasswordDelegate;
@end

@protocol PayPasswordInputTFDelegate <NSObject>

- (void)payPasswordTFDeleteEvent;

@end
