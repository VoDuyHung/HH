//
//  TrangChuCollection.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/7/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "TrangChuCollection.h"
#import "TrangChuCollectionCell.h"
#import "LMDropdownView.h"
#import "TrangChuReusableView.h"
#import "DBManager.h"
#import "EditSizeMainPage_TableViewCell.h"
#import "RefreshContrlCollection.h"

@interface TrangChuCollection ()<UITableViewDataSource,UITableViewDelegate,LMDropdownViewDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchControllerDelegate>{
    
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *username;
    NSString *images;
    NSString *title;
    NSString *thread_id;
    NSString *images_post;
    NSString *thread;
    NSString *post_date;
    NSString *user_Post;
    NSString *content_html;
    NSString *url_post;
    NSString *post_id;
    UISlider *slider;
    UIButton *btn_Bookmark, *btn_Search,*btn_trangChu,*btn_dienDan,*btn_muaBan,*btn_dauGia,*btn_Setting;
    UILabel *lbl_textSize,*lbl_leftA,*lbl_rightA,*lbl_trangChu,*lbl_dienDan,*lbl_muaBan,*lbl_dauGia;
    UIImageView *imgV_Setting,*imgV_Bookmark,*imgV_Search,*imgV_trangChu,*imgV_dienDan,*imgV_muaBan,*imgV_dauGia;
    UIImage *img_Setting,*img_Bookmark,*img_Search,*img_trangChu,*img_dienDan,*img_muaBan,*img_dauGia;
    NSString *imgageMain;
    UISearchBar *searchBar;
    NSString *alertread;
    
}
@property (nonatomic) CAPSPageMenu *pagemenu;
@property (strong, nonatomic) IBOutlet UITableView *menuTable;
- (IBAction)SettingButton:(id)sender;
- (IBAction)menuButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet UICollectionView *TrangChu;
@property (strong, nonatomic) LMDropdownView *dropdownView;
//Call database
@property (nonatomic, strong) DBManager *dbManager;
//Array save all values from database when excute query
@property (nonatomic, strong) NSArray *arrResult;
@end
/*Kinds of Iphone when determined size screen*/
#define IS_IPHONE6PLUS (([[UIScreen mainScreen] bounds].size.width) ==414.0f && ([[UIScreen mainScreen] bounds].size.height) ==736.0f)
#define IS_IPHONE6 (([[UIScreen mainScreen] bounds].size.width) ==375.0f && ([[UIScreen mainScreen] bounds].size.height) ==667.0f)
#define IS_IPHONE5S (([[UIScreen mainScreen] bounds].size.width) ==320.0f && ([[UIScreen mainScreen] bounds].size.height) ==568.0f)
#define IS_IPHONE4 (([[UIScreen mainScreen] bounds].size.width) ==320.0f && ([[UIScreen mainScreen] bounds].size.height) ==480.0f)

@implementation TrangChuCollection
static NSString * const reuseIdentifier = @"cell";
/*Method refresh for mainpage*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"SizeText"]==NULL){
        NSUserDefaults *defaults3=[NSUserDefaults standardUserDefaults];
        [defaults3 setObject:@"15" forKey:@"SizeText"];
        [defaults3 synchronize];
    }
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.collectionView.frame), 33)];
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.delegate = (id)self;
    searchBar.hidden= YES;
    searchBar.searchBarStyle = UISearchBarIconSearch;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.layer.cornerRadius=6;
    searchBar.clipsToBounds = YES;
    searchBar.alpha=1.5;
    searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    searchBar.keyboardType = UIKeyboardTypeURL;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.placeholder=@"Tìm kiếm";
    searchBar.barTintColor = [UIColor lightGrayColor];
    searchBar.tintColor = [UIColor lightGrayColor];
    [self.view addSubview:searchBar];
    
    /*Setting table for menu (Detail persional+Nontification+Logout)*/
    UIView *subView= self.view;
    tableView1 = [[UITableView alloc]init];
    tableView1.dataSource = self;
    tableView1.delegate = self;
    tableView1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView1.hidden = YES;
    tableView1.layer.borderWidth = 0.7;
    tableView1.layer.borderColor = [[UIColor grayColor]CGColor ];
    [tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableView1.separatorInset = UIEdgeInsetsMake (0, 0,0,15);
    [subView addSubview:tableView1];
    [self.menuTable setFrame:CGRectMake(0,0,CGRectGetWidth(self.view.bounds),MIN(CGRectGetHeight(self.view.bounds)/2,  270))];

    /*Auto layout for table menu*/
    [tableView1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [subView addConstraint:[NSLayoutConstraint constraintWithItem:tableView1
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.view
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1.0
                                                         constant:-13]];
    
    [subView addConstraint:[NSLayoutConstraint constraintWithItem:tableView1
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:subView
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.4
                                                         constant:0]];
    
    [subView addConstraint:[NSLayoutConstraint constraintWithItem:tableView1
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:subView
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:0.0
                                                         constant:150]];
    
    
    /*Create button setting & catalogy on navigation bar*/
    UIImage *imageForSetting = [UIImage imageNamed:@"120x120.png"];
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.bounds = CGRectMake(0, 0, 30, 30);
    [settingButton setImage:imageForSetting forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(SettingButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sttButton= [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    //menu button
    UIImage *imageForMenu = [UIImage imageNamed:@"menu1.png"];
    UIButton *MenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    MenuButton.bounds = CGRectMake(0, 0, 15, 15);
    [MenuButton setImage:imageForMenu forState:UIControlStateNormal];
    [MenuButton addTarget:self action:@selector(menuButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuItemButton= [[UIBarButtonItem alloc] initWithCustomView:MenuButton];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.043f green:0.318f blue:0.635f alpha:1.00f];
    self.navigationController.navigationBar.alpha = 0.3;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00];//[UIColor colorWithRed:0.918f green:0.918f blue:0.918f alpha:0.9];
    
    /*get avatar*/
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    UIImageView *imageForAvatar ;
    NSString *urlString2 = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getAvatar&hash=%@:%@",useName,hashKey];
    NSURL*url2 = [NSURL URLWithString:urlString2];
    NSData * data2=[NSData dataWithContentsOfURL:url2];
    NSError * error2;
    NSMutableDictionary  * json2 = [NSJSONSerialization JSONObjectWithData:data2 options: NSJSONReadingMutableContainers error: &error2];
    NSString *avatar_user = [json2 valueForKey:@"avatar"];
    NSURL *urlAvatar= [NSURL URLWithString:avatar_user];
    NSData *dataAvatar= [[NSData alloc] initWithContentsOfURL:urlAvatar];
    imageForAvatar.image=[[UIImage alloc] initWithData:dataAvatar];
    [btn_Chitiet setBackgroundImage:imageForAvatar.image=[[UIImage alloc] initWithData:dataAvatar] forState:UIControlStateNormal];
    [btn_Chitiet addTarget:self action:@selector(btn_Chitiet:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *arrayButton= [[NSArray alloc] initWithObjects:menuItemButton,sttButton, nil];
    self.navigationItem.leftBarButtonItems=arrayButton;
    [self loadData];
    [self LoadThongbao];
    
 }
-(void)LoadThongbao{
    NSString *ten=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *ma=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    NSString *urlString1 = [NSString stringWithFormat: @"http://handheld.vn/api.php?action=getUser&value=%@&hash=api.php?action=getUser&hash=%@:%@", ten , ten, ma];
    NSURL*url1 = [NSURL URLWithString:urlString1];
    NSData * data=[NSData dataWithContentsOfURL:url1];
    NSError * error;
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
   // NSLog(@"%@",json);
    long tempthongbao=[[json valueForKey:@"alerts_unread"] integerValue];
    alertread = [NSString stringWithFormat:@"%ld",tempthongbao];

}
/*Method load data from api*/
-(void) loadData{
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
    _filteredTableData = [[NSMutableArray alloc]init];

    //litmit Post
    NSString *limitNumberMainPage;
    //set limit for number of Post on mainpage
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfMainPage"]==NULL){
        limitNumberMainPage=@"50";
    }
    else{
        limitNumberMainPage=[[NSUserDefaults standardUserDefaults] objectForKey:@"numberOfMainPage"];
    }
    //get values from api handheld
    NSString *useName=[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *hashKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"keyMD5"];
    NSString *urlString = [NSString  stringWithFormat: @"http://handheld.com.vn/api.php?action=getThreads&hash=%@:%@&node_id=172&limit=%@&order_by=post_date",useName,hashKey,limitNumberMainPage];
    NSURL*url = [NSURL URLWithString:urlString];
    NSData * data=[NSData dataWithContentsOfURL:url];
    NSError * error;
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &error];
    NSArray * responseArr = json[@"threads"];
   
    for(NSDictionary * dict in responseArr)
    {
        //get values from json
        NSString *referanceArray = [dict valueForKey:@"title"];
        NSString *user_last_post=[dict valueForKey:@"last_post_username"];
        int secondsLeft = [[dict objectForKey:@"last_post_date"] intValue];
        int tempThread = [[dict objectForKey:@"thread_id"] intValue];
        threadKey=[NSString stringWithFormat:@"%d",tempThread];
        //convert date time
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd' Tháng 'MM"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondsLeft];
        NSString *formattedDateString = [dateFormatter stringFromDate:date];
        //get image for post
        NSArray *myWords = [[dict valueForKey:@"thumbnail_cache_waindigo"] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
        NSMutableArray * manghttp=[[NSMutableArray alloc] initWithArray:myWords];
        NSString *hinhanh;
        //Check valid image
        if([[dict valueForKey:@"thumbnail_cache_waindigo"] isEqualToString:@""]){
            hinhanh=@"Could not get images!";
        }
        else{
            hinhanh = [manghttp objectAtIndex:3];
        }
            /*Save all values from api to myObject*/
            dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                          hinhanh,images_post,
                          referanceArray,title,
                          user_last_post,user_Post,
                          formattedDateString,post_date,
                          threadKey,thread_id,
                          nil];
            [myObject addObject:dictionary];
        }
        //method reload tableview
        [self.collectionView reloadData];
}
- (void)showDropDownView
{
    // Init dropdown view
    if (!self.dropdownView) {
        self.dropdownView = [LMDropdownView dropdownView];
        self.dropdownView.delegate= self;
        // Customize Dropdown style
        self.dropdownView.closedScale = 1 ;
        self.dropdownView.blurRadius = 1;
        self.dropdownView.blackMaskAlpha = 0.4;
        self.dropdownView.animationDuration = 0.5;
        self.dropdownView.animationBounceHeight = 20;
        self.dropdownView.contentBackgroundColor = [UIColor colorWithRed:0.855f green:0.855f blue:0.855f alpha:1];
    }
    // Show/hide dropdown view
    if ([self.dropdownView isOpen]) {
        [self.dropdownView hide];
    }
    else {
        [self.dropdownView showFromNavigationController:self.navigationController withContentView:self.menuTable];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.menuTable){
        return 3;
    }
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   // return [myObject count]-1;
    NSInteger rowCount;
    if(_isFiltered){
        rowCount = _filteredTableData.count-1;
    }
    else rowCount = myObject.count-1;
   // NSLog(@"so luong = %lu",(unsigned long)myObject.count);
    return rowCount;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        TrangChuCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        NSDictionary * tmpDict1 = [myObject objectAtIndex:indexPath.row+1];
        NSString *str_02=[[tmpDict1 objectForKey:images_post] substringWithRange:NSMakeRange(0, 1)];

    if(_isFiltered)
    {
        tmpDict1 = [_filteredTableData objectAtIndex:indexPath.row+1];
    }
    else
    {
        tmpDict1 = [myObject objectAtIndex:indexPath.row+1];
    }
    
    if((long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"SizeText"] integerValue]<=17){
        cell.lbl_LageSizeTittle.hidden=YES;
        if([str_02 isEqualToString:@"h"]){
            cell.img_load.hidden=NO;
            cell.imageTrangChu.hidden=YES;
            
            NSString *htmlString;
            if(IS_IPHONE6PLUS){
                htmlString = [NSString stringWithFormat:@"<img src='%@' width='770' height='710'>", [tmpDict1 objectForKey:images_post]];
            }
            else if(IS_IPHONE6){
                htmlString = [NSString stringWithFormat:@"<img src='%@' width='700' height='600'>", [tmpDict1 objectForKey:images_post]];
            }
            else if(IS_IPHONE5S){
                htmlString = [NSString stringWithFormat:@"<img src='%@' width='590' height='440'>", [tmpDict1 objectForKey:images_post]];
            }
            else if(IS_IPHONE4){
                htmlString = [NSString stringWithFormat:@"<img src='%@' width='580' height='340'>", [tmpDict1 objectForKey:images_post]];
            }
            
            //NSLog(@"%@",htmlString);
            cell.img_load.scalesPageToFit=YES;
            [cell.img_load loadHTMLString:htmlString baseURL:nil];
            cell.img_load.scrollView.scrollEnabled = NO;
            [cell.labelTrangChu addSubview:cell.img_load];
        } else{
            cell.imageTrangChu.hidden=NO;
            cell.img_load.hidden=YES;
            cell.imageTrangChu.image=[UIImage imageNamed:@"HH!.jpg"];
        }
        cell.labelTrangChu.hidden=NO;
        cell.lbl_userpost.hidden=NO;
        cell.lbl_datepost.hidden=NO;
        
        //custom padding left
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.headIndent = 8.0;
        paragraphStyle.firstLineHeadIndent = 8.0;
        paragraphStyle.tailIndent = -5.0;
        NSDictionary *attrsDictionary = @{NSParagraphStyleAttributeName: paragraphStyle};
        cell.labelTrangChu.attributedText = [[NSAttributedString alloc] initWithString:[tmpDict1 objectForKey:title] attributes:attrsDictionary];
        
        
        //cell.labelTrangChu.text = [NSString stringWithFormat:@"  %@",[tmpDict1 objectForKey:title]];
        cell.labelTrangChu.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:(long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"SizeText"] integerValue]];
        
        cell.lbl_userpost.attributedText = [[NSAttributedString alloc] initWithString:[tmpDict1 objectForKey:user_Post] attributes:attrsDictionary];
        
        cell.lbl_datepost.text=[tmpDict1 objectForKey:post_date];
    }else{
        cell.lbl_LageSizeTittle.hidden=NO;
        cell.imageTrangChu.hidden=YES;
        cell.img_load.hidden=YES;
        cell.labelTrangChu.hidden=YES;
        cell.lbl_userpost.hidden=YES;
        cell.lbl_datepost.hidden=YES;
        cell.lbl_LageSizeTittle.text=[tmpDict1 objectForKey:title];
        cell.lbl_LageSizeTittle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:(long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"SizeText"] integerValue]];
       
    }
    return cell;
    
}
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        _isFiltered = false;
        [self->searchBar resignFirstResponder];
    }
    else
    {
        _isFiltered = true;
        _filteredTableData =[[NSMutableArray alloc]init];
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"title contains[c] %@",
                                        text];
        _filteredTableData = [myObject  filteredArrayUsingPredicate:resultPredicate];
    }
    [_trangChu reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self->searchBar  resignFirstResponder];
    [self->searchBar  setSearchResultsButtonSelected:YES];
    [_trangChu reloadData];
   // NSLog(@"abc");
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self->searchBar .showsCancelButton = YES;
    [self->searchBar  setShowsCancelButton:YES animated:YES];
    UIView* view=self->searchBar .subviews[0];
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)subView;
            [cancelButton setTitle:@"Đóng" forState:UIControlStateNormal];
        }
    }
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self->searchBar .text=@"";
    [self->searchBar  setShowsCancelButton:NO animated:YES];
    [self->searchBar  resignFirstResponder];
    self->searchBar.hidden = YES;
    _isFiltered = FALSE;
    [_trangChu reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
    }
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
    if(tableView == self.menuTable){
            [cell setBackgroundColor:[UIColor colorWithRed:0.855f green:0.855f blue:0.855f alpha:1]];
        if (indexPath.row == 1){
            //label textsize
                CGFloat screenXX = [[UIScreen mainScreen] bounds].origin.x ;
                CGFloat screenX = screenXX-130;
                CGFloat screenYY = [[UIScreen mainScreen] bounds].origin.y;
                CGFloat screenWidth= [[UIScreen mainScreen]bounds].size.width;
                CGRect frm_textSize = CGRectMake(screenXX,screenYY, screenWidth, 30);
                lbl_textSize = [[UILabel alloc] initWithFrame:frm_textSize];
                lbl_textSize.text = @"Test size";
                [lbl_textSize setTextAlignment:NSTextAlignmentCenter];
                [cell.contentView addSubview:lbl_textSize];
            
                //label leftA
                CGRect frm_leftA = CGRectMake(20, 40.0, 220, 14.0);
                lbl_leftA = [[UILabel alloc] initWithFrame:frm_leftA];
                lbl_leftA.text = @"A";
                lbl_leftA.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
                lbl_leftA.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:lbl_leftA];
            
                //label rightA
                CGRect frm_rightA = CGRectMake(290, 40.0, 220, 14.0);
                lbl_rightA = [[UILabel alloc] initWithFrame:frm_rightA];
                lbl_rightA.text = @"A";
                lbl_rightA.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
                lbl_rightA.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:lbl_rightA];
            
            
                //UISlider
                slider = [[UISlider alloc] init];
                slider.bounds = CGRectMake(screenX, screenYY, 250, slider.bounds.size.height);

                slider.center = CGPointMake(CGRectGetMidX(cell.contentView.bounds), CGRectGetMidY(cell.contentView.bounds));
                slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
                [slider setBackgroundColor:[UIColor clearColor]];
                slider.minimumValue = 10.0;
                slider.maximumValue = 25.0;
                slider.continuous = YES;
               // [[UISlider appearance] setThumbImage:[UIImage imageNamed:@"clock30x30"] forState:UIControlStateNormal];
                slider.value = (long)[[[NSUserDefaults standardUserDefaults] objectForKey:@"SizeText"] integerValue];
                [slider addTarget:self action:@selector(fontText:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:slider];
            
                [lbl_leftA setTranslatesAutoresizingMaskIntoConstraints:NO];
                [lbl_rightA setTranslatesAutoresizingMaskIntoConstraints:NO];
            
                [lbl_leftA.trailingAnchor constraintEqualToAnchor:(cell.leadingAnchor) constant:30].active = true;
                [lbl_leftA.centerYAnchor constraintEqualToAnchor:(cell.centerYAnchor) constant:0].active = true;
                [lbl_rightA.leadingAnchor constraintEqualToAnchor:(cell.trailingAnchor) constant:-30].active = true;
                [lbl_rightA.centerYAnchor constraintEqualToAnchor:(cell.centerYAnchor) constant:0].active = true;
        }
        else
            if(indexPath.row ==0){
                
                //button setting
                btn_Setting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn_Setting.frame = CGRectMake(0, 0, 50, 50);
                imgV_Setting = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_Setting.frame.size.width, btn_Setting.frame.size.height)];
                img_Setting = [UIImage imageNamed:@"Setting2.png"];
                [btn_Setting setTitle:@"changed" forState:UIControlStateHighlighted];
                [btn_Setting addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
                [btn_Setting addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
                [imgV_Setting setImage:img_Setting];
                [btn_Setting addSubview:imgV_Setting];
                [btn_Setting.heightAnchor constraintEqualToConstant:50].active=true;
                [btn_Setting.widthAnchor constraintEqualToConstant:50].active=true;
                
                //button bookmark
                btn_Bookmark = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn_Bookmark.frame = CGRectMake(0, 0, 50.0, 50.0);
                imgV_Bookmark = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_Bookmark.frame.size.width, btn_Bookmark.frame.size.height)];
                img_Bookmark = [UIImage imageNamed:@"bookmark_2.png"];
                [btn_Bookmark addTarget:self action:@selector(btn_bookmark:) forControlEvents:UIControlEventTouchUpInside];
                [imgV_Bookmark setImage:img_Bookmark];
                [btn_Bookmark addSubview:imgV_Bookmark];
                [btn_Bookmark.heightAnchor constraintEqualToConstant:50].active=true;
                [btn_Bookmark.widthAnchor constraintEqualToConstant:50].active=true;
                
                
                //button search
                btn_Search = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn_Search.frame = CGRectMake(0, 0, 50, 50);
                imgV_Search = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_Search.frame.size.width, btn_Search.frame.size.height)];
                img_Search = [UIImage imageNamed:@"Search2.png"];
                [btn_Search addTarget:self action:@selector(btn_Search:) forControlEvents:UIControlEventTouchUpInside];
                [imgV_Search setImage:img_Search];
                [btn_Search addSubview:imgV_Search];
                [btn_Search.heightAnchor constraintEqualToConstant:50].active=true;
                [btn_Search.widthAnchor constraintEqualToConstant:50].active=true;
                
                
                UIStackView *stackViewRow0= [[UIStackView alloc]init];
                stackViewRow0.axis = UILayoutConstraintAxisHorizontal;
                stackViewRow0.distribution = UIStackViewDistributionEqualSpacing;
                stackViewRow0.alignment = UIStackViewAlignmentCenter;
                stackViewRow0.spacing = 35;
                [stackViewRow0 addArrangedSubview:btn_Setting];
                [stackViewRow0 addArrangedSubview:btn_Bookmark];
                [stackViewRow0 addArrangedSubview:btn_Search];
                stackViewRow0.translatesAutoresizingMaskIntoConstraints = false;
                [cell.contentView addSubview:stackViewRow0];
                [stackViewRow0.centerXAnchor constraintEqualToAnchor:cell.centerXAnchor].active = true;
                [stackViewRow0.centerYAnchor constraintEqualToAnchor:(cell.centerYAnchor) constant:0].active = true;

            }
            else
                if(indexPath.row == 2){
                UIStackView *stackViewLable, *stackView;
                UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 500, 110)];
                scrollview.contentSize = CGSizeMake(800 , 110);
                [scrollview setShowsHorizontalScrollIndicator:YES];
                scrollview.scrollEnabled = YES;
                scrollview.userInteractionEnabled = YES;
                scrollview.delegate = self;
                [cell.contentView addSubview:scrollview];
                    
                //button trangchu
                btn_trangChu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn_trangChu.frame = CGRectMake(70, 22, 60, 60);
                imgV_trangChu= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_trangChu.frame.size.width, btn_trangChu.frame.size.height)];
                img_trangChu = [UIImage imageNamed:@"trangchu.jpg"];
                [btn_trangChu addTarget:self action:@selector(btn_trangChu:) forControlEvents:UIControlEventTouchUpInside];
                [imgV_trangChu setImage:img_trangChu];
                imgV_trangChu.layer.cornerRadius=2.5;
                imgV_trangChu.layer.masksToBounds = YES;
                [btn_trangChu addSubview:imgV_trangChu];
                [btn_trangChu.heightAnchor constraintEqualToConstant:60].active = true;
                [btn_trangChu.widthAnchor constraintEqualToConstant:60].active = true;
                [scrollview addSubview:btn_trangChu];
                    
                //button dienDan
                btn_dienDan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn_dienDan.frame = CGRectMake(140, 22, 60, 60);
                imgV_dienDan= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_dienDan.frame.size.width, btn_dienDan.frame.size.height)];
                img_dienDan = [UIImage imageNamed:@"diendan.jpg"];
                [btn_dienDan addTarget:self action:@selector(btn_dienDan:) forControlEvents:UIControlEventTouchUpInside];
                [imgV_dienDan setImage:img_dienDan];
                imgV_dienDan.layer.cornerRadius=2.5;
                imgV_dienDan.layer.masksToBounds = YES;
                [btn_dienDan addSubview:imgV_dienDan];
                [btn_dienDan.heightAnchor constraintEqualToConstant:60].active = true;
                [btn_dienDan.widthAnchor constraintEqualToConstant:60].active = true;
                [scrollview addSubview:btn_dienDan];

                    
                //button muaban
                btn_muaBan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn_muaBan.frame = CGRectMake(210, 22, 60, 60);
                imgV_muaBan= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_muaBan.frame.size.width, btn_muaBan.frame.size.height)];
                img_muaBan = [UIImage imageNamed:@"muaban.jpg"];
                [btn_muaBan addTarget:self action:@selector(btn_muaBan:) forControlEvents:UIControlEventTouchUpInside];
                [imgV_muaBan setImage:img_muaBan];
                imgV_muaBan.layer.cornerRadius=2.5;
                imgV_muaBan.layer.masksToBounds = YES;
                [btn_muaBan addSubview:imgV_muaBan];
                [btn_muaBan.heightAnchor constraintEqualToConstant:60].active = true;
                [btn_muaBan.widthAnchor constraintEqualToConstant:60].active=true;
                [scrollview addSubview:btn_muaBan];
                    
                //button daugia
                btn_dauGia = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn_dauGia.frame = CGRectMake(280, 22, 60, 60);
                imgV_dauGia= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_dauGia.frame.size.width, btn_dauGia.frame.size.height)];
                img_dauGia= [UIImage imageNamed:@"daugia.jpg"];
                [btn_dauGia addTarget:self action:@selector(btn_dauGia:) forControlEvents:UIControlEventTouchUpInside];
                [imgV_dauGia setImage:img_dauGia];
                imgV_dauGia.layer.cornerRadius=2.5;
                imgV_dauGia.layer.masksToBounds = YES;
                [btn_dauGia addSubview:imgV_dauGia];
                [btn_dauGia.heightAnchor constraintEqualToConstant:60].active = true;
                [btn_dauGia.widthAnchor constraintEqualToConstant:60].active=true;
                [scrollview addSubview:btn_dauGia];
                    
                    
                //stackview for btn trang chu,mua ban,đienan,dau gia
                stackView = [[UIStackView alloc]initWithFrame:CGRectMake(0, 0, 500, 110)];
                stackView.axis = UILayoutConstraintAxisHorizontal;
                stackView.distribution = UIStackViewDistributionEqualSpacing;
                stackView.alignment = UIStackViewAlignmentCenter;
                stackView.spacing = 25;
                [stackView addArrangedSubview:btn_trangChu];
                [stackView addArrangedSubview:btn_muaBan];
                [stackView addArrangedSubview:btn_dauGia];
                [stackView addArrangedSubview:btn_dienDan];
                stackView.translatesAutoresizingMaskIntoConstraints = false;
                [scrollview addSubview:stackView];
                [stackView.centerXAnchor constraintEqualToAnchor:cell.centerXAnchor].active = true;
                [stackView.centerYAnchor constraintEqualToAnchor:(cell.centerYAnchor) constant:-30].active = true;
                    
                //lable trang chu
                lbl_trangChu = [[UILabel alloc] init];
                lbl_trangChu.text = @"TRANG CHỦ";
                [lbl_trangChu setTextAlignment:NSTextAlignmentCenter];
                lbl_trangChu.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
                lbl_trangChu.backgroundColor = [UIColor clearColor];
                [lbl_trangChu.heightAnchor constraintEqualToConstant:30].active = true;
                [lbl_trangChu.widthAnchor constraintEqualToConstant:60].active=true;
                    
                //lable dien dan
                lbl_dienDan = [[UILabel alloc] init];
                lbl_dienDan.text = @"DIỄN ĐÀN";
                [lbl_dienDan setTextAlignment:NSTextAlignmentCenter];
                lbl_dienDan.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
                lbl_dienDan.backgroundColor = [UIColor clearColor];
                [lbl_dienDan.heightAnchor constraintEqualToConstant:30].active = true;
                [lbl_dienDan.widthAnchor constraintEqualToConstant:60].active=true;
                    
                //lable mua ban
                lbl_muaBan  = [[UILabel alloc] init];
                lbl_muaBan.text = @"MUA BÁN";
                [lbl_muaBan setTextAlignment:NSTextAlignmentCenter];
                lbl_muaBan.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
                lbl_muaBan.backgroundColor = [UIColor clearColor];
                [lbl_muaBan.heightAnchor constraintEqualToConstant:30].active = true;
                [lbl_muaBan.widthAnchor constraintEqualToConstant:60].active=true;

                //lable dau gia
                lbl_dauGia = [[UILabel alloc] init];
                lbl_dauGia.text = @"ĐẤU GIÁ";
                [lbl_dauGia setTextAlignment:NSTextAlignmentCenter];
                lbl_dauGia.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
                lbl_dauGia.backgroundColor = [UIColor clearColor];
                [lbl_dauGia.heightAnchor constraintEqualToConstant:20].active = true;
                [lbl_dauGia.widthAnchor constraintEqualToConstant:50].active=true;
                [scrollview addSubview:lbl_dauGia];
                //stackview for lable trang chu, mua ban,dau gia,dien dan
                stackViewLable = [[UIStackView alloc]initWithFrame:CGRectMake(0, 0, 500,110)];
                stackViewLable.axis = UILayoutConstraintAxisHorizontal;
                stackViewLable.distribution = UIStackViewDistributionEqualSpacing;
                stackViewLable.alignment = UIStackViewAlignmentCenter;
                stackViewLable.spacing = 25;
                [stackViewLable addArrangedSubview:lbl_trangChu];
                [stackViewLable addArrangedSubview:lbl_muaBan];
                [stackViewLable addArrangedSubview:lbl_dauGia];
                [stackViewLable addArrangedSubview:lbl_dienDan];
                stackViewLable.translatesAutoresizingMaskIntoConstraints = false;
                [scrollview addSubview:stackViewLable];
                [stackViewLable.centerXAnchor constraintEqualToAnchor:(cell.centerXAnchor) constant:-5].active = true;
                [stackViewLable.centerYAnchor constraintEqualToAnchor:(cell.centerYAnchor) constant:20].active = true;
                    
                    
           }
    }
    else
        
        if(tableView == tableView1){
           
            tableView1.scrollEnabled=NO;
            // table notification
            if(indexPath.row == 0){
                cell.textLabel.text = @"Chi tiết cá nhân";
                cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
            }
            else  if(indexPath.row == 1) {
                cell.textLabel.text = @"Thông báo";
                cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
                CGRect frm_daugia = CGRectMake(100, 15.0, 20, 20.0);
                lbl_dauGia = [[UILabel alloc] initWithFrame:frm_daugia];
                lbl_dauGia.layer.cornerRadius=10;
                NSLog(@"so thong bao=%@ ",alertread);
                lbl_dauGia.text = alertread;
                lbl_dauGia.textAlignment = NSTextAlignmentCenter;
                lbl_dauGia.textColor = [UIColor whiteColor];
                lbl_dauGia.layer.masksToBounds = YES;
                lbl_dauGia.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10.0];
                lbl_dauGia.backgroundColor = [UIColor colorWithRed:0.043f green:0.318f blue:0.635f alpha:1.00f];
                [cell.contentView addSubview:lbl_dauGia];
            }
            else if(indexPath.row == 2 ){
                cell.textLabel.text = @"Đăng xuất";
                cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
            }
            
        }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{   //event chiều cao của dòng
    
    if(tableView == self.menuTable){
        if(indexPath.row == 2){
            return 150.0f;
        }
        else {
           if(IS_IPHONE4){
            return 60.0f;
           }
            return 80.0f;
              }
    }
    return 50.0f;
}
              
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return -10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    NSUInteger space = 7;
    NSUInteger bar = 2;
    CGSize listCellSize = CGSizeMake((screenSize.size.width - space * 0.5) / 2,
                                     (screenSize.size.height - bar - space * 2)/2.5);
    return listCellSize;
    
    
}
- (CGFloat)collectionView:(UICollectionView *) collectionView
                   layout:(UICollectionViewLayout *) collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger) section {
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tmpDict1 = [myObject objectAtIndex:indexPath.row+1];
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    //send value from Mainpage to read detail Post
    [defaults1 setObject:@"95" forKey:@"keyThreadId"];
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:title] forKey:@"TitleOf_Post"];
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:user_Post] forKey:@"UserOf_Post"];
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:post_date] forKey:@"DateOf_Post"];
    //[defaults1 setObject:[self stringByStrippingHTML:[tmpDict1 objectForKeyedSubscript:content_html]] forKey:@"ContentOf_Post"];
    //-------------------------------------------------------------------------
    [defaults1 setObject:@"172" forKey:@"keyThreadId"];
    //[defaults1 setObject:[tmpDict1 objectForKeyedSubscript:url_post] forKey:@"url_Share"];
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:thread_id] forKey:@"post_id"];
    [defaults1 setObject:[tmpDict1 objectForKey:images_post] forKey:@"image_Post"];
    [defaults1 setObject:@"BÀI ĐĂNG TRANG CHỦ" forKey:@"keyTittle"];
    [defaults1 synchronize];
    [self performSegueWithIdentifier:@"baidangtrangchu" sender:self];

}
- (IBAction)SettingButton:(id)sender {
    if( tableView1.hidden == NO){
        tableView1.hidden = YES;
    }
    [self showDropDownView];
    searchBar.hidden=YES;
}

- (IBAction)menuButton:(id)sender {

      [self performSegueWithIdentifier:@"muaban" sender:nil];

    
}
- (IBAction)btn_Chitiet:(id)sender {
    if( tableView1.hidden == YES||searchBar.hidden==NO){
        tableView1.hidden = NO;
        searchBar.hidden = YES;
    }
    else
        tableView1.hidden = YES;
}
- (IBAction)buttonHighlight:(id)sender {   //event chỉnh ẩn hiển của thôg báo
}
- (IBAction)buttonNormal:(id)sender{
   [self performSegueWithIdentifier:@"setting" sender:self];
}
- (IBAction)btn_trangChu:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    NSLog(@"btntrangchu");
    [self showDropDownView];
    [self.collectionView reloadData];
    
}
- (IBAction)btn_dienDan:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    NSLog(@"đienan");
    [self performSegueWithIdentifier:@"diendan" sender:self];
}
- (IBAction)btn_dauGia:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    NSLog(@"btbdaugia");
    [self performSegueWithIdentifier:@"daugia" sender:self];
    
}
- (IBAction)btn_muaBan:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    NSLog(@"btnmuaban");
    [self performSegueWithIdentifier:@"muaban" sender:self];
}
- (IBAction)btn_bookmark:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    NSLog(@"btnbookmark");
    [self performSegueWithIdentifier:@"baidangyeuthich" sender:self];
    
}
- (IBAction)btn_Search:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    NSLog(@"btnsearch");
    [self showDropDownView];
    if(searchBar.hidden==YES){
        searchBar.hidden = NO;
    }
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TrangChuReusableView *headerView ;
    NSDictionary * tmpDict;
    UICollectionReusableView *reusableview = nil;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handleTapGuesture)];
    headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1" forIndexPath:indexPath];
    if(_isFiltered){
        if(_filteredTableData.count==0){
            reusableview = headerView;
        }else{
            tmpDict = [_filteredTableData objectAtIndex:0];
            if (kind == UICollectionElementKindSectionHeader) {
                //headerView.lbl_tittlemainPage.text = [tmpDict objectForKey:title];
                NSString *htmlString = [NSString stringWithFormat:@"<img src='%@' width='980' height='815'>", [tmpDict objectForKey:images_post]];
                headerView.img_MainPage.scalesPageToFit=YES;
                [headerView.img_MainPage loadHTMLString:htmlString baseURL:nil];
                headerView.img_MainPage.scrollView.scrollEnabled = NO;
                [headerView.lbl_tittlemainPage addSubview:headerView.img_MainPage];
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.headIndent = 12.0;
                paragraphStyle.firstLineHeadIndent = 12.0;
                paragraphStyle.tailIndent = -5.0;
                NSDictionary *attrsDictionary = @{NSParagraphStyleAttributeName: paragraphStyle};
                headerView.lbl_temp.attributedText = [[NSAttributedString alloc] initWithString:[tmpDict objectForKey:title] attributes:attrsDictionary];
                [headerView addGestureRecognizer:tap];
                reusableview = headerView;
            }
        }
    }
    else{
        tmpDict = [myObject objectAtIndex:0];
        if (kind == UICollectionElementKindSectionHeader) {
            //headerView.lbl_tittlemainPage.text = [tmpDict objectForKey:title];
            NSString *htmlString = [NSString stringWithFormat:@"<img src='%@' width='980' height='815'>", [tmpDict objectForKey:images_post]];
            headerView.img_MainPage.scalesPageToFit=YES;
            [headerView.img_MainPage loadHTMLString:htmlString baseURL:nil];
            headerView.img_MainPage.scrollView.scrollEnabled = NO;
            [headerView.lbl_tittlemainPage addSubview:headerView.img_MainPage];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.headIndent = 12.0;
            paragraphStyle.firstLineHeadIndent = 12.0;
            paragraphStyle.tailIndent = -5.0;
            NSDictionary *attrsDictionary = @{NSParagraphStyleAttributeName: paragraphStyle};
            headerView.lbl_temp.attributedText = [[NSAttributedString alloc] initWithString:[tmpDict objectForKey:title] attributes:attrsDictionary];
            [headerView addGestureRecognizer:tap];
            reusableview = headerView;
        }

    }
    return reusableview;
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
-(void)handleTapGuesture{
    NSLog(@"selector touch");
    NSDictionary *tmpDict1 = [myObject objectAtIndex:0];
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    //save to SQLite----------------------------------------------------------
    [defaults1 setObject:@"95" forKey:@"keyThreadId"];
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:title] forKey:@"TitleOf_Post"];
    //user of post
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:user_Post] forKey:@"UserOf_Post"];
    //date of post
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:post_date] forKey:@"DateOf_Post"];
    //content of post
    //-------------------------------------------------------------------------
    [defaults1 setObject:@"172" forKey:@"keyThreadId"];
    //send values post_id to Comment_ViewController
    [defaults1 setObject:[tmpDict1 objectForKeyedSubscript:thread_id] forKey:@"post_id"];
    [defaults1 setObject:[tmpDict1 objectForKey:images_post] forKey:@"image_Post"];
    [defaults1 setObject:@"BÀI ĐĂNG TRANG CHỦ" forKey:@"keyTittle"];
    [defaults1 synchronize];
    [self performSegueWithIdentifier:@"baidangtrangchu" sender:self];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"da tai xong");
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *titles = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([titles isEqualToString:@"Xác nhận"])
    {
        [self dismissViewControllerAnimated:YES completion:^{ NSLog(@"controller dismissed"); }];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   if(tableView == tableView1){
        if(indexPath.row == 0){
            [self performSegueWithIdentifier:@"chittietcanhan" sender:self];
        
        }
        if(indexPath.row == 2){
            [self alertStatus:@"Bạn chắc chắn muốn đăng xuất?" :@"" :0];
        
        }
    }
    else if(tableView == self.menuTable){
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}
-(int)roundSliderValue:(int)x {
    if (x <= 20) {
        if(x<=15)
        {
            if(x<13){
                return 10;
            }
            else
            {
                return 13;
            }
        }
        else
        {
            if(x<16)
            {
                return 15;
            }
            else
            {
                return 17;
            }
        }
    }
    else
    {
        if(x<25)
        {
            if(x<20)
            {
                return 19;
            }
            else
            {
                return 21;
            }
        }
        else
        {
            if(x<=23)
            {
                return 23;
            }
            else
            {
                return 25;
            }
        }
    }
}
- (IBAction)fontText:(id)sender {
    [slider setValue:[self roundSliderValue:slider.value] animated:NO];
    //send value from Mainpage to read detail Post
    NSString *save_TextSize=[NSString stringWithFormat:@"%d",(int)slider.value];
    [[NSUserDefaults standardUserDefaults] setObject:save_TextSize forKey:@"SizeText"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    lbl_textSize.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:slider.value];
}
@end

