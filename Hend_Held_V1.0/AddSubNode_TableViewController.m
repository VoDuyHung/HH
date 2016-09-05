//
//  AddSubNode_TableViewController.m
//  Hand Held
//
//  Created by Toan Nguyen Duc on 12/1/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "AddSubNode_TableViewController.h"
#import "Danhmuc_.h"
#import "CellThongTinBanLuan_TableViewCell.h"
#import "DBManager.h"
#import "Danh.h"
#import "MBProgressHUD.h"
@interface AddSubNode_TableViewController ()<MBProgressHUDDelegate>{
    UIButton *button1,*button2;
    
    UIView * customTitleView,*customTitleView1;
    UILabel* label1,*label2;
    
    NSString *thread_key;
    NSString* tittle_key;
    __block MBProgressHUD *hud;
    NSMutableArray *myObject,*myObject2;
    NSArray *searchResults;
    NSDictionary *dictionary,*dictionary2;
    NSString *username;
    NSString *images_post,*images_post2;
    NSString *title,*title2;
    NSString *thread;
    NSString *post_date,*post_date2;
    NSString *user_Post,*user_Post2;
    NSString *thread_id,*thread_id2;
    NSString *content_html,*content_html2;
    NSString *url_post,*url_post2;
    NSString *post_id,*post_id2;
    NSMutableAttributedString *string ;
    NSString *threadKeySubNode ;
    NSString *tittleKeySubNode ;
    UIRefreshControl* refresh;
    UIActivityIndicatorView * _activityIndicator;//,*indi_amthanh,*indi_mayTinh,*indi_MACOSX,*indi_android,*indi_iphone,*indi_Wphone,*indi_Dxua,*indi_PTPMDDV,*indi_cf,*indi_4E,*indi_LUXURY;
    UIButton *btn_mayAnh,*btn_mayTinh,*btn_MACOSX,*btn_amThanh,*btn_LUXURY,*btn_4E,*btn_cf,*btn_android,*btn_iphone,*btn_WPhone,*btn_DXua,*btn_PTPMDDV;
    UIImage *img_mayAnh,*img_mayTinh,*img_MACOSX,*img_amThanh,*img_LUXURY,*img_4E,*img_cf,*img_android,*img_iphone,*img_WPhone,*img_DXua,*img_PTPMDDV;
    UIImageView *imgV_mayAnh,*imgV_mayTinh,*imgV_MACOSX,*imgV_amThanh,*imgV_LUXURY,*imgV_4E,*imgV_cf, *imgV_android,*imgV_iphone,*imgV_WPhone,*imgV_DXua,*imgV_PTPMDDV;
}
@property (nonatomic) CAPSPageMenu *pageMenu;
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrResult;
@property (nonatomic, retain) NSArray *listsearchPost;
@property (nonatomic, retain) NSArray *arrayPost;
@property (nonatomic,retain) NSArray *arrayTitle,*arrayImage;
@end
@implementation AddSubNode_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    thread_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyThreadId"];
    tittle_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyTittle"];
    _activityIndicator.hidden=NO;
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    //Button 1
    customTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(-5, -5, 200, 22)];
    label1.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    [customTitleView addSubview:label1];
    
    button1 = [[UIButton alloc]initWithFrame:CGRectMake(20,20, 150, 18)];
    [button1 setTintColor:[UIColor whiteColor]];
    UIFont * font = [UIFont fontWithName:@"HelveticaNeue-Light" size:8];
    button1.font = font;
    button1.layer.masksToBounds = YES;
    button1.layer.borderWidth = 1;
    button1.layer.borderColor = [[UIColor whiteColor]CGColor];
    button1.layer.cornerRadius = 10;
    [customTitleView addSubview:button1];

    //button2
    customTitleView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(-5, -5, 200, 22)];
    label2.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    [customTitleView1 addSubview:label2];
    
    button2 = [[UIButton alloc]initWithFrame:CGRectMake(20,20, 150, 18)];// button show anh va binh luan
    button2.backgroundColor = [UIColor whiteColor];
    [button2 setTitleColor:[UIColor colorWithRed:0.043 green:0.318 blue:0.635 alpha:1.00] forState:UIControlStateNormal];
    UIFont * font1 = [UIFont fontWithName:@"HelveticaNeue-Light" size:8];
    button2.font = font1;
    button2.layer.masksToBounds = YES;
    button2.layer.cornerRadius = 10;
    [customTitleView1 addSubview:button2];
    
    title = @"title";
    images_post = @"thumbnail_cache_waindigo";
    user_Post=@"last_post_username";
    post_date=@"post_date";
    thread_id=@"thread_id";
    content_html=@"message_html";
    url_post=@"absolute_url";
    post_id=@"post_id";
    if([thread_key isEqual:@"69"]){
        [self loadData69];
    }
    if([thread_key isEqual:@"105"]){
        [self loadData105];
    }
    if([thread_key isEqual:@"85"]){
        [self loadData85];
    }
    if([thread_key isEqual:@"25"]){
        [self loadData25];
    }
    if([thread_key isEqual:@"33"]){
        [self loadData33];
    }
    /*if([thread_key isEqual:@"73"]){
        [self loadData73];
    }*/
    [self.Search_Bar setShowsScopeBar:NO];
    [self.Search_Bar sizeToFit];
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + self.Search_Bar.bounds.size.height;
    self.tableView.bounds = newBounds;
    
    //refresh post
    refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Kéo xuống để làm mới trang..."];
    [refresh addTarget:self
                action:@selector(refreshView:)
                forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([Danhmuc_ class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([Danhmuc_ class])];
}
/*-(void)loadData73{
    self.navigationItem.title = @"ĐIỆN THOẠI THÔNG MINH";
    thread_key = @"133";
    tittle_key = @"ANDROID";
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}
*/

-(void)loadData69{
    self.navigationItem.titleView = customTitleView;
    label1.text =  @"CAMERA - MÁY ẢNH SỐ";
    [button1 setTitle:@"SHOW ẢNH VÀ BÌNH LUẬN" forState:UIControlStateNormal];

    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap69:)]; // Declare the Gesture.
    [button1 addGestureRecognizer:gesRecognizer];
     thread_key = @"69";
     tittle_key = @"CAMERA - MÁY ẢNH SỐ";
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                         // htmlOfContent,content_html,
                         // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}

-(void)loadData19{
    self.navigationItem.titleView = customTitleView1;
    label2.text =  @"SHOW ẢNH & BÌNH LUẬN";
    [button2 setTitle:@"SHOW ẢNH VÀ BÌNH LUẬN" forState:UIControlStateNormal];
    
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap19:)]; // Declare the Gesture.
    [button2 addGestureRecognizer:gesRecognizer];
    thread_key = @"19";
    tittle_key = @"SHOW ẢNH & BÌNH LUẬN";
    //tableview------------------------------------------
   
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}
-(void)loadData105{
    self.navigationItem.titleView = customTitleView;
    label1.text =  @"ÂM THANH - HÌNH ẢNH - MEDIA CENTER - HD CLUB";
    [button1 setTitle:@"ÂM THANH - TAI NGHE - LOA" forState:UIControlStateNormal];
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap105:)]; // Declare the Gesture.
    [button1 addGestureRecognizer:gesRecognizer];
    thread_key = @"105";
    tittle_key = @"ÂM THANH - HÌNH ẢNH - MEDIA CENTER - HD CLUB";
    //tableview------------------------------------------
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}


-(void)loadData44{
    self.navigationItem.titleView = customTitleView1;
    label2.text =  @"ÂM THANH - TAI NGHE - LOA";
    [button2 setTitle:@"ÂM THANH - TAI NGHE - LOA" forState:UIControlStateNormal];

    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap44:)]; // Declare the Gesture.
    [button2 addGestureRecognizer:gesRecognizer];
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    thread_key = @"44";
    tittle_key = @"ÂM THANH - TAI NGHE - LOA";
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}
-(void)loadData85{

    label1.text =  @"MÁY THỜI GIAN - ĐỒNG HỒ";
    [button1 setTitle:@"4 ENGLISH" forState:UIControlStateNormal];
    self.navigationItem.titleView = customTitleView;
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap85:)]; // Declare the Gesture.
    [button1 addGestureRecognizer:gesRecognizer];
    
    thread_key = @"85";
    tittle_key = @"MÁY THỜI GIAN - ĐỒNG HỒ";
    //tableview------------------------------------------
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}


-(void)loadData161{
    label2.text =  @"4 ENGLISH";
    [button2 setTitle:@"4 ENGLISH" forState:UIControlStateNormal];
    self.navigationItem.titleView = customTitleView1;
    
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap161:)]; // Declare the Gesture.
    [button2 addGestureRecognizer:gesRecognizer];
    thread_key = @"161";
    tittle_key = @"4 ENGLISH";
    //tableview-----------------------------------------
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}
-(void)loadData25{
  
    label1.text =  @"LUXURY & HI-END";
    [button1 setTitle:@"ĐẲNG CẤP LUXURY" forState:UIControlStateNormal];
    
    self.navigationItem.titleView = customTitleView;
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap25:)]; // Declare the Gesture.
    [button1 addGestureRecognizer:gesRecognizer];
    
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    thread_key = @"25";
    tittle_key = @"LUXURY & HI-END";
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}


-(void)loadData86{
    label2.text =  @"ĐẲNG CẤP LUXURY";
    [button2 setTitle:@"ĐẲNG CẤP LUXURY" forState:UIControlStateNormal];
    self.navigationItem.titleView = customTitleView1;
    
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap86:)]; // Declare the Gesture.
    [button2 addGestureRecognizer:gesRecognizer];
    thread_key = @"86";
    tittle_key = @"ĐẲNG CẤP LUXURY";
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}
-(void)loadData33{
    label1.text =  @"HANDHELD CAFE";
    [button1 setTitle:@"CHÚNG TA CHÚC NHAU" forState:UIControlStateNormal];
    self.navigationItem.titleView = customTitleView;
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap33:)]; // Declare the Gesture.
    [button1 addGestureRecognizer:gesRecognizer];
    
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    thread_key = @"33";
    tittle_key = @"HANDHELD CAFE";
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}


-(void)loadData30{
    label2.text =  @"CHÚNG TA CHÚC NHAU";
    [button2 setTitle:@"CHÚNG TA CHÚC NHAU" forState:UIControlStateNormal];
    self.navigationItem.titleView = customTitleView1;
    
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap30:)]; // Declare the Gesture.
    [button2 addGestureRecognizer:gesRecognizer];
    thread_key = @"30";
    tittle_key = @"CHÚNG TA CHÚC NHAU";
    NSString *threadKey;
    //register MutitableArray myObject for save key and values when get from json
    myObject = [[NSMutableArray alloc] init];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //limit subpage
        NSString *limitNumberSubPage;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"]==NULL){
            limitNumberSubPage=@"20";
        }
        else{
            limitNumberSubPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfSubPage"];
        }
        NSString *urlString;
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"]==NULL){
            NSUserDefaults *defaults2=[NSUserDefaults standardUserDefaults];
            [defaults2 setObject:@"0" forKey:@"sortBy"];
            [defaults2 synchronize];
        }
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"1"]){
            urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=%@&limit=%@&order_by=last_post_date", useName , hashKey, thread_key,limitNumberSubPage];
        }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sortBy"] isEqualToString:@"0"]){
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
                          // htmlOfContent,content_html,
                          // urlForShare,url_post,
                          hinhanh,images_post,
                          nil];
            [myObject addObject:dictionary];
        }
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }
}


#pragma mark - Search data source
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //search in myobject
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.title contains[c] %@",
                                    searchText];
    //searchText    
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.listsearchPost count];
        
    }

    return [myObject count];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"Danhmuc_";
    Danhmuc_ *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"Danhmuc_" bundle:nil] forCellReuseIdentifier:simpleTableIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    }
    
    //when tableview is search controller
       if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.lbl_changeSize.hidden=YES;
        NSDictionary *tmpDict1= [self.listsearchPost objectAtIndex:indexPath.section];
        cell.lbl_userPost.text=[tmpDict1 objectForKeyedSubscript:user_Post];
        cell.lbl_date.text=[tmpDict1 objectForKeyedSubscript:post_date];
        cell.lbl_title.text=[tmpDict1 objectForKeyedSubscript:title];
        NSString *str_02=[[tmpDict1 objectForKey:images_post] substringWithRange:NSMakeRange(0, 1)];
        if([str_02 isEqualToString:@"h"]){
            cell.img_load.hidden=NO;
            cell.image1.hidden=YES;
            NSString *htmlString = [NSString stringWithFormat:@"<img src='%@' width='450 ' height='350'>", [tmpDict1 objectForKey:images_post]];
            cell.img_load.scalesPageToFit=YES;
            [cell.img_load loadHTMLString:htmlString baseURL:nil];
            cell.img_load.scrollView.scrollEnabled = NO;
        } else{
            cell.image1.hidden=NO;
            cell.img_load.hidden=YES;
            cell.image1.image=[UIImage imageNamed:@"HH!.jpg"];  /////CHINH ANH NONE
        }
        
    }
    else {
        [cell.lbl_title addSubview:cell.img_load];
            NSDictionary *tmpDict= [myObject objectAtIndex:indexPath.section];
            cell.lbl_userPost.text=[tmpDict objectForKeyedSubscript:user_Post];
            cell.lbl_date.text=[tmpDict objectForKeyedSubscript:post_date];
            cell.lbl_title.text=[tmpDict objectForKeyedSubscript:title];
            if((long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"SizeText"] integerValue]>17)
            {
                //end
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
            else{
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
                } else{
                    cell.image1.hidden=NO;
                    cell.img_load.hidden=YES;
                    cell.image1.image=[UIImage imageNamed:@"HH!.jpg"];
                }
                
            }

       
        
    }

    return cell;
}
/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *subView_CongNghe= [[UIView alloc] initWithFrame:CGRectMake(0,0,700,20)];
    [subView_CongNghe setBackgroundColor:[UIColor colorWithRed:0.855f green:0.855f blue:0.855f alpha:1]];
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 500, 20)];
    //    scroller.showsHorizontalScrollIndicator = YES;
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 870, 20)];
    scroller.contentSize = contentLabel.frame.size;
    scroller.backgroundColor= [UIColor colorWithRed:0.043 green:0.318 blue:0.635 alpha:1.00];
    [subView_CongNghe addSubview:scroller];
    
    CALayer *boder = [CALayer layer];
    boder.borderColor =[[UIColor colorWithRed:0.043 green:0.318 blue:0.635 alpha:1.00] CGColor];
    boder.borderWidth = 1;
    CALayer *layer= self.navigationController.navigationBar.layer;
    boder.frame = CGRectMake(0, layer.bounds.size.height, layer.bounds.size.width, 1);
    [layer addSublayer:boder];
    
    if(section == 0){
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"keyThreadId"] isEqual:@"73"]){
            btn_android = [[UIButton alloc]initWithFrame:CGRectMake(20,2, 60, 15)];
            [btn_android setTintColor:[UIColor whiteColor]];
            UIFont * font = [UIFont fontWithName:@"HelveticaNeue-Light" size:8];
            btn_android.font = font;
            [btn_android setTitle:@"ANDROID" forState:UIControlStateNormal];
            btn_android.layer.masksToBounds = YES;
            btn_android.layer.borderWidth = 1;
            btn_android.layer.borderColor = [[UIColor whiteColor]CGColor];
            UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap73:)];
            [btn_android addGestureRecognizer:gesRecognizer];
            [scroller addSubview:btn_android];
            
            btn_iphone = [[UIButton alloc]initWithFrame:CGRectMake(90,2, 60, 15)];
            [btn_iphone setTintColor:[UIColor whiteColor]];
            UIFont * fonti = [UIFont fontWithName:@"HelveticaNeue-Light" size:8];
            btn_iphone.font = fonti;
            [btn_iphone setTitle:@"IPHONE" forState:UIControlStateNormal];
            btn_iphone.layer.masksToBounds = YES;
            btn_iphone.layer.borderWidth = 1;
            btn_iphone.layer.borderColor = [[UIColor whiteColor]CGColor];
            UITapGestureRecognizer *gesRecognizeri = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap73:)];
            [btn_iphone addGestureRecognizer:gesRecognizeri];
            [scroller addSubview:btn_iphone];
           
            btn_DXua = [[UIButton alloc]initWithFrame:CGRectMake(160,2, 60, 15)];
            [btn_DXua setTintColor:[UIColor whiteColor]];
            UIFont * fontD = [UIFont fontWithName:@"HelveticaNeue-Light" size:8];
            btn_DXua.font = fontD;
            [btn_DXua setTitle:@"DIÊM XƯA" forState:UIControlStateNormal];
            btn_DXua.layer.masksToBounds = YES;
            btn_DXua.layer.borderWidth = 1;
            btn_DXua.layer.borderColor = [[UIColor whiteColor]CGColor];
            UITapGestureRecognizer *gesRecognizerD = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap73:)];
            [btn_DXua addGestureRecognizer:gesRecognizerD];
            [scroller addSubview:btn_DXua];
            
            btn_WPhone = [[UIButton alloc]initWithFrame:CGRectMake(230,2, 90, 15)];
            [btn_WPhone setTintColor:[UIColor whiteColor]];
            UIFont * fontw = [UIFont fontWithName:@"HelveticaNeue-Light" size:8];
            btn_WPhone.font = fontw;
            [btn_WPhone setTitle:@"WINDOWS PHONE" forState:UIControlStateNormal];
            btn_WPhone.layer.masksToBounds = YES;
            btn_WPhone.layer.borderWidth = 1;
            btn_WPhone.layer.borderColor = [[UIColor whiteColor]CGColor];
            UITapGestureRecognizer *gesRecognizerw = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap73:)];
            [btn_WPhone addGestureRecognizer:gesRecognizerw];
            [scroller addSubview:btn_WPhone];
            
            btn_PTPMDDV = [[UIButton alloc]initWithFrame:CGRectMake(340,0, 150, 15)];
            [btn_PTPMDDV setTintColor:[UIColor whiteColor]];
            UIFont * fontP = [UIFont fontWithName:@"HelveticaNeue-Light" size:8];
            btn_PTPMDDV.font = fontP;
            [btn_PTPMDDV setTitle:@"PHÁT TRIỂN PHẦN MỀM DI ĐỘNG VIỆT" forState:UIControlStateNormal];
            btn_PTPMDDV.layer.masksToBounds = YES;
            btn_PTPMDDV.layer.borderWidth = 1;
            btn_PTPMDDV.layer.borderColor = [[UIColor whiteColor]CGColor];
            UITapGestureRecognizer *gesRecognizerP = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap73:)];
            [btn_PTPMDDV addGestureRecognizer:gesRecognizerP];
            [scroller addSubview:btn_PTPMDDV];
            
           /* self.Search_Bar.hidden = YES;
            refresh.hidden = YES;
 
            self.tableView.bounds = newBounds;
            return subView_CongNghe;
            
            
        }
    }
    return nil;
    
}*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    /*if(section==0){
         if([[[NSUserDefaults standardUserDefaults] objectForKey:@"keyThreadId"] isEqual:@"73"]){
        return 20;
         }
        return 6;
    }
    else{*/
        return 6;
    
}
//refresh
-(void)refreshView:(UIRefreshControl *)refresh {
    refresh = [[UIRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Đang làm mới dữ liệu..."];
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
    //user of post
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:user_Post] forKey:@"UserOf_Post"];
    //date of post
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:post_date] forKey:@"DateOf_Post"];
    //send values post_id to Comment_ViewController
    [defaults1 setObject: [tmpDict1 objectForKeyedSubscript:thread_id] forKey:@"post_id"];
    [defaults1 setObject:[tmpDict1 objectForKey:images_post] forKey:@"image_Post"];
    [defaults1 synchronize];
    [self performSegueWithIdentifier:@"readsubnode" sender:self];
}
- (void)runIndicatorAtIndexPath:(NSIndexPath *)indexPath display:(BOOL)playing{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
    [hud hide:YES];
}

- (IBAction)Search_Button:(id)sender {
    [self.Search_Bar becomeFirstResponder];
}
-(void)segueToPastFlights1 {
    [self performSegueWithIdentifier:@"listsubnode" sender:self];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate date]];
    [hud hide:YES];
    [self.view setUserInteractionEnabled:YES];
}
/*- (void)handleTap73:(UITapGestureRecognizer *)gestureRecognizer{
    [self loadData73];
    [self.tableView reloadData];
    NSLog(@"tap%@",thread_key);
    threadKeySubNode = @"133";
    tittleKeySubNode=@"ANDROID";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
}*/
- (void)handleTap69:(UITapGestureRecognizer *)gestureRecognizer{
        [self loadData19];
        [self.tableView reloadData];
    NSLog(@"tap%@",thread_key);
        threadKeySubNode = @"19";
        tittleKeySubNode=@"SHOW ẢNH VÀ BÌNH LUẬN";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
       // [[NSUserDefaults standardUserDefaults] synchronize];
   }
- (void)handleTap19:(UITapGestureRecognizer *)gestureRecognizer{
        [self loadData69];
        [self.tableView reloadData];
    threadKeySubNode = @"69";
    tittleKeySubNode=@"CAMERA - MÁY ẢNH SỐ";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"tap1%@",thread_key);
}
- (void)handleTap105:(UITapGestureRecognizer *)gestureRecognizer{
    [self loadData44];
    [self.tableView reloadData];
    NSLog(@"tap%@",thread_key);
    threadKeySubNode = @"44";
    tittleKeySubNode=@"ÂM THANH - TAI NGHE - LOA";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)handleTap44:(UITapGestureRecognizer *)gestureRecognizer{
    [self loadData105];
    [self.tableView reloadData];
    threadKeySubNode = @"105";
    tittleKeySubNode=@"ÂM THANH - HÌNH ẢNH - MEDIA CENTER - HD CLUB";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"tap1%@",thread_key);
}
- (void)handleTap85:(UITapGestureRecognizer *)gestureRecognizer{
    [self loadData161];
    [self.tableView reloadData];
    NSLog(@"tap%@",thread_key);
    threadKeySubNode = @"161";
    tittleKeySubNode=@"4 ENGLISH";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)handleTap161:(UITapGestureRecognizer *)gestureRecognizer{
    [self loadData85];
    [self.tableView reloadData];
    threadKeySubNode = @"85";
    tittleKeySubNode=@"MÁY THỜI GIAN - ĐỒNG HỒ";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"tap1%@",thread_key);
}
- (void)handleTap25:(UITapGestureRecognizer *)gestureRecognizer{
    [self loadData86];
    [self.tableView reloadData];
    NSLog(@"tap%@",thread_key);
    threadKeySubNode = @"86";
    tittleKeySubNode=@"ĐẲNG CẤP LUXURY";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)handleTap86:(UITapGestureRecognizer *)gestureRecognizer{
    [self loadData25];
    [self.tableView reloadData];
    threadKeySubNode = @"25";
    tittleKeySubNode=@"LUXURY & HI-END";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"tap1%@",thread_key);
}
- (void)handleTap33:(UITapGestureRecognizer *)gestureRecognizer{
    [self loadData30];
    [self.tableView reloadData];
    NSLog(@"tap%@",thread_key);
    threadKeySubNode = @"30";
    tittleKeySubNode=@"CHUNG TA CHUC NHAU";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)handleTap30:(UITapGestureRecognizer *)gestureRecognizer{
    [self loadData33];
    [self.tableView reloadData];
    threadKeySubNode = @"33";
    tittleKeySubNode=@"HANDHELD CAFE";
    [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
    [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"tap1%@",thread_key);
}
- (void)btn_Computer:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"107";
        tittleKeySubNode=@"MICROSOFT WINDOWS";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];
}



- (void)btn_Mac:(UITapGestureRecognizer *)gestureRecognizer1{
       dispatch_async(dispatch_get_main_queue(), ^{
           threadKeySubNode = @"112";
           tittleKeySubNode=@"MAC OSX";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];
    
}
- (void)btn_Sound:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"44";
        tittleKeySubNode=@"ÂM THANH - TAI NGHE - LOA";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];
}

- (void)btn_AndroidNode:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"133";
        tittleKeySubNode=@"ANDROID";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];
}

- (void)btn_IphoneNode:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"97";
        tittleKeySubNode=@"IPHONE";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];
}
- (void)btn_WphoneNode:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"8";
        tittleKeySubNode=@"WINDOWS PHONE";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];

}

- (void)btn_diemxua:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"83";
        tittleKeySubNode=@"DIỄM XƯA";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];
}
- (void)btn_devSoft:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"99";
        tittleKeySubNode=@"PHÁT TRIỂN PHẦN MỀM DI ĐỘNG VIỆT";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];
}
- (void)btn_cafe:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"30";
        tittleKeySubNode=@"CHÚNG TA CHÚC NHAU";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];
}
- (void)btn_4English:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"161";
        tittleKeySubNode=@"4 ENGLISH";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];
    //[indi_mayTinh startAnimating];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];

}
- (void)btn_luxuryNode:(UITapGestureRecognizer *)gestureRecognizer{
    dispatch_async(dispatch_get_main_queue(), ^{
        threadKeySubNode = @"86";
        tittleKeySubNode=@"ĐẲNG CẤP LUXURY";
        [[NSUserDefaults standardUserDefaults] setObject:threadKeySubNode forKey:@"keyThreadId"];
        [[NSUserDefaults standardUserDefaults] setObject:tittleKeySubNode forKey:@"keyTittle"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    });
    [self.view setUserInteractionEnabled:NO];

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
    hud.dimBackground = YES;
    hud.labelText = @"Đang tải dữ liệu...";
    [self performSelectorOnMainThread:@selector(segueToPastFlights1) withObject:nil waitUntilDone:NO];

}

- (IBAction)Search:(id)sender {
    [self.Search_Bar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
   self.Search_Bar.showsCancelButton = YES;
    [self.Search_Bar setShowsCancelButton:YES animated:YES];
    UIView* view=self.Search_Bar.subviews[0];
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)subView;
            [cancelButton setTitle:@"Đóng" forState:UIControlStateNormal];
        }
    }
}
@end
