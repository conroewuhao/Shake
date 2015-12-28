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

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface RootViewController ()
{
    UILabel *titleLabel;
    UILabel *contentLabel;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    //左边的按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_3"] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftButton)];
    //右边的按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_1"] style:UIBarButtonItemStylePlain target:self action:@selector(pressRightButton)];
    //设置导航栏背景色
    [self.navigationController.navigationBar setBarTintColor:[UIColor cyanColor]];
    
    //标题label
    if (!titleLabel) {
        titleLabel=[[UILabel alloc]init];
        [titleLabel setText:@"今天吃什么"];
        [titleLabel setTextColor:[UIColor redColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        
        titleLabel.frame=CGRectMake(kScreenWidth/2-40, 100, 100, 100);
        //titleLabel.center=CGPointMake(100, 200);
        [self.view addSubview:titleLabel];
    }
    
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
    FoodViewController *foot=[FoodViewController new];
    [self.navigationController pushViewController:foot animated:YES];


}

/**
 *  跳转到历史事件
 */
-(void)pressRightButton
{

    HistoryViewController *history=[HistoryViewController new];
    [self.navigationController pushViewController:history animated:YES];
    

}



-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{

    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [contentLabel setText:[[DBThings shareInstance]loadDB]];
    
    self.view.backgroundColor=[self changeColor];
    
    NSLog(@"motionbegan:%ld-----%@",(long)motion,event);

}



-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
   // AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSLog(@"motionend:%ld------%@",(long)motion,event);

}

-(UIColor *)changeColor
{
    float a=(float)(arc4random()%256/100);
    float b=(float)(arc4random()%256/100);
    float c=(float)(arc4random()%256/100);
    
    UIColor *color=[UIColor colorWithRed:a green:b blue:c alpha:1];
    return color;

}





@end
