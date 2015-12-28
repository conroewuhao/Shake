//
//  FoodViewController.m
//  Shake-Food
//
//  Created by wuhao on 15/12/28.
//  Copyright © 2015年 wuhao. All rights reserved.
//

#import "FoodViewController.h"

@interface FoodViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *table;
    NSMutableArray *dataArray;
}

@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArray=[[NSMutableArray alloc]init];
    
    //检查数组数据
    [self checkData];
    
    self.title=@"菜单";
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pressPlusButton)];
    
    table=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    table.delegate=self;
    table.dataSource=self;
    [self.view addSubview:table];
    
    
}


-(void)checkData{

    dataArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"foodArray"];
    
    if (dataArray.count>0) {
        [table reloadData];
    }
    
}


-(void)pressPlusButton{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"添加" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle=UIAlertViewStylePlainTextInput;
        alert.delegate=self;
    [alert show];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"cellid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.text=dataArray[indexPath.row];
    
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray?dataArray.count:10;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
        return;
    }
    if (buttonIndex==1) {
        
        UITextField *tf=[alertView textFieldAtIndex:0];
        if (tf.text!=nil) {
            [self saveToLocalWithContent:tf.text];
        }
    }
    
}

-(void)saveToLocalWithContent:(NSString *)string{


    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSMutableArray *localArr=[def objectForKey:@"foodArray"];
    if (!localArr) {
        localArr=[[NSMutableArray alloc]init];
        [localArr addObject:string];
        [def setObject:localArr forKey:@"foodArray"];
        [def synchronize];
        [self checkData];
       // [table reloadData];
        
    }
    if (localArr && localArr.count>0) {
        
        NSMutableArray *arr=[NSMutableArray arrayWithArray:localArr];
        [arr addObject:string];
        [def setObject:arr forKey:@"foodArray"];
       [def synchronize];
        [self checkData];
        
    }
    
}






@end
