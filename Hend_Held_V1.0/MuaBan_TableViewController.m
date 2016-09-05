//
//  MuaBan_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/3/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "MuaBan_TableViewController.h"
#import "CellMuaBan_TableViewCell.h"
#import "MBProgressHUD.h"

@interface MuaBan_TableViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>{
    IBOutlet UITableView *tableview;
    NSString *threadKey ;
    NSString *tittleKey ;
    
}
@property NSMutableArray *tableData;
@end

@implementation MuaBan_TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellMuaBan_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellMuaBan_TableViewCell class])];
    self.tableData = [[NSMutableArray alloc ] initWithObjects:@"KINH DOANH CHUYÊN NGHIỆP",@"MÁY TÍNH - LAPTOP",@"IPAD - MÁY TÍNH BẢNG - MÁY ĐỌC SÁCH",@"SMARTPHONE - ĐIỆN THOẠI",@"CÁC MẶT HÀNG PHỤ KIỆN CÔNG NGHỆ KHÁC",@"ĐỒNG HỒ & PHỤ KIỆN",@"ÔTÔ - XE MÁY - XE ĐẠP",@"BÚT - MỰC & PHỤ KIỆN",@"QUẦN ÁO & GIÀY DÉP",@"HOÁ MỸ PHẨM - KÍNH & PHỤ KIỆN THỜI TRANG",@"ĐỒ GIA DỤNG - THIẾT BỊ VĂN PHÒNG - ĐỒ CHƠI",@"BẤT ĐỘNG SẢN - NHÀ ĐẤT - TRANG THIẾT BỊ XÂY DỰNG",@"RAO VẶT",@"TƯ VẤN LỰ CHỌN VÀ MUA SẮM",nil];
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
    
    return 7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellMuaBan_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellMuaBan_TableViewCell class]) forIndexPath:indexPath];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) //tăng seoarator full for table
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
    cell.img_icon.image=[UIImage imageNamed:@"icon_muaban.png"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"danhmuc" sender:self];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
   
    if(indexPath.section==0){
        threadKey = @"148";
        tittleKey=@"KINH DOANH CHUYÊN NGHIỆP";
    }
    else if (indexPath.section==1){
        threadKey = @"158";
        tittleKey=@"MÁY TÍNH - LAPTOP";
    }else if (indexPath.section==2){
        threadKey = @"157";
        tittleKey=@"IPAD - MÁY TÍNH BẢNG - MÁY ĐỌC SÁCH";
    }
    else if (indexPath.section==3){
        threadKey = @"58";
        tittleKey=@"SMARTPHONE - ĐIỆN THOẠI";
    }
    else if (indexPath.section==4){
        threadKey = @"159";
        tittleKey=@"CÁC MẶT HÀNG PHỤ KIỆN CÔNG NGHỆ KHÁC";
    }
    else if (indexPath.row==5){
        threadKey = @"160";
        tittleKey=@"ĐỒNG HỒ & PHỤ KIỆN";
    }
    else if (indexPath.section==6){
        threadKey = @"102";
        tittleKey=@"ÔTÔ - XE MÁY - XE ĐẠP";
    }
    else if (indexPath.section==7){
        threadKey = @"170";
        tittleKey=@"BÚT - MỰC & PHỤ KIỆN";
    }
    else if (indexPath.section==8){
        threadKey = @"167";
        tittleKey=@"QUẦN ÁO & GIÀY DÉP";
    }
    else if (indexPath.section==9){
        threadKey = @"168";
        tittleKey=@"HOÁ MỸ PHẨM - KÍNH & PHỤ KIỆN THỜI TRANG";
    }
    else if (indexPath.section==10){
        threadKey = @"4";
        tittleKey=@"ĐỒ GIA DỤNG - THIẾT BỊ VĂN PHÒNG - ĐỒ CHƠI";
    }
    else if (indexPath.section==11){
        threadKey = @"169";
        tittleKey=@"BẤT ĐỘNG SẢN - NHÀ ĐẤT - TRANG THIẾT BỊ XÂY DỰNG";
    }
    else if (indexPath.section==12){
        threadKey = @"75";
        tittleKey=@"RAO VẶT";
    }
    else if (indexPath.section==13){
        threadKey = @"26";
        tittleKey=@"TƯ VẤN LỰ CHỌN VÀ MUA SẮM";
    }
    [defaults setObject:threadKey forKey:@"keyThreadId"];
    [defaults setObject:tittleKey forKey:@"keyTittle"];
    [defaults synchronize];
    NSLog(@"%@",threadKey);
    
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
