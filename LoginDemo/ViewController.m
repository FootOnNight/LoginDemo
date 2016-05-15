//
//  ViewController.m
//  LoginDemo
//
//  Created by szjy on 16/4/27.
//  Copyright © 2016年 szjy. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Addition.h"
#import "KeyBoardView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController () <UITextFieldDelegate>
{
    UITextField     *phoneTextField1;
    UITextField     *phoneTextField2;
    UIButton        *getCodeButton;
    UIButton        *reGetCodeButton;
    UIView          *getCodeView;
    UIView          *inputCodeView;
    KeyBoardView    *keyboard1;
    KeyBoardView    *keyboard2;
}

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *familyNames = [UIFont familyNames];
    for(NSString *familyName in familyNames)
    {
        NSLog(@"%@", familyName);
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for(NSString *fontName in fontNames)
        {
            NSLog(@"\t%@", fontName);
        }  
    }
    
    // 播放短视频
    self.moviePlayer.initialPlaybackTime = -1.0;
    [self.moviePlayer setShouldAutoplay:NO];
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
    
    // 添加子视图
    [self createSubViews];
}


- (void)createSubViews
{
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.frame = CGRectMake(0, 78, 56 * __Scale, 69 * __Scale);
    logoView.centerX = ScreenWidth / 2;
    [logoView setImage:[UIImage imageNamed:@"logo"]];
    logoView.image = [UIImage imageNamed:@"logo"];
//    logoView.image = [UIImage imageNamed:@"Aerial01.jpg"];
    [self.view addSubview:logoView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, logoView.bottom + 20 * __Scale, 132 * __Scale, 24);
    titleLabel.centerX = ScreenWidth / 2;
    titleLabel.text = @"亲见，看得见";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20 * __Scale];
    [self.view addSubview:titleLabel];
    
    getCodeView = [[UIView alloc] init];
    getCodeView.frame = CGRectMake(0, ScreenHeight - 19 * __Scale - 44, ScreenWidth, 44);
    [self.view addSubview:getCodeView];
    
    phoneTextField1 = [[UITextField alloc] init];
    phoneTextField1.delegate = self;
//    phoneTextField1.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    phoneTextField1.frame = CGRectMake(10 * __Scale, 0, 223 * __Scale, 44);
    phoneTextField1.layer.cornerRadius = 5.;
    phoneTextField1.layer.borderWidth = 1;
    phoneTextField1.layer.borderColor = [UIColor whiteColor].CGColor;
    phoneTextField1.borderStyle = UITextBorderStyleRoundedRect;
    phoneTextField1.backgroundColor = [UIColor clearColor];
    phoneTextField1.textColor = [UIColor whiteColor];
    phoneTextField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneTextField1.placeholder = @"请填写手机号";
    phoneTextField1.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *placeholderLabel1 = [phoneTextField1 valueForKeyPath:@"_placeholderLabel"];
    placeholderLabel1.textColor = [UIColor whiteColor];
    placeholderLabel1.font = [UIFont systemFontOfSize:14 * __Scale];
//    phoneTextField.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
    [getCodeView addSubview:phoneTextField1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:phoneTextField1];
//    [phoneTextField1 addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getCodeButton.frame = CGRectMake(CGRectGetMaxX(phoneTextField1.frame) + 10 * __Scale, phoneTextField1.top, 122 * __Scale, phoneTextField1.height);
    //    [getCodeButton setTitleColor:[UIColor getNColor:QJCOLOR_g9] forState:UIControlStateNormal];
    [getCodeButton setTitleColor:UIColorFromRGB(0x6576C5) forState:UIControlStateNormal];
    [getCodeButton setBackgroundColor:[UIColor whiteColor]];
    //    getCodeButton.titleLabel.font = [UIFont systemFontOfQSize:QJFontSize_T4];
    [getCodeButton setTitle:(@"获取验证码") forState:UIControlStateNormal];
    getCodeButton.titleLabel.font = [UIFont systemFontOfSize:14 * __Scale];
    [getCodeButton addTarget:self action:@selector(getCodeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [getCodeButton setClipsToBounds:YES];
    [getCodeButton.layer setCornerRadius:5.];
    //    [self setButtonEnable:NO];
    [getCodeView addSubview:getCodeButton];
    
    keyboard1 = [[KeyBoardView alloc] initWithClick:^(UIButton *btn) {
        
        if (btn.tag != 110) {
            phoneTextField1.text = [phoneTextField1.text stringByAppendingString:btn.titleLabel.text];
        }
        else {
            if (phoneTextField1.text.length != 0) {
                phoneTextField1.text = [phoneTextField1.text substringToIndex:phoneTextField1.text.length - 1];
            }
        }
        
    } isSecond:NO];
    
    keyboard1.frame = CGRectMake(0, ScreenHeight, ScreenWidth, KeyboardHeight);
    [self.view addSubview:keyboard1];
    
    // 点击获取验证码滑动到输入验证码界面
    inputCodeView = [[UIView alloc] init];
    inputCodeView.frame = CGRectMake(ScreenWidth, ScreenHeight - 19 * __Scale - 44 - KeyboardHeight, ScreenWidth, 44);
    [self.view addSubview:inputCodeView];
    
    phoneTextField2 = [[UITextField alloc] init];
    phoneTextField2.delegate = self;
    phoneTextField2.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    phoneTextField2.frame = CGRectMake(10 * __Scale, 0, 223 * __Scale, 44);
    phoneTextField2.layer.cornerRadius = 5.;
    phoneTextField2.layer.borderWidth = 1;
    phoneTextField2.layer.borderColor = [UIColor whiteColor].CGColor;
    phoneTextField2.borderStyle = UITextBorderStyleRoundedRect;
    phoneTextField2.backgroundColor = [UIColor clearColor];
    phoneTextField2.textColor = [UIColor whiteColor];
    phoneTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneTextField2.placeholder = @"请填写验证码";
    UILabel *placeholderLabel2 = [phoneTextField2 valueForKeyPath:@"_placeholderLabel"];
    placeholderLabel2.textColor = [UIColor whiteColor];
    placeholderLabel2.font = [UIFont systemFontOfSize:14 * __Scale];
    //    phoneTextField.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
    [inputCodeView addSubview:phoneTextField2];

    
    reGetCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reGetCodeButton.frame = CGRectMake(CGRectGetMaxX(phoneTextField1.frame) + 10 * __Scale, phoneTextField1.top, 122 * __Scale, phoneTextField1.height);
    //    [getCodeButton setTitleColor:[UIColor getNColor:QJCOLOR_g9] forState:UIControlStateNormal];
    [reGetCodeButton setTitleColor:UIColorFromRGB(0x6576C5) forState:UIControlStateNormal];
    [reGetCodeButton setBackgroundColor:[UIColor whiteColor]];
    //    getCodeButton.titleLabel.font = [UIFont systemFontOfQSize:QJFontSize_T4];
    [reGetCodeButton setTitle:(@"重新获取验证码") forState:UIControlStateNormal];
    reGetCodeButton.titleLabel.font = [UIFont systemFontOfSize:14 * __Scale];
    [reGetCodeButton addTarget:self action:@selector(getCodeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [reGetCodeButton setClipsToBounds:YES];
    [reGetCodeButton.layer setCornerRadius:5.];
    //    [self setButtonEnable:NO];
    reGetCodeButton.enabled = NO;
    [inputCodeView addSubview:reGetCodeButton];
    
    keyboard2 = [[KeyBoardView alloc] initWithClick:^(UIButton *btn) {
        
        if (btn.tag == 109) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect getCodeViewFrame = getCodeView.frame;
                getCodeViewFrame.origin.x += ScreenWidth;
                getCodeView.frame = getCodeViewFrame;
                
                CGRect keyboard1Frame = keyboard1.frame;
                keyboard1Frame.origin.x += ScreenWidth;
                keyboard1.frame = keyboard1Frame;
                
                CGRect inputCodeViewFrame = inputCodeView.frame;
                inputCodeViewFrame.origin.x += ScreenWidth;
                inputCodeView.frame = inputCodeViewFrame;
                
                CGRect keyboard2Frame = keyboard2.frame;
                keyboard2Frame.origin.x += ScreenWidth;
                keyboard2.frame = keyboard2Frame;
            }];
            phoneTextField1.text = @"";
        }
        else if(btn.tag == 111) {
            if (phoneTextField2.text.length != 0) {
                phoneTextField2.text = [phoneTextField2.text substringToIndex:phoneTextField2.text.length - 1];
            }
        }
        else {
            phoneTextField2.text = [phoneTextField2.text stringByAppendingString:btn.titleLabel.text];
        }
        
    } isSecond:YES];
    
    keyboard2.frame = CGRectMake(ScreenWidth, ScreenHeight - KeyboardHeight, ScreenWidth, KeyboardHeight);
    [self.view addSubview:keyboard2];
}



#pragma mark - 点击获取验证码
- (void)getCodeButtonClicked
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect getCodeViewFrame = getCodeView.frame;
        getCodeViewFrame.origin.x -= ScreenWidth;
        getCodeView.frame = getCodeViewFrame;
        
        CGRect keyboard1Frame = keyboard1.frame;
        keyboard1Frame.origin.x -= ScreenWidth;
        keyboard1.frame = keyboard1Frame;
        
        CGRect inputCodeViewFrame = inputCodeView.frame;
        inputCodeViewFrame.origin.x -= ScreenWidth;
        inputCodeView.frame = inputCodeViewFrame;
        
        CGRect keyboard2Frame = keyboard2.frame;
        keyboard2Frame.origin.x -= ScreenWidth;
        keyboard2.frame = keyboard2Frame;
    }];
}

-(void)inputViewDismissOrappearWithAnimation: (BOOL)appear{
    
    if (appear){
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            //如果用autoLayout就好多了
            
            if (keyboard1.frame.origin.y == ScreenHeight){
                
                CGRect getCodeViewFrame = getCodeView.frame;
                
                getCodeViewFrame.origin.y -= KeyboardHeight;
                
                getCodeView.frame = getCodeViewFrame;
                
                
                CGRect keyboard1Frame = keyboard1.frame;
                
                keyboard1Frame.origin.y -= KeyboardHeight;
                
                keyboard1.frame = keyboard1Frame;
                
            }
            
            
        } completion:nil];
        
        
    }else{
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (keyboard1.frame.origin.y < ScreenHeight) {
                
                CGRect getCodeViewFrame = getCodeView.frame;
                
                getCodeViewFrame.origin.y += KeyboardHeight;
                
                getCodeView.frame = getCodeViewFrame;
                
                
                CGRect keyboard1Frame = keyboard1.frame;
                
                keyboard1Frame.origin.y += KeyboardHeight;
                
                keyboard1.frame = keyboard1Frame;
                
            }
            
        } completion:nil];
        
    }
}



#pragma mark - 私有方法
/**
 *  取得本地文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getFileUrl{
    NSString *urlStr=[[NSBundle mainBundle] pathForResource:@"源视频" ofType:@"mp4"];
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
-(NSURL *)getNetworkUrl{
    NSString *urlStr=@"http://192.168.1.161/The New Look of OS X Yosemite.mp4";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    return url;
}

/**
 *  创建媒体播放控制器
 *
 *  @return 媒体播放控制器
 */
-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSURL *url=[self getFileUrl];
        _moviePlayer=[[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame=self.view.bounds;
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _moviePlayer.scalingMode=MPMovieScalingModeAspectFill;
        _moviePlayer.controlStyle = MPMovieControlStyleNone;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    [self inputViewDismissOrappearWithAnimation:NO];
    
    [phoneTextField1 resignFirstResponder];
    [phoneTextField2 resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    [phoneTextField1 resignFirstResponder];
    [self inputViewDismissOrappearWithAnimation:YES];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
