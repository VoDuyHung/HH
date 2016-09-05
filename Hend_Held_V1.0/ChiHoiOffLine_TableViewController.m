//
//  ChiHoiOffLine_TableViewController.m
//  Hand Held
//
//  Created by Toan Nguyen Duc on 11/25/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "ChiHoiOffLine_TableViewController.h"
#import "CellMuaBan_TableViewCell.h"

@interface ChiHoiOffLine_TableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *tableview;
    NSString *threadKey ;
    NSString *tittleKey ;
}
@property NSMutableArray *tableData;
@end

@implementation ChiHoiOffLine_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellMuaBan_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellMuaBan_TableViewCell class])];
    self.tableData = [[NSMutableArray alloc ] initWithObjects:@"HÀ NỘI",@"SÀI GÒN",@"ĐÀ NẴNG",nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellMuaBan_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellMuaBan_TableViewCell class]) forIndexPath:indexPath];
    cell.lbl_icon.text=[self.tableData objectAtIndex:indexPath.row];
    cell.lbl_icon.font = [UIFont systemFontOfSize:13.0];
    cell.img_icon.image=[UIImage imageNamed:@"icon_muaban.png"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 1;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"chitietchihoi" sender:self];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if(indexPath.row==0){
        threadKey = @"1";
        tittleKey=@"HÀ NỘI";
    }
    else if (indexPath.row==1){
        threadKey = @"2";
        tittleKey=@"ĐÀ NẴNG";
    }else if (indexPath.row==2){
        threadKey = @"3";
        tittleKey=@"SÀI GÒN";
    }
    [defaults setObject:threadKey forKey:@"keyThreadId"];
    [defaults setObject:tittleKey forKey:@"keyTittle"];
    [defaults synchronize];
    NSLog(@"%@",threadKey);
    
}

- (void)runIndicatorAtIndexPath:(NSIndexPath *)indexPath display:(BOOL)playing{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryView = activityIndicator;
    playing == YES ?[activityIndicator startAnimating]:[activityIndicator stopAnimating];
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
}

@end
