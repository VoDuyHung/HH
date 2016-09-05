//
//  ThanhVien_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/3/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "ThanhVien_TableViewController.h"
#import "CellThanhVien_TableViewCell.h"
#import "MBProgressHUD.h"

@interface ThanhVien_TableViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>{
    IBOutlet UITableView *tableview;
    NSString *threadKey ;
    NSString *tittleKey ;
}
@property NSMutableArray *tableData;
@property NSMutableArray *tableImages;
@end

@implementation ThanhVien_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellThanhVien_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellThanhVien_TableViewCell class])];
    self.tableData = [[NSMutableArray alloc ] initWithObjects:@"THÔNG BÁO - GÓP Ý",@"QUY ĐỊNH - HƯỚNG DẪN",@"SỰ KIỆN",@"HANDHELD CAFÉ",@"PHẢN HỒI GD MUA-BÁN & ĐẤU GIÁ",@"CHI HỘI & OFFLINE",nil];
    self.tableImages = [[NSMutableArray alloc ] initWithObjects:@"icon_thongbaogopy.png",@"icon_thietbideothongminh(60x60).png",@"icon_Sukien.png",@"icon_handheldcafe.png",@"icon_Phanhoigiaodichmuaban.png",@"icon_Chihoi.png",nil];
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
    CellThanhVien_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellThanhVien_TableViewCell class]) forIndexPath:indexPath];
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
   // cell.backgroundColor = [UIColor colorWithRed:0.341 green:0.420 blue:0.506 alpha:1.00];
    cell.lbl_icon.text=[self.tableData objectAtIndex:indexPath.section];
    cell.lbl_icon.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0];
    cell.ing_icon.image=[UIImage imageNamed:[self.tableImages objectAtIndex:indexPath.section]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==3){
        threadKey = @"33";
        tittleKey=@"HANDHELD CAFE";
        [self performSegueWithIdentifier:@"thanhvien1" sender:self];
    }
    else
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        if(indexPath.section==0){
            threadKey = @"38";
            tittleKey=@"THÔNG BÁO - GÓP Ý";
        }
        else if (indexPath.section==1){
            threadKey = @"163";
            tittleKey=@"QUY ĐỊNH - HƯỚNG DẪN";
        }else if (indexPath.section==2){
            threadKey = @"147";
            tittleKey=@"SỰ KIỆN";
        }
        else if (indexPath.section==4){
            threadKey = @"54";
            tittleKey=@"PHẢN HỒI GIAO DỊCH MUA - BÁN & ĐẤU GIÁ";
        }
        else if (indexPath.section==5){
            threadKey = @"171";
            tittleKey=@"CHI HỘI VÀ OFFLINE";
        }
        [defaults setObject:threadKey forKey:@"keyThreadId"];
        [defaults setObject:tittleKey forKey:@"keyTittle"];
        [defaults synchronize];
        
        NSLog(@"%@",threadKey);
        [self performSegueWithIdentifier:@"danhsachthanhvien" sender:self];
    
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
    //[self runIndicatorAtIndexPath:indexPath display:YES];
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self runIndicatorAtIndexPath:indexPath display:NO];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:threadKey forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKey forKey:@"keyTittle"];
}
- (IBAction)back:(id)sender {
    
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
