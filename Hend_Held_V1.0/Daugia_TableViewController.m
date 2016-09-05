//
//  Daugia_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/3/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "Daugia_TableViewController.h"
#import "CellDaugia_TableViewCell.h"
#import "MBProgressHUD.h"
@interface Daugia_TableViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>{
    IBOutlet UITableView *tableview;
    NSString *threadKey ;
    NSString *tittleKey;
    
}
@property NSMutableArray *tableData;

@end

@implementation Daugia_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellDaugia_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellDaugia_TableViewCell class])];
    self.tableData = [[NSMutableArray alloc ] initWithObjects:@"ĐẤU GIÁ HÀNG CÔNG NGHỆ",@"ĐẤU GIÁ CÁC MẶT HÀNG KHÁC",nil];
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
    return 1 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellDaugia_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellDaugia_TableViewCell class]) forIndexPath:indexPath];
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
    cell.img_icon.image=[UIImage imageNamed:@"icon_muaban.png"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0){
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        threadKey = @"65";
        tittleKey=@"ĐẤU GIÁ HÀNG CÔNG NGHỆ";
        [defaults setObject:threadKey forKey:@"keyThreadId"];
        [defaults setObject:tittleKey forKey:@"keyTittle"];
        [defaults synchronize];
    }
    else if (indexPath.section==1){
        NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
        threadKey = @"122";
        tittleKey=@"ĐẤU GIÁ CÁC MẶT HÀNG KHÁC";
        [defaults2 setObject:threadKey forKey:@"keyThreadId"];
        [defaults2 setObject:tittleKey forKey:@"keyTittle"];
        [defaults2 synchronize];
    }
    NSLog(@"%@",threadKey);
    [self performSegueWithIdentifier:@"danhmucdaugia" sender:self];
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
