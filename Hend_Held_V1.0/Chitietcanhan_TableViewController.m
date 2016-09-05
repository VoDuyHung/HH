//
//  Chitietcanhan_TableViewController.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/9/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "Chitietcanhan_TableViewController.h"
#import "CellChititetcanhan_TableViewCell.h"
#import "DBManager.h"
@interface Chitietcanhan_TableViewController (){
    NSMutableArray *myObject;
    NSDictionary *dictionary_name, *dictionary_email,*dictionary_date,*dictionary_LAc,*dictionary_avatar,*dictionary_postCount,*alertCount;
    NSString * _name, * _LActivity,* _Avatar,*_PostCount;
    NSString * _email;
    NSString *_register_date;
    NSString *_alert_count;
}
@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrResult;

@end

@implementation Chitietcanhan_TableViewController
-(void)loadDataFromApi{
    _name=@"username";
    _email=@"email";
    _register_date=@"register_date";
    _LActivity = @"last_activity";
    _Avatar = @"avatar";
    _PostCount = @"count";
    _alert_count=@"alerts_unread";
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    @try {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSString *urlString1 = [NSString stringWithFormat: @"http://handheld.vn/api.php?action=getUser&value=%@&hash=api.php?action=getUser&hash=%@:%@", useName , useName, hashKey];
        NSURL*url1 = [NSURL URLWithString:urlString1];
        NSData * data=[NSData dataWithContentsOfURL:url1];
        NSError * error;
        NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        NSLog(@"%@",json);
        NSString *Name = [json valueForKey:@"username"];
        
        NSString *Email =[json valueForKey:@"email"];
        
        int secondsLeft = [[json objectForKey:@"register_date"] intValue];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd' Tháng 'MM',' yyyy"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondsLeft];
        NSString *formattedDateString = [dateFormatter stringFromDate:date];
        
        
        int LAc = [[json objectForKey:@"last_activity"] intValue];
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateStyle:NSDateFormatterNoStyle];
        [dateFormatter1 setTimeStyle:NSDateFormatterShortStyle];
        NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:LAc];
        NSString *formattedDateString1 = [dateFormatter1 stringFromDate:date1];
        
        NSString * alert= [json valueForKey:@"alerts_unread"];
        dictionary_name = [NSDictionary dictionaryWithObjectsAndKeys:
                           Name,_name,nil];
        dictionary_email = [NSDictionary dictionaryWithObjectsAndKeys:
                            Email,_email,nil];
        alertCount = [NSDictionary dictionaryWithObjectsAndKeys:
                      alert,_alert_count,nil];
        dictionary_date = [NSDictionary dictionaryWithObjectsAndKeys:formattedDateString,_register_date, nil];
        
        dictionary_LAc = [NSDictionary dictionaryWithObjectsAndKeys:formattedDateString1,_LActivity, nil];
        
        NSString *urlString2 = [NSString stringWithFormat: @"http://handheld.vn/api.php?action=getAvatar&size=M&hash=%@:api.php?action=getAvatar&hash=%@:%@", useName , useName, hashKey];
        
        NSURL*url2 = [NSURL URLWithString:urlString2];
        
        NSData * dataAvatar= [NSData dataWithContentsOfURL:url2];
        
        NSError *errorAvatar ;
        
        NSMutableDictionary *jsonAvatar= [NSJSONSerialization JSONObjectWithData:dataAvatar options:NSJSONReadingMutableContainers error:&errorAvatar];
        
        
        NSString *avatar = [jsonAvatar valueForKey:@"avatar"];
        dictionary_avatar = [NSDictionary dictionaryWithObjectsAndKeys:avatar,_Avatar, nil];
        
        NSString *urlString3 = [NSString stringWithFormat: @"http://www.handheld.com.vn/api.php?action=getThreads&hash=%@:%@&author=%@", useName , hashKey, useName];
        NSURL*url3 = [NSURL URLWithString:urlString3];
        
        NSData * dataPostCount= [NSData dataWithContentsOfURL:url3];
        
        NSError *errorPostCount ;
        
        NSMutableDictionary *jsonPostCount= [NSJSONSerialization JSONObjectWithData:dataPostCount options:NSJSONReadingMutableContainers error:&errorPostCount];
        //NSLog(@"%@",jsonPostCount);
        
        
        id postCount = [jsonPostCount valueForKey:@"count"];
        dictionary_postCount = [NSDictionary dictionaryWithObjectsAndKeys:postCount,_PostCount, nil];
    }@catch (NSException *exception) {
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Không có kết nối internet.Vui lòng kiểm tra lại kết nối!"  delegate:self cancelButtonTitle:@"Xác nhận"  otherButtonTitles:nil];
        [myAlert show];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.043f green:0.318f blue:0.635f alpha:1.00f];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"FAVORITE_LIST.sqlite"];
    myObject = [[NSMutableArray alloc] init];
    NSString *query = [NSString stringWithFormat:@"%@", @"SELECT * FROM FV_LIST"];
    // Get the results.
    if (self.arrResult != nil) {
        self.arrResult = nil;
    }
    self.arrResult = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    [self loadDataFromApi];
    
}
#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    CellChititetcanhan_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       if (!cell){
        cell = [[CellChititetcanhan_TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSDictionary *NSName= dictionary_name;
    NSDictionary *NSEmail=dictionary_email;
    NSDictionary *NSDate = dictionary_date;
    NSDictionary *NSLAc= dictionary_LAc;
    NSDictionary *NSPostCount= dictionary_postCount;
    NSDictionary *NSalertCount= alertCount;
    
    NSMutableString * postCount;
    postCount = [NSMutableString stringWithFormat:@"%@" ,[NSPostCount objectForKeyedSubscript:_PostCount]];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
    
    if(indexPath.section == 0) {
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)])//tăng seoarator full for table
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
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text =[NSMutableString stringWithFormat:@"%@" ,[NSName objectForKeyedSubscript:_name]];
                cell.textLabel.text =@"Tên";
                break;
            case 1:
                cell.detailTextLabel.text =[NSMutableString stringWithFormat:@"%@" ,[NSEmail objectForKeyedSubscript:_email]];

                cell.textLabel.text = @"Email";
                break;
            case 2:
                cell.textLabel.text = @"Thành viên từ";
                cell.detailTextLabel.text = [NSMutableString stringWithFormat:@"%@" ,[NSDate objectForKeyedSubscript:_register_date]];
            default:
                break;
        }
    }
    else if(indexPath.section == 1){
        
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)])//tăng seoarator full for table
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
        switch (indexPath.row) {
                
            case 0:
                cell.textLabel.text = @"Hoạt động cuối";
                cell.detailTextLabel.text =[NSMutableString stringWithFormat:@"%@" ,[NSLAc objectForKeyedSubscript:_LActivity]];
                break;
            case 1:
                cell.textLabel.text =@"Thông báo";
                cell.detailTextLabel.text = [NSMutableString stringWithFormat:@"%@" ,[NSalertCount objectForKeyedSubscript:_alert_count]];
                break;
            case 2:
                cell.textLabel.text =@"Bài đăng";
                cell.detailTextLabel.text = postCount;
                break;
            case 3:
                cell.textLabel.text =@"Đang theo dõi";
                cell.detailTextLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.arrResult.count];
                
            default:
                break;
        }
    }
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *NSName= dictionary_name;
    NSDictionary *NSAvatar =dictionary_avatar;
    
    NSMutableString * Name;
    Name = [NSMutableString stringWithFormat:@"%@" ,[NSName objectForKeyedSubscript:_name]];

    NSURL *urlAvatar= [NSURL URLWithString:[NSAvatar objectForKey:_Avatar]];
    NSData *dataAvatar=[NSData dataWithContentsOfURL:urlAvatar];
    UIImage *img= [[UIImage alloc]initWithData:dataAvatar];
    
    
    
    UIView *headerView1 = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,150)];
    UIView *headerView2 = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,150)];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(-145,32, headerView1.frame.size.width, 25.0)];
    headerLabel.textAlignment = NSTextAlignmentRight;
    headerLabel.textColor=[UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:14.f ];
    headerLabel.backgroundColor = [UIColor clearColor];
    [headerView1 addSubview:headerLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30,20, 70.0 , 70.0)];
    imageView.layer.cornerRadius=34.8;
    imageView.layer.borderWidth=2.0;
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderColor=[[UIColor colorWithRed:0.063f green:0.322f blue:0.635f alpha:1.00f] CGColor];
    [headerView1 addSubview:imageView];
    
    
    UILabel *headerLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(-180,35, headerView1.frame.size.width, 50.0)];
    headerLabel2.textAlignment = NSTextAlignmentRight;
    headerLabel2.textColor=[UIColor colorWithRed:0.184f green:0.400f blue:0.667f alpha:1.00f];
    headerLabel2.backgroundColor = [UIColor clearColor];
    headerLabel2.font = [UIFont systemFontOfSize:10.f ];
    [headerView1 addSubview:headerLabel2];
    
    [headerLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [headerLabel2 setTranslatesAutoresizingMaskIntoConstraints:NO];
   
    //constrant of headerView1
    
   [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0
                                                             constant:150]];
    
    
    [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:imageView
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:1.0
                                                             constant:150]];
    
    [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                            attribute:NSLayoutAttributeWidth
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1.0
                                                             constant:70]];

    [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil
                                                            attribute:NSLayoutAttributeHeight
                                                           multiplier:1.0
                                                             constant:70]];
    
    [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:headerView1
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:0]];

    [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:headerView1
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0
                                                             constant:40]];
   
    [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:headerView1
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:30]];
    
    
    [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel2
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:headerLabel
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                             constant:0]];
    
    [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel2
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:headerView1
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1.0
                                                             constant:50]];
    
    [headerView1 addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel2
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:headerView1
                                                            attribute:NSLayoutAttributeLeading
                                                           multiplier:0.5
                                                             constant:143]];
    

    
    
    UILabel *headerLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(-160, 4, headerView2.frame.size.width, 25.0)];
    headerLabel1.textAlignment = NSTextAlignmentRight;
    headerLabel1.textColor=[UIColor blackColor];
    headerLabel1.backgroundColor = [UIColor clearColor];
    headerLabel1.font = [UIFont systemFontOfSize:14.f ];
    [headerView2 addSubview:headerLabel1];
    
    [headerLabel1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [headerView2 addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel1
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:headerView2
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:0]];
    [headerView2 addConstraint:[NSLayoutConstraint constraintWithItem:headerLabel1
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:headerView2
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0
                                                             constant:22]];
    
    if(section ==0 ){
        [imageView setImage:img];
        headerLabel.text = Name;
        headerLabel2.text = @"Dự bị";
        return headerView1;
    }
    else{
        headerLabel1.text = @"THÔNG TIN BỔ SUNG";
        return headerView2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 100;
        
    }
    return 30;
}
@end
