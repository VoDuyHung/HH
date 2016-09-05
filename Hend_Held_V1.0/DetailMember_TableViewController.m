//
//  DetailMember_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/4/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "DetailMember_TableViewController.h"
#import "CellDetailMember_TableViewCell.h"
#import "DBManager.h"

@interface DetailMember_TableViewController (){
    //khai bao danh sach cac bien trong myobject
    NSMutableArray *myObject;
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
}
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrResult;

@end

@implementation DetailMember_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Kéo xuống để làm mới trang..."];
    [refresh addTarget:self
                action:@selector(refreshView:)
      forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    //get key from TableViewController----------------------------------------------
    NSString *thread_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyThreadId"];
    
    NSString *tittle_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyTittle"];
    self.navigationItem.title = tittle_key;
    
    //khai bao tableview------------------------------------------
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CellDetailMember_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CellDetailMember_TableViewCell class])];
    title = @"title";
    images_post = @"thumbnail_cache_waindigo";
    user_Post=@"last_post_username";
    post_date=@"post_date";
    thread_id=@"thread_id";
    content_html=@"message_html";
    url_post=@"absolute_url";
    post_id=@"post_id";
    NSString *threadKey;
    myObject = [[NSMutableArray alloc] init];
    // goi bien USER_NAME & HASH_KEY  tu ben class ViewController;
    //su dung SQLite------------------------------------------
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"USERDB.sqlite"];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM USERTABLE"];
    
    // Get the results.
    if (self.arrResult != nil) {
        self.arrResult = nil;
    }
    self.arrResult = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSString *hashKey = [[self.arrResult objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"HASHKEY"]];
    NSString *useName = [[self.arrResult objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"USERNAME"]];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //truyen username va hashkey vao trong chuoi json----------------------------------
    NSString *urlString = [NSString  stringWithFormat: @"http://dev.handheld.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=50&order_by=post_date", useName , hashKey, thread_key];
    NSURL*url = [NSURL URLWithString:urlString];
    
    
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;
    //trả về giá trị json
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    //lap theo gia tri cua threads
    NSArray * responseArr = json[@"threads"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    for(NSDictionary * dict in responseArr)
    {
        //lay title
        NSString *referanceArray = [dict valueForKey:@"title"];
        //lay link hinh
        NSString *periodArray =[dict valueForKey:@"thumbnail_cache_waindigo"];
        
        NSString *user_last_post=[dict valueForKey:@"last_post_username"];
        //lay ngay
        int secondsLeft = [[dict objectForKey:@"post_date"] intValue];
        
        int tempThread = [[dict objectForKey:@"thread_id"] intValue];
        threadKey=[NSString stringWithFormat:@"%d",tempThread];
        //convert ngay
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondsLeft];
        NSString *formattedDateString = [dateFormatter stringFromDate:date];
        
        NSString *searchedString = periodArray;
        //cat chuỗi để lấy ra link hình ảnh-------------------------------
        NSArray *myWords = [searchedString componentsSeparatedByCharactersInSet:
                            [NSCharacterSet characterSetWithCharactersInString:@"\""]
                            ];
        NSMutableArray * manghttp=[[NSMutableArray alloc] initWithArray:myWords];
        //lấy chuỗi link hình trong mảng
        NSString *hinhanh = [manghttp objectAtIndex:3];
        
        //code get content of post-----------------------------------------------------------------
        NSString *urlStringContent = [NSString  stringWithFormat: @"http://dev.handheld.vn/api.php?action=getPosts&hash=%@:%@&node_id=%@&thread_id=%@", useName , hashKey, thread_key, threadKey];
        NSURL*urlContent = [NSURL URLWithString:urlStringContent];
        
        
        NSData * dataContent=[NSData dataWithContentsOfURL:urlContent];
        
        NSError * errorContent;
        //trả về giá trị json
        NSMutableDictionary  * jsonContent = [NSJSONSerialization JSONObjectWithData:dataContent options: NSJSONReadingMutableContainers error: &errorContent];
        
        NSArray * responseArrContent = jsonContent[@"posts"];
        NSString *htmlOfContent;
        NSString *urlForShare;
        // NSLog(@"%@",threadKey);
        htmlOfContent = [responseArrContent[0] valueForKey:@"message_html"];
        //get link url of post for share
        urlForShare = [responseArrContent[0] valueForKey:@"absolute_url"];
        
        
        //end code----------------------------------------------------------------------------------------
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      //numberfm,thread_id,
                      referanceArray,title,
                      hinhanh,images_post,
                      user_last_post,user_Post,
                      formattedDateString,post_date,
                      threadKey,thread_id,
                      htmlOfContent,content_html,
                      urlForShare,url_post,
                      //postId,post_id,
                      nil];
        [myObject addObject:dictionary];
    }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }

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
    // Return the number of rows in the section.
    return myObject.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellDetailMember_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CellDetailMember_TableViewCell class]) forIndexPath:indexPath];
    
    // Configure the cell-----------------------------------------
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *text;
    
    text = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:title]];
    
    NSMutableString *userPost;;
    
    userPost = [NSMutableString stringWithFormat:@"%@",
                [tmpDict objectForKeyedSubscript:user_Post]];
    
    
    NSMutableString *datePost;;
    
    datePost = [NSMutableString stringWithFormat:@"%@",
                [tmpDict objectForKeyedSubscript:post_date]];
    
    NSMutableString *content;
    
    content =[NSMutableString stringWithFormat:@"%@",
              [tmpDict objectForKeyedSubscript:content_html]];
    NSLog(@"%@",content);
    //xử lý hình ảnh.
    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:images_post]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    cell.lbl_title.text=text;
    cell.lbl_userPost.text=userPost;
    cell.lbl_date.text=datePost;
    
    
    //show html-----------------------------------------
    NSString* strWithoutFormatting = [self stringByStrippingHTML:content];
    cell.lbl_content.text=strWithoutFormatting;
    
    if(img==NULL){
        cell.image1.image=[UIImage imageNamed:@"imageH.png"];
    }
    else{
        cell.image1.image=img;
    }
    return cell;
}
//refresh
-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Đang làm mới dữ liệu..."];
    
    // custom refresh logic would be placed here...
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
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
    NSDictionary *tmpDict1 = [myObject objectAtIndex:indexPath.row];
    NSMutableString *content1;
    NSMutableString *urlSendtoShare;
    NSMutableString *postId_key;
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    
    //save to SQLite----------------------------------------------------------
    NSMutableString *saveTittle, *saveUser, *saveDate, *saveContent;
    //tittle of post
    saveTittle =[NSMutableString stringWithFormat:@"%@",
                 [tmpDict1 objectForKeyedSubscript:title]];
    [defaults1 setObject:saveTittle forKey:@"TitleOf_Post"];
    NSLog(@"%@",saveTittle);
    //user of post
    saveUser =[NSMutableString stringWithFormat:@"%@",
               [tmpDict1 objectForKeyedSubscript:user_Post]];
    [defaults1 setObject:saveUser forKey:@"UserOf_Post"];
    // [defaults1 synchronize];
    //date of post
    saveDate =[NSMutableString stringWithFormat:@"%@",
               [tmpDict1 objectForKeyedSubscript:post_date]];
    [defaults1 setObject:saveDate forKey:@"DateOf_Post"];
    //[defaults1 synchronize];
    //content of post
    saveContent =[NSMutableString stringWithFormat:@"%@",
                  [tmpDict1 objectForKeyedSubscript:content_html]];
    NSString* strWithoutFormatting = [self stringByStrippingHTML:saveContent];
    [defaults1 setObject:strWithoutFormatting forKey:@"ContentOf_Post"];
    //[defaults1 synchronize];
    
    //-------------------------------------------------------------------------
    content1 =[NSMutableString stringWithFormat:@"%@",
               [tmpDict1 objectForKeyedSubscript:content_html]];
    [defaults1 setObject:content1 forKey:@"contentof_Post"];
    //send values url to Nodung_ViewController
    urlSendtoShare =[NSMutableString stringWithFormat:@"%@",
                     [tmpDict1 objectForKeyedSubscript:url_post]];
    [defaults1 setObject:urlSendtoShare forKey:@"url_Share"];
    //send values post_id to Comment_ViewController
    postId_key =[NSMutableString stringWithFormat:@"%@",
                 [tmpDict1 objectForKeyedSubscript:thread_id]];
    [defaults1 setObject:postId_key forKey:@"post_id"];
    [defaults1 synchronize];
    
    
    [self performSegueWithIdentifier:@"noidungthanhvien" sender:self];
    
}

- (void)runIndicatorAtIndexPath:(NSIndexPath *)indexPath display:(BOOL)playing{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [activityIndicator center];
    cell.accessoryView = activityIndicator;
    playing == YES ?[activityIndicator startAnimating]:[activityIndicator stopAnimating];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [self runIndicatorAtIndexPath:indexPath display:YES];
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self runIndicatorAtIndexPath:indexPath display:NO];
}

// create post------------------------------------------

@end
