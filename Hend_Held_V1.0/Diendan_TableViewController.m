//
//  Diendan_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/3/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "Diendan_TableViewController.h"
#import "CellDiendan_TableViewCell.h"
@interface Diendan_TableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *tableview;
}
@property NSMutableArray *tableData;
@end

@implementation Diendan_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellDiendan_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellDiendan_TableViewCell class])];
    
    //NSUserDefaults *defaul = [NSUserDefaults standardUserDefaults];
    //threadKey = [defaul stringForKey:@"keyThreadId"];
    self.tableData = [[NSMutableArray alloc ] initWithObjects:@"THÀNH VIÊN",@"XU HƯỚNG - PHONG CÁCH",@"THÔNG TIN - TRAO ĐỔI - BÀN LUẬN",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifile = @"Cell";
    CellDiendan_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifile];
    if(cell==nil){
        cell= [[CellDiendan_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifile];
    }
    
    
    // Configure the cell...
    cell.lblMuc.font = [UIFont systemFontOfSize:11.0];
    cell.lblMuc.text = [self.tableData objectAtIndex:indexPath.row];
    //cell.textLabel.frame= CGRectMake(50.0, 2.0, 20.0, 3.0);
    
    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
