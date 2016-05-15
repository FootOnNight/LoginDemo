//
//  KeyBoardView.m
//  testKeyBoard
//
//  Created by Lee on 16/4/27.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "KeyBoardView.h"
#import "KeyBoardButton.h"

@interface KeyBoardView()
    
@property (nonatomic, copy) void (^click)(UIButton *);

@property(nonatomic, assign) BOOL second;

@end

@implementation KeyBoardView


- (instancetype)initWithClick:(void (^)(UIButton *))click isSecond:(BOOL)second
{
    self = [super init];
    
    if (self) {
        
        self.second = second;

        self.backgroundColor = [UIColor whiteColor];
        
        _click = click;
        
        int i;
        
        CGFloat keyboardWidth = ScreenWidth;
        CGFloat keyboardHeight = KeyboardHeight;
        NSLog(@"%f, %f", keyboardWidth, keyboardHeight);
        
        for (i = 0; i < 12; i++) {
            
            KeyBoardButton *btn = [KeyBoardButton buttonWithType:UIButtonTypeCustom];
            
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            
            btn.tag = 100 + i;
            
            
            [btn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            btn.clipsToBounds = YES;
            
            [self addSubview:btn];
            
//            CGFloat btnWith = keyboardWidth / 3.0;
//            CGFloat btnHeight = keyboardHeight / 4.0;
            
            CGFloat btn1Width = 123 * __Scale;
            CGFloat btn2Width = 129 * __Scale;
            CGFloat btn0Width = (123 + 129) * __Scale;
            
            CGFloat btnHeight = 54;
            
            CGFloat btn1Height = 54 * __Scale;
            CGFloat btn4Height = 53.5 * __Scale;
            
            CGFloat btn2X = 123 * __Scale;
            CGFloat btn3X = (123 + 129 + 0.5) * __Scale;
            
            CGFloat btn4Y = (54 + 0.5) * __Scale;
            CGFloat btn7Y = (54 * 2 + 0.5) * __Scale;
            CGFloat btn0Y = (54 * 3 + 0.5) * __Scale;
            
//            switch (i) {
//                case 0:
//                    btn.frame = CGRectMake(0, 0, btn1Width, btn1Height);
//                    break;
//                case 1:
//                    btn.frame = CGRectMake(btn2X, 0, btn2Width, btn1Height);
//                    break;
//                case 2:
//                    btn.frame = CGRectMake(btn3X, 0, btn1Width, btn1Height);
//                    break;
//                case 3:
//                    btn.frame = CGRectMake(0, btn4Y, btn1Width, btn4Height);
//                    break;
//                case 4:
//                    btn.frame = CGRectMake(btn2X, btn4Y, btn2Width, btn4Height);
//                    break;
//                case 5:
//                    btn.frame = CGRectMake(btn3X, btn4Y, btn1Width, btn4Height);
//                    break;
//                case 6:
//                    btn.frame = CGRectMake(0, btn7Y, btn1Width, btn4Height);
//                    break;
//                case 7:
//                    btn.frame = CGRectMake(btn2X, btn7Y, btn2Width, btn4Height);
//                    break;
//                case 8:
//                    btn.frame = CGRectMake(btn3X, btn7Y, btn1Width, btn4Height);
//                    break;
//                case 9:
//                    if (self.second) {
//                        btn.frame = CGRectMake(0, btn0Y, btn1Width, btn4Height);
//                    }
//                    else {
//                        btn.frame = CGRectMake(0, btn0Y, btn0Width, btn4Height);
//                    }
//                    break;
//                case 10:
//                    if (self.second) {
//                        btn.frame = CGRectMake(btn2X, btn0Y, btn2Width, btn4Height);
//                    }
//                    else {
//                        btn.frame = CGRectMake(btn3X, btn0Y, btn1Width, btn4Height);
//                    }
//                    break;
//                case 11:
//                    if (self.second) {
//                        btn.frame = CGRectMake(btn3X, btn0Y, btn1Width, btn4Height);
//                    }
//                    else {
//                        break;
//                    }
//                    break;
//                default:
//                    break;
//            }
//                        
//            [btn setBackgroundImage:[UIImage imageNamed:@"1_bg"] forState:UIControlStateNormal];
//            [btn setBackgroundImage:[UIImage imageNamed:@"1_bg_clicked"] forState:UIControlStateSelected];

            
            if (i < 9){
                btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:29 * __Scale];
                if (i == 0 || i == 3 || i == 6) {
                    btn.frame = CGRectMake(0, (i / 3) * btnHeight, btn1Width, btnHeight);
                    [btn setBackgroundImage:[UIImage imageNamed:@"1_bg"] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:@"1_bg_clicked"] forState:UIControlStateSelected];
                }
                else if (i == 1 || i == 4 || i == 7) {
                    btn.frame = CGRectMake(btn1Width, (i / 3) * btnHeight, btn2Width, btnHeight);
                    [btn setBackgroundImage:[UIImage imageNamed:@"2_bg"] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:@"2_bg_clicked"] forState:UIControlStateSelected];
                }
                else if (i == 2 || i == 5 || i == 8) {
                    btn.frame = CGRectMake(btn3X, (i / 3) * btnHeight, btn1Width, btnHeight);
                    [btn setBackgroundImage:[UIImage imageNamed:@"1_bg"] forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:@"1_bg_clicked"] forState:UIControlStateSelected];
                }
                [btn setTitle:[NSString stringWithFormat:@"%d", i + 1]  forState:UIControlStateNormal];
                
                [btn setBackgroundImage:[UIImage imageNamed:@"1_bg"] forState:UIControlStateNormal];
                [btn setBackgroundImage:[UIImage imageNamed:@"1_bg_clicked"] forState:UIControlStateSelected];
            }else{
                
                if (self.second) {
                    btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:29 * __Scale];
                    if (i == 9) {
                        btn.frame = CGRectMake(0, (i / 3) * btnHeight, btn1Width, btnHeight);
                        [btn setBackgroundImage:[UIImage imageNamed:@"1_bg"] forState:UIControlStateNormal];
                        [btn setBackgroundImage:[UIImage imageNamed:@"1_bg_clicked"] forState:UIControlStateSelected];
                        [btn setTitle:@"上一步" forState:UIControlStateNormal];
                        btn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:29 * __Scale];
                    }
                    else if (i == 10) {
                        btn.frame = CGRectMake(btn1Width, (i / 3) * btnHeight, btn2Width, btnHeight);
                        [btn setBackgroundImage:[UIImage imageNamed:@"2_bg"] forState:UIControlStateNormal];
                        [btn setBackgroundImage:[UIImage imageNamed:@"2_bg_clicked"] forState:UIControlStateSelected];
                        [btn setTitle:@"0" forState:UIControlStateNormal];
                    }
                    else {
                        btn.frame = CGRectMake(btn1Width + btn2Width, (i / 3) * btnHeight, btn1Width, btnHeight);
                        [btn setBackgroundImage:[UIImage imageNamed:@"Return"] forState:UIControlStateNormal];
                        [btn setBackgroundImage:[UIImage imageNamed:@"Return_clicked"] forState:UIControlStateSelected];
                        UIImageView *imageView = [[UIImageView alloc] init];
                        imageView.image = [UIImage imageNamed:@"Backicon"];
                        imageView.frame = CGRectMake((btn.size.width - imageView.image.size.width) / 2, (btn.size.height - imageView.image.size.height) / 2, imageView.image.size.width, imageView.image.size.height);
                        [btn addSubview:imageView];
                    }
                }
                else {
                    btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:29 * __Scale];
                    if (i == 9) {
                        [btn setTitle:@"0" forState:UIControlStateNormal];
                        btn.frame = CGRectMake(0, btnHeight * 3, btn1Width + btn2Width, btnHeight);
                        [btn setBackgroundImage:[UIImage imageNamed:@"0_bg"] forState:UIControlStateNormal];
                        [btn setBackgroundImage:[UIImage imageNamed:@"0_bg_clicked"] forState:UIControlStateSelected];
                    }
                    else if (i == 10) {
                        btn.frame = CGRectMake(btn1Width + btn2Width, btnHeight * 3, btn1Width, btnHeight);
                        [btn setBackgroundImage:[UIImage imageNamed:@"Return"] forState:UIControlStateNormal];
                        [btn setBackgroundImage:[UIImage imageNamed:@"Return_clicked"] forState:UIControlStateSelected];
                        UIImageView *imageView = [[UIImageView alloc] init];
                        imageView.image = [UIImage imageNamed:@"Backicon"];
                        imageView.frame = CGRectMake((btn.size.width - imageView.image.size.width) / 2, (btn.size.height - imageView.image.size.height) / 2, imageView.image.size.width, imageView.image.size.height);
                        [btn addSubview:imageView];
                    }
                    else {
                        break;
                    }
                }
                
            }
            
            [btn addBorder:0.5 borderColor:[UIColor colorWithRed:140 / 255.0 green:140 / 255.0 blue:140 / 255.0 alpha:1.0]];
        }
        
    }
    return self;
}


-(void)didClick:(UIButton *)btn{
    
    
    if (_click != nil){
        
       _click(btn);
    }
    
   
}





@end
