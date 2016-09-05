//
//  XuHuong_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/3/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "XuHuong_TableViewController.h"
#import "CellXuHuong_TableViewCell.h"
#import "MBProgressHUD.h"

@interface XuHuong_TableViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>{
    IBOutlet UITableView *tableview;
    NSString *threadKey ;
    NSString *tittleKey ;
}
@property NSMutableArray *tableData;
@property NSMutableArray *tableImages;

@end

@implementation XuHuong_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellXuHuong_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellXuHuong_TableViewCell class])];
    self.tableData = [[NSMutableArray alloc ] initWithObjects:@"MÁY THỜI GIAN - ĐỒNG HỒ",@"ÔTÔ - XE MÁY - XE ĐẠP",@"BÚT - MỰC - GIẤY",@"SMARTWEARS",@"LUXURY & HI-END",@"PHỤ KIỆN - THỜI TRANG",nil];
    self.tableImages = [[NSMutableArray alloc ] initWithObjects:@"icon_Maythoigiandongho(60x60).png",@"icon_otoxemay(60x60).png",@"icon_butmucgiay(60x60).png",@"icon_Thoitrangphukien(60x60).png",@"icon_Thoitrang(60x60).png",@"icon_Myphamnuochoa(60x60).png",nil];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellXuHuong_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellXuHuong_TableViewCell class]) forIndexPath:indexPath];
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
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if(indexPath.section==0){
       
        threadKey = @"85";
        tittleKey=@"MÁY THỜI GIAN - ĐỒNG HỒ";
       [self performSegueWithIdentifier:@"Phongcachcanhan" sender:self];
        
    }
    else if (indexPath.section==4){
        threadKey = @"25";
        tittleKey=@"LUXURY & HI-END";
        [self performSegueWithIdentifier:@"Phongcachcanhan" sender:self];
    }
    else
    {
     if (indexPath.section==1){
  
        threadKey = @"46";
        tittleKey=@"ÔTÔ - XE MÁY - XE ĐẠP";
     
    }else if (indexPath.section==2){
     
        threadKey = @"154";
        tittleKey=@"BÚT - MỰC - GIẤY";
       
    }
    else if (indexPath.section==3){
     
        threadKey = @"164";
        tittleKey=@"SMARTWEARS";
    
        
    }

    else if (indexPath.section==5){
      
        threadKey = @"165";
        tittleKey=@"PHỤ KIỆN - THỜI TRANG";
    
    }
    [defaults setObject:threadKey forKey:@"keyThreadId"];
    [defaults setObject:tittleKey forKey:@"keyTittle"];
    [defaults synchronize];
    NSLog(@"%@",threadKey);
    [self performSegueWithIdentifier:@"danhmucxuhuong" sender:self];
}
}
- (void)runIndicatorAtIndexPath:(NSIndexPath *)indexPath display:(BOOL)playing{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
    [hud hide:YES];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [self runIndicatorAtIndexPath:indexPath display:YES];
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self runIndicatorAtIndexPath:indexPath display:NO];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:threadKey forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKey forKey:@"keyTittle"];
    NSLog(@"thread = %@",threadKey);
}
- (IBAction)back:(id)sender {
    
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
