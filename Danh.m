//
//  Danh.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/16/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "Danh.h"
#import "Danhmuc_.h"
#import "ViewController.h"
#import "DBManager.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

@interface Danh ()<MBProgressHUDDelegate>{
    //List of Myobject
    NSMutableArray *myObject;
    NSArray *searchResults;
    NSDictionary *dictionary;
    NSString *username;
    NSString *images_post;
    NSString *title;
    NSString *thread;
    NSString *post_date;
    NSString *user_Post;
    NSString *thread_id;
    NSString *content_html;
    NSString *url_post;
    NSString *post_id;
   NSMutableAttributedString *string ;
}
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrResult;
@property (nonatomic, retain) NSArray *listsearchPost;
@property (nonatomic, retain) NSArray *arrayPost;
@end
@implementation Danh
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self.Search_Bar setShowsScopeBar:NO];
    [self.Search_Bar sizeToFit];
    CGRect newBounds = self.tableView.bounds;
   newBounds.origin.y = newBounds.origin.y + self.Search_Bar.bounds.size.height;
    self.tableView.bounds = newBounds;
  
    //refresh post
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Kéo xuống để làm mới trang..."];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Đang làm mới dữ liệu..."];
    [refresh addTarget:self
                  action:@selector(refreshView:)
                  forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Danhmuc_ class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([Danhmuc_ class])];
    
}
-(void)loadData{
    //get thread and tittle from list node
    
    NSString *thread_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyThreadId"];
    NSString *tittle_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyTittle"];
    self.navigationItem.title = tittle_key;
    
    //tableview------------------------------------------
    title = @"title";
    images_post = @"thumbnail_cache_waindigo";
    user_Post=@"last_post_username";
    post_date=@"post_date";
    thread_id=@"thread_id";
    content_html=@"message_html";
    url_post=@"absolute_url";
    post_id=@"post_id";
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL)
        {
            limitNumberSubPage=@"20";
        }
        else
        {
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL)
        {
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }
        else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"])
        {
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }
        NSURL*url = [NSURL URLWithString:urlString];
        NSData * data=[NSData dataWithContentsOfURL:url];
        NSError * error;
        //return json values
        NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        for(NSDictionary * dict in json[@"threads"])
        {
            NSString *referanceArray = [dict valueForKey:@"title"];
            NSString *user_last_post=[dict valueForKey:@"last_post_username"];
            threadKey=[NSString stringWithFormat:@"%d",[[dict objectForKey:@"thread_id"] intValue]];
            //format datetime
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            int secondsLeft = [[dict objectForKey:@"post_date"] intValue];
            [dateFormatter setDateFormat:@"dd' Tháng 'MM',' yyyy"];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondsLeft];
            NSString *formattedDateString = [dateFormatter stringFromDate:date];
            //get images
            NSMutableArray * manghttp=[[NSMutableArray alloc] initWithArray:[[dict valueForKey:@"thumbnail_cache_waindigo"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]]];
            //get string url image in array
            NSString *hinhanh;
            if([[dict valueForKey:@"thumbnail_cache_waindigo"] isEqualToString:@""]){
                hinhanh=@"Could not get images!";
            }
            else{
                hinhanh = [manghttp objectAtIndex:3];
            }
            //add object include: key and value to myObject
            dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                          referanceArray,title,
                          user_last_post,user_Post,
                          formattedDateString,post_date,
                          threadKey,thread_id,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //search in myobject
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.title contains[c] %@",
                                    searchText];
       self.listsearchPost = [myObject filteredArrayUsingPredicate:resultPredicate];
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.listsearchPost count];
    }
    else
    {
        return [myObject count];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //setting number of cell when show list search or list post
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6;
}
//setting cell--------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *simpleTableIdentifier = @"Danhmuc_";
    Danhmuc_ *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  
    if (cell == nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"Danhmuc_" bundle:nil] forCellReuseIdentifier:simpleTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    }
    [cell.lbl_title addSubview:cell.img_load];
    //when tableview is search controller
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.lbl_changeSize.hidden=YES;
        NSDictionary *tmpDict1= [self.listsearchPost objectAtIndex:indexPath.section];
        cell.lbl_userPost.text=[tmpDict1 objectForKeyedSubscript:user_Post];
        cell.lbl_date.text=[tmpDict1 objectForKeyedSubscript:post_date];
        cell.lbl_title.text=[tmpDict1 objectForKeyedSubscript:title];
        NSString *str_02=[[tmpDict1 objectForKey:images_post] substringWithRange:NSMakeRange(0, 1)];
        if([str_02 isEqualToString:@"h"])
        {
            cell.img_load.hidden=NO;
            cell.image1.hidden=YES;
            NSString *htmlString = [NSString stringWithFormat:@"<img src='%@' width='450' height='350'>", [tmpDict1 objectForKey:images_post]];
            cell.img_load.scalesPageToFit=YES;
            [cell.img_load loadHTMLString:htmlString baseURL:nil];
            cell.img_load.scrollView.scrollEnabled = NO;
        }
        else
        {
            NSString *img=[tmpDict1 objectForKey:images_post];
            NSMutableString *img2=[NSMutableString stringWithString:@"http://www.handheld.com.vn/"];
            [img2 appendString:img];
            //NSLog(@"str:%@",img2);
            NSString *htmlString = [NSString stringWithFormat:@"<img src='%@' width='450' height='350'>", img2];
            //NSLog(@"%@",htmlString);
            cell.img_load.scalesPageToFit=YES;
            [cell.img_load loadHTMLString:htmlString baseURL:nil];
            cell.img_load.scrollView.scrollEnabled = NO;
           
        }
    }
    
    //when tableview is List post object
    else
    {
        NSDictionary *tmpDict= [myObject objectAtIndex:indexPath.section];
        cell.lbl_userPost.text=[tmpDict objectForKeyedSubscript:user_Post];
        cell.lbl_date.text=[tmpDict objectForKeyedSubscript:post_date];
        cell.lbl_title.text=[tmpDict objectForKeyedSubscript:title];
        if((long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"SizeText"] integerValue]>17)
        {
            //if size of slider >17 hidden lbl_content,lbl_date,lbl_title,lbl_userPost,img_load,image1 and just show lbl_changeSize
            cell.lbl_changeSize.hidden=NO;
            cell.lbl_changeSize.text=[tmpDict objectForKeyedSubscript:title];
            cell.lbl_changeSize.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:[[[NSUserDefaults standardUserDefaults] objectForKey:@"SizeText"] integerValue]];
            cell.image1.hidden=YES;
            cell.img_load.hidden=YES;
            
            
            
            cell.lbl_content.hidden=YES;
            cell.lbl_date.hidden=YES;
            cell.lbl_userPost.hidden=YES;
            cell.lbl_title.hidden=YES;
        }
        else
        {
            //show all and just hidden lbl_changeSize
            cell.lbl_changeSize.hidden=YES;
            NSString *str_02=[[tmpDict objectForKey:images_post] substringWithRange:NSMakeRange(0, 1)];
            cell.lbl_title.font=[UIFont fontWithName:@"HelveticaNeue-Medium" size:(long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"SizeText"] integerValue]];
            if([str_02 isEqualToString:@"h"]){
                cell.img_load.hidden=NO;
                cell.image1.hidden=YES;
                NSString *htmlString = [NSString stringWithFormat:@"<img src='%@' width='450' height='350'>", [tmpDict objectForKey:images_post]];
                cell.img_load.scalesPageToFit=YES;
                [cell.img_load loadHTMLString:htmlString baseURL:nil];
                cell.img_load.scrollView.scrollEnabled = NO;
                cell.img_load.delegate=nil;
            }
            else
            {
                NSString *img=[tmpDict objectForKey:images_post];
                NSMutableString *img2=[NSMutableString stringWithString:@"http://www.handheld.com.vn/"];
                [img2 appendString:img];
                NSString *htmlString = [NSString stringWithFormat:@"<img src='%@' width='450' height='350'>", img2];
                cell.img_load.scalesPageToFit=YES;
                [cell.img_load loadHTMLString:htmlString baseURL:nil];
                cell.img_load.scrollView.scrollEnabled = NO;
            }
        }
    }
    return cell;
}
//--------------------------------------------------------------
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //Check if the web view loadRequest is sending an error message
    NSLog(@"Error : %@",error);
}
//refresh
-(void)refreshView:(UIRefreshControl *)refresh {
        [myObject removeAllObjects];
        [self loadData];
       // custom refresh logic would be placed here...
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       [formatter setDateFormat:@"dd 'Tháng' MM YYYY, h:mm a"];
       NSString *lastUpdated = [NSString stringWithFormat:@"Đã được cập nhật lúc %@",
                                                                   [formatter stringFromDate:[NSDate date]]];
       refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
       [refresh endRefreshing];
}
-(NSString *)stringByStrippingHTML:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location     != NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tmpDict1 = [myObject objectAtIndex:indexPath.section];
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    //save to SQLite----------------------------------------------------------
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:title] forKey:@"TitleOf_Post"];
   // NSLog(@"ten:%@",[tmpDict1 objectForKeyedSubscript:title]);
    //user of post
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:user_Post] forKey:@"UserOf_Post"];
   // NSLog(@"name:%@",[tmpDict1 objectForKeyedSubscript:user_Post]);
    //date of post
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:post_date] forKey:@"DateOf_Post"];
    //NSLog(@"date:%@",[tmpDict1 objectForKeyedSubscript:post_date]);
    //send values post_id to Comment_ViewController
    [defaults1 setObject: [tmpDict1 objectForKeyedSubscript:thread_id] forKey:@"post_id"];
    //NSLog(@"id:%@",[tmpDict1 objectForKeyedSubscript:thread_id]);
    [defaults1 setObject:[tmpDict1 objectForKey:images_post] forKey:@"image_Post"];
    //NSLog(@"hinh:%@",[tmpDict1 objectForKey:images_post]);
    [defaults1 synchronize];
    [self performSegueWithIdentifier:@"chitietdanhmuc" sender:self];
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

- (IBAction)Search_Button:(id)sender {
    [self.Search_Bar becomeFirstResponder];
}
@end
