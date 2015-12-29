//
//  HistoryViewController.m
//  Shake-Food
//
//  Created by wuhao on 15/12/28.
//  Copyright © 2015年 wuhao. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    UITableView *historyTable;//table
    NSMutableArray *historyDataArray;//数据源

}
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"历史";

    historyDataArray=[[NSMutableArray alloc]init];
    
    [self checkData];
    
    historyTable=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    historyTable.delegate=self;
    historyTable.dataSource=self;
    [self.view addSubview:historyTable];
    

}

/**
 *  检索数据
 */
-(void)checkData{
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSMutableArray *arr=[def objectForKey:@"foodAndTimeArray"];
    
    if (arr && arr.count>0) {
        [historyDataArray removeAllObjects];
        historyDataArray=[NSMutableArray arrayWithArray:arr];
        
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"cellid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    
    if (!historyDataArray || historyDataArray.count==0) {
        return cell;
    }
    else{
    NSDictionary *dic=historyDataArray[indexPath.row];
    cell.textLabel.text=[dic objectForKey:@"contentString"];
        cell.detailTextLabel.text=[dic objectForKey:@"dateString"];}
    
    return cell;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return historyDataArray.count>0?historyDataArray.count:10;
    
}

@end
