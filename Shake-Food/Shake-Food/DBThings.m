//
//  DBThings.m
//  Shake-Food
//
//  Created by wuhao on 15/12/28.
//  Copyright © 2015年 wuhao. All rights reserved.
//

#import "DBThings.h"

@implementation DBThings

+(DBThings *)shareInstance
{
    static DBThings *dbthings=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbthings=[[DBThings alloc]init];
    });

    return dbthings;

}



-(NSString * )loadDB
{
    if (!_def) {
        _def=[NSUserDefaults standardUserDefaults];
    }
    NSMutableArray *arr=[_def objectForKey:@"foodArray"];
    if (arr && arr.count>0) {
        int i=arc4random()%(arr.count);
        NSString *str=arr[i];
        return str;
    }
    else return nil;
    
}













@end
