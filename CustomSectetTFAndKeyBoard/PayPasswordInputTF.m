//
//  PayPasswordInputTF.m
//
//
//  Created by XDChang on 2017/9/28.
//  Copyright © 2017年 XDChang. All rights reserved.
//

#import "PayPasswordInputTF.h"

@implementation PayPasswordInputTF

- (void)deleteBackward {
    [super deleteBackward];
    if ([self.payPasswordDelegate respondsToSelector:@selector(payPasswordTFDeleteEvent)]) {
        
        [self.payPasswordDelegate payPasswordTFDeleteEvent];
    }
}

@end
