//
//  NoiDung_ViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/20/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "NoiDung_ViewController.h"
#import "DBManager.h"
#import <sqlite3.h>
#import "MBProgressHUD.h"

@interface NoiDung_ViewController ()<MBProgressHUDDelegate, UIScrollViewDelegate>{
    UIImage *IMAGE_FAV;
    __block MBProgressHUD *hud;
      NSString *content_html;
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *url_post;
}
@property (strong, nonatomic) IBOutlet UIView *demo;
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrResult;
@property (nonatomic) double * lastContentOffSet;
@end
@implementation NoiDung_ViewController
-(void)loadData{
   
      NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    NSString *thread_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyThreadId"];
    NSString *threadKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"];
  /*  if([thread_key isEqual:@"19"]){
        thread_key = @"19";
    }*/
    content_html=@"message_html";
    url_post=@"absolute_url";
    myObject = [[NSMutableArray alloc] init];
    NSString *urlStringContent = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getPosts&hash=%@:%@&node_id=%@&thread_id=%@", useName , hashKey, thread_key, threadKey];
    NSData * dataContent=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringContent]];
    NSError * errorContent;
    //return json values
    NSMutableDictionary  * jsonContent = [NSJSONSerialization JSONObjectWithData:dataContent options: NSJSONReadingMutableContainers error: &errorContent];
    NSString *htmlOfContent;
    NSString *urlForShare;
    if ([jsonContent[@"posts"] count] > 0) {
        htmlOfContent = [jsonContent[@"posts"][0] valueForKey:@"message_html"];
        //get link url of post for share
        urlForShare = [jsonContent[@"posts"][0] valueForKey:@"absolute_url"];
    }else{
        htmlOfContent=@"Không thể lấy được bài viết !";
        urlForShare=@"Link does not exits";
    }
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                   htmlOfContent,content_html,
                   urlForShare,url_post,
                  nil];
    [myObject addObject:dictionary];
}
-(void)loadData19{
    
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    NSString *thread_key = @"19";
    NSString *threadKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"];
    
    content_html=@"message_html";
    url_post=@"absolute_url";
    myObject = [[NSMutableArray alloc] init];
    NSString *urlStringContent = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getPosts&hash=%@:%@&node_id=%@&thread_id=%@", useName , hashKey, thread_key, threadKey];
    NSData * dataContent=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringContent]];
    NSError * errorContent;
    //return json values
    NSMutableDictionary  * jsonContent = [NSJSONSerialization JSONObjectWithData:dataContent options: NSJSONReadingMutableContainers error: &errorContent];
    NSString *htmlOfContent;
    NSString *urlForShare;
    if ([jsonContent[@"posts"] count] > 0) {
        htmlOfContent = [jsonContent[@"posts"][0] valueForKey:@"message_html"];
        //get link url of post for share
        urlForShare = [jsonContent[@"posts"][0] valueForKey:@"absolute_url"];
    }else{
        htmlOfContent=@"Không thể lấy được bài viết !";
        urlForShare=@"Link does not exits";
    }
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                  htmlOfContent,content_html,
                  urlForShare,url_post,
                  nil];
    [myObject addObject:dictionary];
}
-(void)loadData44{
    
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    NSString *thread_key = @"44";
    NSString *threadKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"];
    
    content_html=@"message_html";
    url_post=@"absolute_url";
    myObject = [[NSMutableArray alloc] init];
    NSString *urlStringContent = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getPosts&hash=%@:%@&node_id=%@&thread_id=%@", useName , hashKey, thread_key, threadKey];
    NSData * dataContent=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringContent]];
    NSError * errorContent;
    //return json values
    NSMutableDictionary  * jsonContent = [NSJSONSerialization JSONObjectWithData:dataContent options: NSJSONReadingMutableContainers error: &errorContent];
    NSString *htmlOfContent;
    NSString *urlForShare;
    if ([jsonContent[@"posts"] count] > 0) {
        htmlOfContent = [jsonContent[@"posts"][0] valueForKey:@"message_html"];
        //get link url of post for share
        urlForShare = [jsonContent[@"posts"][0] valueForKey:@"absolute_url"];
    }else{
        htmlOfContent=@"Không thể lấy được bài viết !";
        urlForShare=@"Link does not exits";
    }
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                  htmlOfContent,content_html,
                  urlForShare,url_post,
                  nil];
    [myObject addObject:dictionary];
}
-(void)loadData161{
    
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    NSString *thread_key = @"161";
    NSString *threadKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"];
    
    content_html=@"message_html";
    url_post=@"absolute_url";
    myObject = [[NSMutableArray alloc] init];
    NSString *urlStringContent = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getPosts&hash=%@:%@&node_id=%@&thread_id=%@", useName , hashKey, thread_key, threadKey];
    NSData * dataContent=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringContent]];
    NSError * errorContent;
    //return json values
    NSMutableDictionary  * jsonContent = [NSJSONSerialization JSONObjectWithData:dataContent options: NSJSONReadingMutableContainers error: &errorContent];
    NSString *htmlOfContent;
    NSString *urlForShare;
    if ([jsonContent[@"posts"] count] > 0) {
        htmlOfContent = [jsonContent[@"posts"][0] valueForKey:@"message_html"];
        //get link url of post for share
        urlForShare = [jsonContent[@"posts"][0] valueForKey:@"absolute_url"];
    }else{
        htmlOfContent=@"Không thể lấy được bài viết !";
        urlForShare=@"Link does not exits";
    }
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                  htmlOfContent,content_html,
                  urlForShare,url_post,
                  nil];
    [myObject addObject:dictionary];
}
-(void)loadData86{
    
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    NSString *thread_key = @"86";
    NSString *threadKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"];
    
    content_html=@"message_html";
    url_post=@"absolute_url";
    myObject = [[NSMutableArray alloc] init];
    NSString *urlStringContent = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getPosts&hash=%@:%@&node_id=%@&thread_id=%@", useName , hashKey, thread_key, threadKey];
    NSData * dataContent=[NSData dataWithContentsOfURL:[NSURL URLWithString:urlStringContent]];
    NSError * errorContent;
    //return json values
    NSMutableDictionary  * jsonContent = [NSJSONSerialization JSONObjectWithData:dataContent options: NSJSONReadingMutableContainers error: &errorContent];
    NSString *htmlOfContent;
    NSString *urlForShare;
    if ([jsonContent[@"posts"] count] > 0) {
        htmlOfContent = [jsonContent[@"posts"][0] valueForKey:@"message_html"];
        //get link url of post for share
        urlForShare = [jsonContent[@"posts"][0] valueForKey:@"absolute_url"];
    }else{
        htmlOfContent=@"Không thể lấy được bài viết !";
        urlForShare=@"Link does not exits";
    }
    dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                  htmlOfContent,content_html,
                  urlForShare,url_post,
                  nil];
    [myObject addObject:dictionary];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    loadcontent.scrollView.delegate = self;
      NSString *thread_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyThreadId"];
    if([thread_key isEqual:@"19"]){
    [self loadData19];
    }
    
    if([thread_key isEqual:@"69" ] && [thread_key isEqual:@"105"]){
    [self loadData];
        }
    if([thread_key isEqual:@"44"]){
        [self loadData44];
    }
    if([thread_key isEqual:@"161"]){
        [self loadData161];
    }
    if([thread_key isEqual:@"86"]){
        [self loadData161];
    }
    [self loadData];
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"FAVORITE_LIST.sqlite"];
    //setting for favorite button
    BOOL IS_FAVORITE = false;
    NSString *query = [NSString stringWithFormat:@"%@", @"SELECT * FROM FV_LIST"];
    self.arrResult = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
     for(int i=0; i<[self.arrResult count];i++){
         NSString *idpost = [[self.arrResult objectAtIndex:i] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"ID_POST"]];
         if([[[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"] isEqualToString:idpost]){
             IS_FAVORITE=true;
             break;
         }
         else{
             IS_FAVORITE=false;
         }
     }
    UIButton *favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if(IS_FAVORITE){
        IMAGE_FAV= [UIImage imageNamed:@"DATHEODOI.png"];
        [favoriteButton addTarget:self action:@selector(DelfavoriteButton_event:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        IMAGE_FAV= [UIImage imageNamed:@"THEODOIBAIVIET.png"];
        [favoriteButton addTarget:self action:@selector(favoriteButton_event:) forControlEvents:UIControlEventTouchUpInside];
    }
    favoriteButton.bounds = CGRectMake(0, 0, 20, 20);
    [favoriteButton setImage:IMAGE_FAV forState:UIControlStateNormal];
    UIBarButtonItem *fvrButton= [[UIBarButtonItem alloc] initWithCustomView:favoriteButton];
    //menu button
    UIImage *imageComment = [UIImage imageNamed:@"COMMENT.png"];
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.bounds = CGRectMake(0, 0, 20, 20);
    [commentButton setImage:imageComment forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(CommentButton_event:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cmtButton= [[UIBarButtonItem alloc] initWithCustomView:commentButton];
    
    UIImage *imageShare = [UIImage imageNamed:@"CHIASE.png"];
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.bounds = CGRectMake(0, 0, 20, 20);
    [shareButton setImage:imageShare forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(ShareButton_event:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shrButton= [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    NSArray *arrayButton= [[NSArray alloc] initWithObjects:shrButton,cmtButton,fvrButton, nil];
    self.navigationItem.rightBarButtonItems=arrayButton;
    //end code
    //set title, thread, name, date for post
    NSDictionary *tmpDict= [myObject objectAtIndex:0];
    NSString *contentPost = [tmpDict objectForKeyedSubscript:content_html];
    //thread
    self.navigationItem.title=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyTittle"];
    //tittle
    lbl_Tittle.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"TitleOf_Post"];
    //name
    lbl_Username.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"UserOf_Post"];
    //date
    lbl_date.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"DateOf_Post"];
    lbl_space.text=@"-----------------------------------------------";
    // format CSS when load image and text
    NSString *strForWebView = [NSString stringWithFormat:@"<html> \n"
                               "<head> \n"
                               "<style type=\"text/css\"> \n"
                               "body {font-family: \"%@\"; font-size: %@; height: auto; }\n"
                               "img{max-width:100%%;height:auto !important;width:auto !important;}</style> \n"
                               "</head> \n"
                               "<body >%@</body> \n"
                               "</html>", @"helveticaNeue", [NSNumber numberWithInt:40], contentPost];
    [loadcontent loadHTMLString:strForWebView baseURL:nil];
    [loadcontent setScalesPageToFit:YES];
    loadcontent.autoresizesSubviews = YES;
    loadcontent.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    
   
}

/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"We scrolled! Offset now is %f, %f", scrollView.contentOffset.x, scrollView.contentOffset.y);

    CGRect  oldScroll = loadcontent.frame;
    if(scrollView.contentOffset.y <= 0.0){
        NSLog(@"Top");
        loadcontent.frame = CGRectMake(0, 100, self.view.frame.size.width, oldScroll.size.height);

    }
    if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)){
        NSLog(@"BOTTOM REACHED");
        loadcontent.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
}*/
//-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{

//}
//- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
  //  loadcontent.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

//}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if([scrollView.panGestureRecognizer translationInView:scrollView.superview].y > 0){
        CGRect  oldScroll = loadcontent.frame;
        NSLog(@"We scrolled! Offset now is %f ", scrollView.contentOffset.y);
        loadcontent.frame = CGRectMake(0, 100, self.view.frame.size.width, oldScroll.size.height);
        
    }
    else{
        NSLog(@"top");
        loadcontent.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    }
}
-(void)ShareButton_event:(id)sender{
    NSDictionary *tmpDict= [myObject objectAtIndex:0];
    NSString *url_post1 = [tmpDict objectForKeyedSubscript:url_post];
    NSString *tittlePost_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"TitleOf_Post"];
    NSURL *myWebsite = [NSURL URLWithString:url_post1];
    NSArray *activityItems = @[tittlePost_key,myWebsite];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes =@[UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo];
    [self presentViewController:activityVC animated:TRUE completion:nil];
}

-(IBAction)CommentButton_event:(id)sender{
                dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"comment is press...");
            UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
            hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
            hud.dimBackground = YES;
            hud.labelText = @"Đang tải dữ liệu...";

        });
    [self performSelectorOnMainThread:@selector(segueToPastFlights) withObject:self waitUntilDone:NO];
}

-(void)segueToPastFlights {
    [self performSegueWithIdentifier:@"comment" sender:self];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
    [hud hide:YES];
    [hud removeFromSuperViewOnHide];
}
-(void)DelfavoriteButton_event:(id)sender{
     NSLog(@"DA XOA");
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"FAVORITE_LIST.sqlite"];
    NSString *query = [NSString stringWithFormat:@"DELETE FROM FV_LIST WHERE ID_POST=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"]];
    [self.dbManager executeQuery:query];
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Đã xoá bài viết khỏi danh sách yêu thích!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
    [myAlert show];
    [self viewDidLoad];

    
}
-(void)favoriteButton_event:(id)sender{
    UIImage *imageFavorite1 = [UIImage imageNamed:@"DATHEODOI.png"];
    UIButton *favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favoriteButton.bounds = CGRectMake(0, 0, 20, 20);
    [favoriteButton setImage:imageFavorite1 forState:UIControlStateNormal];
    [favoriteButton addTarget:self action:@selector(DelfavoriteButton_event:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *fvrButton= [[UIBarButtonItem alloc] initWithCustomView:favoriteButton];
    //menu button
    UIImage *imageComment = [UIImage imageNamed:@"COMMENT.png"];
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.bounds = CGRectMake(0, 0, 20, 20);
    [commentButton setImage:imageComment forState:UIControlStateNormal];
    [commentButton addTarget:self action:@selector(CommentButton_event:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cmtButton= [[UIBarButtonItem alloc] initWithCustomView:commentButton];
    //share button
    UIImage *imageShare = [UIImage imageNamed:@"CHIASE.png"];
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.bounds = CGRectMake(0, 0, 20, 20);
    [shareButton setImage:imageShare forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(ShareButton_event:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shrButton= [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    NSArray *arrayButton= [[NSArray alloc] initWithObjects:shrButton,cmtButton,fvrButton, nil];
    self.navigationItem.rightBarButtonItems=arrayButton;
    NSDictionary *tmpDict= [myObject objectAtIndex:0];
    NSString *contentPost = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyThreadId"];
    //tittle
    NSString *tittlePost_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"TitleOf_Post"];
    //name
    NSString *namePost = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserOf_Post"];
    //date
    NSString *dateTimePost = [[NSUserDefaults standardUserDefaults] objectForKey:@"DateOf_Post"];
    NSString *PostId = [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"];
    NSString *Post_Detail = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyTittle"];
    NSString *imagePost = [[NSUserDefaults standardUserDefaults] objectForKey:@"image_Post"];
    //insert post to SQLite
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"FAVORITE_LIST.sqlite"];
    NSString *query = [NSString stringWithFormat:@"INSERT INTO FV_LIST VALUES('%@','%@','%@','%@','%@','%@','%@','1')",PostId,tittlePost_key,contentPost,Post_Detail,namePost,dateTimePost,imagePost];
    NSLog(@"%@\n%@\n%@\n%@\n%@\n%@\n%@",PostId,tittlePost_key,contentPost,Post_Detail,namePost,dateTimePost,imagePost);
    [self.dbManager executeQuery:query];
    if (self.dbManager.affectedRows != 0) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Thêm bài viết vào danh sách yêu thích thành công!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
    else{
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Thêm bài viết vào danh sách yêu thích không thành công!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
