//
//  KeyBoardView.h
//  testKeyBoard
//
//  Created by Lee on 16/4/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface KeyBoardView : UIView

- (instancetype)initWithClick:(void(^)(UIButton *))click isSecond:(BOOL)second;

@end
