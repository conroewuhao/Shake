//
//  DBThings.h
//  Shake-Food
//
//  Created by wuhao on 15/12/28.
//  Copyright © 2015年 wuhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBThings : NSObject

+(DBThings *)shareInstance;


-(NSString *)loadDB;


-(void)writeToDB;


@property(nonatomic,strong)NSUserDefaults *def;


@end
