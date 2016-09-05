//
//  Comment_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/27/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "Comment_TableViewController.h"
#import "LoadComment_TableViewCell.h"
#import "DBManager.h"

@interface Comment_TableViewController (){
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *username_comment;
    NSString *like_comment;
    NSString *date_comment;
    NSString *content_comment;
    NSString *avatar_comment;
    NSString *html_comment;
    NSString *user_ID;
    NSMutableArray *myObject_Avatar;
    NSDictionary *dictionary_Avatar;
}
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrResult;

@end

@implementation Comment_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_sync (dispatch_get_global_queue (0, 0),
                   ^{
                       [self loadComment];
                   });
}
-(void)loadComment{
    myObject = [[NSMutableArray alloc]init];
    username_comment=@"username";
    like_comment=@"likes";
    date_comment=@"post_date";
    content_comment=@"message_html";
    avatar_comment=@"avatar";
    html_comment=@"message_html";
    user_ID=@"user_id";
    
    //get key from TableViewController----------------------------------------------
    NSString *thread_key = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyThreadId"];
    NSString *thread_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"post_id"];
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    //khai bao tableviewCell------------------------------------------
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LoadComment_TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LoadComment_TableViewCell class])];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //get values
        NSString *urlString1 = [NSString  stringWithFormat: @"http://handheld.vn/api.php?action=getPosts&hash=%@:%@&node_id=%@&thread_id=%@&limit=500",useName,hashKey,thread_key,thread_id];
        NSURL*url1 = [NSURL URLWithString:urlString1];
        NSData * data1=[NSData dataWithContentsOfURL:url1];
        NSError * error1;
        NSMutableDictionary  * json1 = [NSJSONSerialization JSONObjectWithData:data1 options: NSJSONReadingMutableContainers error: &error1];
        NSString *html;
        NSString *username;
        NSString *likes;
        NSString *user_id;
        
        for(NSDictionary * dict1 in json1[@"posts"])
        {
            html= [dict1 valueForKey:@"message_html"];
            username = [dict1 valueForKey:@"username"];
          
            likes=[NSString stringWithFormat:@"%d",[[dict1 objectForKey:@"likes"] intValue]];
          
            user_id=[NSString stringWithFormat:@"%d",[[dict1 objectForKey:@"user_id"] intValue]];
            NSString* name = [self stringByStrippingHTML:username];
         
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            int secondsLeft = [[dict1 objectForKey:@"post_date"] intValue];
            [dateFormatter setDateFormat:@"dd' Tháng 'MM',' yyyy ', 'HH':'mm'"]; //', 'HH':'mm'"];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondsLeft];
            NSString *formattedDateString = [dateFormatter stringFromDate:date];
            dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                          html,content_comment,
                          name,username_comment,
                          likes,like_comment,
                          formattedDateString,date_comment,
                          user_id,user_ID,
                          //avatar_user,avatar_comment,
                          nil];
            [myObject addObject:dictionary];
        }
        long count_cmt;
        if(myObject.count>0){
            count_cmt=[myObject count]-1;
        }else{
            count_cmt=0;
        }
        NSString *comment_number=[NSString stringWithFormat:@"%ld",count_cmt];
        [alert_comment setTitle:comment_number forState:UIControlStateNormal];
    } @catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }

}
-(NSString *)stringByStrippingHTML:(NSString*)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (myObject.count>1) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"Hiện tại không có bình luận nào cho bài viết này!";
        messageLabel.textColor = [UIColor grayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    long sum=myObject.count-1;
    if(sum<=0){
        return 0;
    }else{
        return myObject.count-1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoadComment_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LoadComment_TableViewCell class]) forIndexPath:indexPath];
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
        NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row+1];
        cell.lbl_comment.text=[self stringByStrippingHTML:[tmpDict objectForKeyedSubscript:content_comment]];
        cell.lbl_name.text=[tmpDict objectForKeyedSubscript:username_comment];
        cell.lbl_date.text=[tmpDict objectForKeyedSubscript:date_comment];
        cell.lbl_like.text=[tmpDict objectForKeyedSubscript:like_comment];
    
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
        NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
        NSString *urlString2 = [NSString  stringWithFormat: @"http://handheld.vn/api.php?action=getAvatar&hash=%@:%@",[tmpDict objectForKeyedSubscript:user_ID],hashKey];
        NSURL*url2 = [NSURL URLWithString:urlString2];
        NSData * data2=[NSData dataWithContentsOfURL:url2];
        NSError * error2;
        NSMutableDictionary  * json2 = [NSJSONSerialization JSONObjectWithData:data2 options: NSJSONReadingMutableContainers error: &error2];
        NSString *avatar_user = [json2 valueForKey:@"avatar"];
        NSURL *url_avatar=[NSURL URLWithString:avatar_user];
        NSData *data = [NSData dataWithContentsOfURL:url_avatar];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imgAvatar.image = image;
        });
    });
    return cell;
}
- (UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), NO, 0.0);
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *tmpDict1 = [myObject objectAtIndex:indexPath.row+1];
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:content_comment] forKey:@"chitiet_binhluan"];
    [defaults1 synchronize];
    [self performSegueWithIdentifier:@"chitietbinhluan" sender:self];
}
- (void)runIndicatorAtIndexPath:(NSIndexPath *)indexPath display:(BOOL)playing{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    //[activityIndicator setCenter:YES];
    cell.accessoryView = activityIndicator;
    playing == YES ?[activityIndicator startAnimating]:[activityIndicator stopAnimating];
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [self runIndicatorAtIndexPath:indexPath display:YES];
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [self runIndicatorAtIndexPath:indexPath display:NO];
}
@end