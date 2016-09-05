//
//  Forum_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/3/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "Forum_TableViewController.h"
#import "CellForum_TableViewCell.h"

@interface Forum_TableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *tableview;
    
}
@property NSMutableArray *tableData;
@property NSMutableArray *tableImages;
@end

@implementation Forum_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellForum_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellForum_TableViewCell class])];
    self.tableData = [[NSMutableArray alloc ] initWithObjects:@"THÀNH VIÊN",@"PHONG CÁCH CÁ NHÂN",@"CÔNG NGHỆ",nil];
    self.tableImages = [[NSMutableArray alloc ] initWithObjects:@"icon_thanhvien.png",@"icon_xuhuongphongcah.png",@"icon_Thoitrang(60x60).png",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return [self.tableData count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
     return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   CellForum_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellForum_TableViewCell class]) forIndexPath:indexPath];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.lbl_icon.text=[self.tableData objectAtIndex:indexPath.section];
    cell.lbl_icon.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0];
    cell.img_icon.image=[UIImage imageNamed:[self.tableImages objectAtIndex:indexPath.section]];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *threadKey, *tittleKey;
    if(indexPath.section==0){
        [self performSegueWithIdentifier:@"thanhvien" sender:self];

        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        threadKey = @"12";
        tittleKey = @"THÀNH VIÊN";
        [defaults setObject:threadKey forKey:@"keyThreadId"];
        [defaults setObject:tittleKey forKey:@"KeyTittle"];
        [defaults synchronize];

    }
    else if (indexPath.section==1){
        [self performSegueWithIdentifier:@"xuhuongphongcach" sender:self];

        NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
        threadKey = @"148";
        tittleKey = @"XU HƯỚNG PHONG CÁCH";
        [defaults1 setObject:threadKey forKey:@"keyThreadId"];
        [defaults1 setObject:tittleKey forKey:@"KeyTittle"];
        [defaults1 synchronize];
    }else if (indexPath.section==2){
        [self performSegueWithIdentifier:@"thongtintraodoibanluan" sender:self];

        NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
        threadKey = @"148";
        tittleKey = @"THONG TIN TRAO DOI BAN LUAN";
        [defaults2 setObject:threadKey forKey:@"keyThreadId"];
        [defaults2 setObject:tittleKey forKey:@"KeyTittle"];
        [defaults2 synchronize];
    }
}

@end
