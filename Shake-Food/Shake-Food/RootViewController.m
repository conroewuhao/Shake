//
//  RootViewController.m
//  Shake-Food
//
//  Created by wuhao on 15/12/28.
//  Copyright © 2015年 wuhao. All rights reserved.
//

#import "RootViewController.h"
#import "FoodViewController.h"
#import "HistoryViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "DBThings.h"
#import "UIColor+HexColor.h"
#import "NSString+WHAddtion.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface RootViewController ()
{
    UILabel *titleLabel;//标题按钮
    UILabel *contentLabel;//吃饭内容标题
    UIButton *confirmButton;//确认按钮
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //左边的按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_add"] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftButton)];
    //右边的按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_time"] style:UIBarButtonItemStylePlain target:self action:@selector(pressRightButton)];
    //设置导航栏背景色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
 
    
    
    
    //标题label
    if (!titleLabel) {
        titleLabel=[[UILabel alloc]init];
        [titleLabel setText:@"摇一摇,今天吃什么"];
        [titleLabel setTextColor:[UIColor redColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        
        titleLabel.frame=CGRectMake(kScreenWidth/2-40, 100, 150, 100);
        //titleLabel.center=CGPointMake(100, 200);
        [self.view addSubview:titleLabel];
    }
    
    //内容标题
    if (!contentLabel) {        
        contentLabel=[[UILabel alloc]init];
       // NSString *str=[[DBThings shareInstance]loadDB];
        [contentLabel setText:@""];
        [contentLabel setTextColor:[UIColor blackColor]];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        
        contentLabel.frame=CGRectMake(kScreenWidth/2-40, 200, 100, 100);
        //titleLabel.center=CGPointMake(100, 200);
        [self.view addSubview:contentLabel];

    }

}

/**
 *  跳转到添加事件
 */
-(void)pressLeftButton
{
    FoodViewController *food=[FoodViewController new];
    [self.navigationController pushViewController:food animated:YES];
}

/**
 *  跳转到历史事件
 */
-(void)pressRightButton
{

    HistoryViewController *history=[HistoryViewController new];
    [self.navigationController pushViewController:history animated:YES];
    

}


/**
 *  开始摇动手机
 *
 *  @param motion motion
 *  @param event  event
 */
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{

    if (titleLabel) {
        [titleLabel setText:@"今天吃这个"];
    }
    
    
    if (!confirmButton || confirmButton.superview==nil) {
        confirmButton=[[UIButton alloc]init];
        confirmButton.frame=CGRectMake(kScreenWidth/2-40, 350, 100, 50);
        [confirmButton setTitle:@"好的" forState:UIControlStateNormal];
        [confirmButton setBackgroundColor:[UIColor clearColor]];
        [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        confirmButton.layer.masksToBounds=YES;
        confirmButton.layer.cornerRadius=5;
        [confirmButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [confirmButton.layer setBorderWidth:2];
        //确定按钮的点击事件
        [confirmButton addTarget:self action:@selector(pressConfirmButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:confirmButton];
    }
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [contentLabel setText:[[DBThings shareInstance]loadDBWithKeyString:@"foodArray"]];
    
    self.view.backgroundColor=[self changeBackgroundColor];
    
}

/**
 *  停止摇动手机
 *
 *  @param motion motion
 *  @param event  event
 */

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
   // AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSLog(@"motionend:%ld------%@",(long)motion,event);

}
/**
 *  点击好的按钮,增加效果
 */

-(void)pressConfirmButton{

//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.4];
//    [UIView setAnimationDelegate:self];
//    confirmButton.frame =CGRectMake(confirmButton.frame.origin.x,confirmButton.frame.origin.y,confirmButton.frame.size.width*2,confirmButton.frame.size.height);
//    [UIView commitAnimations];
    

    [UIView animateWithDuration:0.5 animations:^{
        
        CGAffineTransform transform=CGAffineTransformMakeScale(1.5, 1);
        [confirmButton setTransform:transform];

    }completion:^(BOOL finished) {
//        CGAffineTransform transform1=CGAffineTransformMakeScale(1, 1);
//        [confirmButton setTransform:transform1];
        if (confirmButton) {
            [confirmButton removeFromSuperview];
        }
        
    }];

    NSString *contentString=contentLabel.text;
    if (![NSString isStringEmpty:contentString]) {
        [[DBThings shareInstance]writeToDBWithContentAndDate:contentString];
    }
    else
        return;
  
}

/**
 *   改变背景颜色
 *
 *  @return UIColor
 */
-(UIColor *)changeBackgroundColor
{
    
    NSArray *arr=@[[UIColor colorWithHexString:@"#AF4111"],[UIColor cyanColor],[UIColor orangeColor],[UIColor colorWithHexString:@"#5D8749"],[UIColor colorWithHexString:@"5D879D"]];
    
    int i=arc4random()%(arr.count);
    return arr[i];

}


@end
