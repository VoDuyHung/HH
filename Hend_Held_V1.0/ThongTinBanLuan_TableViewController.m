//
//  ThongTinBanLuan_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/3/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "ThongTinBanLuan_TableViewController.h"
#import "CellThongTinBanLuan_TableViewCell.h"
#import "MBProgressHUD.h"
@interface ThongTinBanLuan_TableViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>{
    IBOutlet UITableView *tableview;
    NSString *threadKey ;
    NSString *tittleKey ;
}
@property NSMutableArray *tableData;
@property NSMutableArray *tableImages;
@end

@implementation ThongTinBanLuan_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellThongTinBanLuan_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellThongTinBanLuan_TableViewCell class])];
    self.tableData = [[NSMutableArray alloc ] initWithObjects:@"TIN TỨC - THỜI SỰ CÔNG NGHỆ",@"MÁY TÍNH - LAPTOP",@"CAMERA - MÁY ẢNH SỐ",@"ÂM THANH - HÌNH ẢNH - MEDIA CENTER - HD CLUB",@"ĐIỆN THOẠI THÔNG MINH",@"IPAD - TABLET - MÁY ĐỌC SÁCH",@"THIẾT BỊ - MÁY MÓC KHÁC",@"THƯƠNG MẠI ĐIỆN TỬ",nil];
    self.tableImages = [[NSMutableArray alloc ] initWithObjects:@"icon_tintuc(60x60).png",@"icon_maytinhxahctay(60x60).png",@"icon_camera(60x60).png",@"icon_HD(60x60).png",@"icon_Dienthoaithongminh(60x60).png",@"icon_Ipadteblet(60x60).png",@"icon_phanhoigiaodichdaugia(60x60).png",@"icon_thuongmaidientu(60x60).png",nil];
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
    CellThongTinBanLuan_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellThongTinBanLuan_TableViewCell class]) forIndexPath:indexPath];
    
    cell.lbl_icon.text=[self.tableData objectAtIndex:indexPath.section];
    cell.lbl_icon.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0];
    cell.img_icon.image=[UIImage imageNamed:[self.tableImages objectAtIndex:indexPath.section]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if (indexPath.section==2){
        threadKey = @"69";
        tittleKey=@"CAMERA - MÁY ẢNH SỐ";
        [self performSegueWithIdentifier:@"mayanh" sender:self];
    }
    else if (indexPath.section==1){
        threadKey = @"11";
        tittleKey=@"MÁY TÍNH - LAPTOP";
        [self performSegueWithIdentifier:@"mayanh" sender:self];
    }
    else if (indexPath.section==3){
        threadKey = @"105";
        tittleKey=@"ÂM THANH - HÌNH ẢNH - MEDIA CENTER - HD CLUB";
        [self performSegueWithIdentifier:@"mayanh" sender:self];
    }
    else if (indexPath.section==4){
        threadKey = @"73";
        tittleKey=@"ĐIỆN THOẠI THÔNG MINH";
        [self performSegueWithIdentifier:@"mayanh" sender:self];
    }
    else
    {
        if(indexPath.section==0){
            threadKey = @"172";
            tittleKey=@"TIN TỨC - THỜI SỰ CÔNG NGHỆ";
        }

        else if (indexPath.section==5){
            threadKey = @"95";
            tittleKey=@"IPAD - TABLET - MÁY ĐỌC SÁCH";
        }
        else if (indexPath.section==6){
            threadKey = @"166";
            tittleKey=@"THIẾT BỊ - MÁY MÓC KHÁC";
        }
        else if (indexPath.section==7){
            threadKey = @"140";
            tittleKey=@"THƯƠNG MẠI ĐIỆN TỬ";
        }
        
        [self performSegueWithIdentifier:@"danhsachthongtintraodoi" sender:self];
    }
    [defaults setObject:threadKey forKey:@"keyThreadId"];
    [defaults setObject:tittleKey forKey:@"keyTittle"];
    [defaults synchronize];
    NSLog(@"%@",threadKey);
    NSLog(@"%@",tittleKey);
    
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
