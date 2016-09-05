//
//  BAIDANGYEUTHICH_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/4/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "BAIDANGYEUTHICH_TableViewController.h"
#import "DBManager.h"
#import "CellBaiDangYeuThich_TableViewCell.h"
#import "MBProgressHUD.h"

@interface BAIDANGYEUTHICH_TableViewController ()<MBProgressHUDDelegate>{
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *tittle;
    NSString *content;
    NSString *detail ;
    NSString *name;
    NSString *date;
    NSString *images_post;
    NSString *Id_Post;
    UILabel *messageLabel;
}
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSMutableArray *arrResult;
@property (nonatomic) BOOL isAscending;
@end

@implementation BAIDANGYEUTHICH_TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    messageLabel.text = @"Hiện tại không có bài theo dõi nào!";
    messageLabel.textColor = [UIColor grayColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    [messageLabel sizeToFit];
    self.tableView.backgroundView = messageLabel;
    messageLabel.hidden = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellBaiDangYeuThich_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellBaiDangYeuThich_TableViewCell class])];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"FAVORITE_LIST.sqlite"];
    myObject = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat:@"%@", @"SELECT * FROM FV_LIST"];
    // Get the results.
    if (self.arrResult != nil) {
        self.arrResult = nil;
    }
    self.arrResult = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    for(int i=0; i<[self.arrResult count];i++){
        NSString *idpost = [[self.arrResult objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"ID_POST"]];
        NSString *Post_tittle = [[self.arrResult objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"TITTLE"]];
        NSString *Post_content = [[self.arrResult objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"CONTENT"]];
        NSString *Post_detail = [[self.arrResult objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"DETAIL"]];
        NSString *Post_name = [[self.arrResult objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"NAME"]];
        NSString *Post_date = [[self.arrResult objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"DATE"]];
        NSString *Post_images = [[self.arrResult objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"IMAGES"]];
             dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      //numberfm,thread_id,
                      Post_tittle,@"tittle",
                      Post_content,@"content",
                      Post_detail,@"detail",
                      Post_name,@"name",
                      Post_date,@"date",
                      Post_images,@"images_post",
                      idpost,@"Id_Post",
                      nil];
        [myObject addObject:dictionary];
    }
     [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(self.arrResult.count == 0){
        messageLabel.hidden = NO;
    }
    return self.arrResult.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellBaiDangYeuThich_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellBaiDangYeuThich_TableViewCell class]) forIndexPath:indexPath];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5; //seconds
    [cell addGestureRecognizer:lpgr];
    // Configure the cell-----------------------------------------
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.section];
    cell.lbl_content.text=[tmpDict objectForKeyedSubscript:@"tittle"];
    cell.lbl_name.text=[tmpDict objectForKeyedSubscript:@"date"];
    cell.lbl_date.text=[tmpDict objectForKeyedSubscript:@"name"];
    NSMutableString *images1;
    images1 =[tmpDict objectForKey:@"images_post"];
    NSString *str_02;
    str_02 = [images1 substringWithRange:NSMakeRange(0, 1)];
    if([str_02 isEqualToString:@"h"]){
        cell.img_load.hidden=NO;
        cell.img_Post.hidden=YES;
        NSString *htmlString = [NSString stringWithFormat:@"<img src='%@' width='450' height='350'>", [tmpDict objectForKey:@"images_post"]];
        cell.img_load.scalesPageToFit=YES;
        [cell.img_load loadHTMLString:htmlString baseURL:nil];
        cell.img_load.scrollView.scrollEnabled = NO;
    } else{
        cell.img_Post.hidden=NO;
        cell.img_load.hidden=YES;
        cell.img_Post.image=[UIImage imageNamed:@"HH!.jpg"];
    }
   
   
          return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102.0f;
}
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông báo"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Huỷ"
                                              otherButtonTitles:@"Xác nhận", nil];
    alertView.tag = tag;
    [alertView show];
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *titles = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([titles isEqualToString:@"Xác nhận"])
    {
        
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"idDeletePost"]!=NULL){
            NSString *query = [NSString stringWithFormat:@"DELETE FROM FV_LIST WHERE ID_POST=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"idDeletePost"]];
            [self.dbManager executeQuery:query];
            [self.arrResult removeAllObjects];
            [self viewDidLoad];

            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            
        }
            
        }else{
            NSLog(@"k ton tai bai dang");
        
    }
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    }
    else
    {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        {
            NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
            self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"FAVORITE_LIST.sqlite"];
           // NSDictionary *tmpDict1 = [myObject objectAtIndex:indexPath.row];
            
            NSString *idPost;
            idPost = [[self.arrResult objectAtIndex:indexPath.row] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"ID_POST"]];
            [defaults1 setObject:idPost forKey:@"idDeletePost"];
             [defaults1 synchronize];
            [self alertStatus:@"Bạn chắc chắn muốn xoá bài theo dõi này?" :@"" :0];
           
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"FAVORITE_LIST.sqlite"];
    NSDictionary *tmpDict1 = [myObject objectAtIndex:indexPath.section];
    //----------------------------------------------------------------
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:@"tittle"] forKey:@"TitleOf_Post"];
    //----------------------------------------------------------------
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:@"name"] forKey:@"UserOf_Post"];
    //----------------------------------------------------------------
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:@"date"] forKey:@"DateOf_Post"];
    //----------------------------------------------------------------
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:@"Id_Post"] forKey:@"post_id"];
    //----------------------------------------------------------------
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:@"content"] forKey:@"keyThreadId"];
    //----------------------------------------------------------------
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:@"detail"] forKey:@"keyTittle"];
    //----------------------------------------------------------------
    [defaults1 synchronize];
    //----------------------------------------------------------------
    [self performSegueWithIdentifier:@"docbaidangyeuthich" sender:self];
}
-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Đang làm mới dữ liệu..."];
    
    // custom refresh logic would be placed here...
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd 'Tháng' MM YYYY, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Đã được cập nhật lúc %@",
                             [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
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

@end
