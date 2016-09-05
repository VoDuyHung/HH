//
//  Menu_.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 9/24/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "Menu_.h"
#import "UIColor+CreateMethods.h"
#import "SCLAlertView.h"
#import "TableViewCell.h"
#import "ViewController.h"
#import "DBManager.h"
#import "LMDropdownView.h"
@interface Menu_ (){
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *username;
    NSString *node_id;
    NSString *title;
    NSString *thread_id;
}

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrResult;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_thongbao;
@property (strong, nonatomic) IBOutlet UITableView *menutable;
@property (strong, nonatomic) LMDropdownView *dropdownView;



@end

@implementation Menu_{
}
/*@synthesize  menuDrodown_Avatar = _Dr_Avatar;
- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}
*/

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    tableView1 = [[UITableView alloc]init];
    tableView1.frame = CGRectMake(187, 0, 120,95);
    tableView1.dataSource = self;
    tableView1.delegate = self;
    tableView1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView1.hidden = YES;
    tableView1.layer.borderWidth = 0.7;
    tableView1.layer.borderColor = [[UIColor grayColor]CGColor];
    [tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [tableView1 reloadData];
    tableView1.separatorInset = UIEdgeInsetsMake (0, 0,0,15);
    [self.view addSubview:tableView1];
    
    
    [self.menutable setFrame:CGRectMake(100,
                                            100,
                                            CGRectGetWidth(self.view.bounds),
                                            MIN(CGRectGetHeight(self.view.bounds)/2,  200))];
    

     //code for Navigation bar-------------------------------------
    UIImage *imageForSetting = [UIImage imageNamed:@"Logo.png"];
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingButton.bounds = CGRectMake(0, 0, 25, 25);
    [settingButton setImage:imageForSetting forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settingButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sttButton= [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
    //menu button
    UIImage *imageForMenu = [UIImage imageNamed:@"menu1.png"];
    UIButton *MenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    MenuButton.bounds = CGRectMake(0, 0, 20, 20);
    [MenuButton setImage:imageForMenu forState:UIControlStateNormal];
    [MenuButton addTarget:self action:@selector(MenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *menuItemButton= [[UIBarButtonItem alloc] initWithCustomView:MenuButton];
    
    NSArray *arrayButton= [[NSArray alloc] initWithObjects:menuItemButton,sttButton, nil];
    self.navigationItem.leftBarButtonItems=arrayButton;

    //tableview
   // [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TableViewCell class])];
    title = @"title";
    username = @"thumbnail_cache_waindigo";
    myObject = [[NSMutableArray alloc] init];
    // goi bien USER_NAME & HASH_KEY  tu ben class ViewController;
    //su dung SQLite
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"USERDB.sqlite"];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM USERTABLE"];
    
    // Get the results.
    if (self.arrResult != nil) {
        self.arrResult = nil;
    }
    self.arrResult = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSString *hashKey = [[self.arrResult objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"HASHKEY"]];
    NSString *useName = [[self.arrResult objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"USERNAME"]];
    NSLog(@"%@",hashKey);
    NSLog(@"%@",useName);

    //truyen username va hashkey vao trong chuoi json
    NSString *urlString = [NSString  stringWithFormat: @"http://dev.handheld.vn/api.php?action=getThreads&hash=%@:%@&node_id=95&limit=50&order_by=post_date", useName , hashKey];
    NSURL*url = [NSURL URLWithString:urlString];
    NSData * data=[NSData dataWithContentsOfURL:url];
    NSError * error;
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    //lap theo gia tri cua threads
    NSArray * responseArr = json[@"threads"];
    for(NSDictionary * dict in responseArr)
    {
        //lay gia tri
    NSString *referanceArray = [dict valueForKey:@"title"];
    NSString *periodArray =[dict valueForKey:@"thumbnail_cache_waindigo"];
        //NSString *numberfm = [dict valueForKey:@"username"];
    NSString *searchedString = periodArray;
    //cat chuỗi để lấy ra link hình ảnh
    NSArray *myWords = [searchedString componentsSeparatedByCharactersInSet:
                            [NSCharacterSet characterSetWithCharactersInString:@"\""]
                            ];
    NSMutableArray * manghttp=[[NSMutableArray alloc] initWithArray:myWords];
        //lấy chuỗi link hình trong mảng
    NSString *hinhanh = [manghttp objectAtIndex:3];
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      //numberfm,thread_id,
                      referanceArray,title,
                      hinhanh,username,
                      nil];
        [myObject addObject:dictionary];
    }
}
- (void)showDropDownView
{
    // Init dropdown view
    /*if (!self.dropdownView) {
        self.dropdownView = [LMDropdownView dropdownView];
        self.dropdownView.delegate = self;
        
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
        [self.dropdownView showFromNavigationController:self.navigationController withContentView:self.menutable];
        
    }*/
    [self.menutable setFrame:CGRectMake(0, 0, self.view.bounds.size.width,200)];
    [self.menutable reloadData];
    
    // Init dropdown view
    if (!self.dropdownView)
    {
        self.dropdownView = [[LMDropdownView alloc] init];
        self.dropdownView.delegate = self;
        self.dropdownView.contentBackgroundColor = [UIColor colorWithRed:40.0/255 green:196.0/255 blue:80.0/255 alpha:1];
    }
    
    // Show/hide dropdown view
    if ([self.dropdownView isOpen])
    {
        [self.dropdownView hide];
    }
    else
    {
        [self.dropdownView showFromNavigationController:self.navigationController withContentView:self.menutable];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == tableView1){
        return 3;
    }
    else if (tableView == self.menutable){
        return 3;
    }
    return myObject.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UIButton *btn_Bookmark, *btn_Search,*btn_trangChu,*btn_dienDan,*btn_muaBan,*btn_dauGia,*btn_Setting;
    UILabel *lbl_textSize,*lbl_leftA,*lbl_rightA,*lbl_trangChu,*lbl_dienDan,*lbl_muaBan,*lbl_dauGia;
    UIImageView *imgV_Setting,*imgV_Bookmark,*imgV_Search,*imgV_trangChu,*imgV_dienDan,*imgV_muaBan,*imgV_dauGia;
    UIImage *img_Setting,*img_Bookmark,*img_Search,*img_trangChu,*img_dienDan,*img_muaBan,*img_dauGia;
    
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
    }
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *text;
    
    text = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:title]];
    //xu ly hinh
    NSMutableString *images;
    images = [NSMutableString stringWithFormat:@"%@ ",
              [tmpDict objectForKey:username]];
    NSString *str_02;
    str_02 = [images substringWithRange:NSMakeRange(0, 1)];
    //handle image
    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:username]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc]initWithData:data];
    
    cell.label2.text=text;
     cell.label_view.text=text;
    if([str_02 isEqualToString:@"s"]||[str_02 isEqualToString:@"d"]){
        cell.image_view.image=[UIImage imageNamed:@"imageH.png"];
        cell.image2.image=[UIImage imageNamed:@"imageH.png"];
   
    } else{
        
        cell.image_view.image=img;
        cell.image2.image=img;
    }
        if(tableView == tableView1){  // table thong bao
            if(indexPath.row == 0){
                cell.textLabel.text = @"Chi tiết cá nhân";
                cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];

            }
            else  if(indexPath.row == 1) {
                cell.textLabel.text = @"Thông báo";
                cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
                CGRect frm_daugia = CGRectMake(90, 5.0, 20, 20.0);
                lbl_dauGia = [[UILabel alloc] initWithFrame:frm_daugia];
                lbl_dauGia.layer.cornerRadius=10;
                lbl_dauGia.text = @"ádd";
                lbl_dauGia.textColor = [UIColor whiteColor];
                lbl_dauGia.layer.masksToBounds = YES;
                lbl_dauGia.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:9.0];
                lbl_dauGia.backgroundColor = [UIColor colorWithRed:0.043f green:0.318f blue:0.635f alpha:1.00f];
                [cell.contentView addSubview:lbl_dauGia];
            }
            else if(indexPath.row == 2 ){
                cell.textLabel.text = @"Log out";
                cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
            }
        }
    
     else
         if(tableView == self.menutable){
             [cell setBackgroundColor:[UIColor colorWithRed:0.855f green:0.855f blue:0.855f alpha:1]];
             
             if (indexPath.row == 1){
                 
                 //label textsize
                 CGRect frm_textSize = CGRectMake(145, 1.0, 220, 14.0);
                 lbl_textSize = [[UILabel alloc] initWithFrame:frm_textSize];
                 lbl_textSize.text = @"Test size";
                 lbl_textSize.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
                 lbl_textSize.backgroundColor = [UIColor clearColor];
                 [cell.contentView addSubview:lbl_textSize];
                 
                 //label leftA
                 CGRect frm_leftA = CGRectMake(20, 18.0, 220, 14.0);
                 lbl_leftA = [[UILabel alloc] initWithFrame:frm_leftA];
                 lbl_leftA.text = @"A";
                 lbl_leftA.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.0];
                 lbl_leftA.backgroundColor = [UIColor clearColor];
                 [cell.contentView addSubview:lbl_leftA];
                 
                 //label rightA
                 CGRect frm_rightA = CGRectMake(280, 18.0, 220, 14.0);
                 lbl_rightA = [[UILabel alloc] initWithFrame:frm_rightA];
                 lbl_rightA.text = @"A";
                 lbl_rightA.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13.0];
                 lbl_rightA.backgroundColor = [UIColor clearColor];
                 [cell.contentView addSubview:lbl_rightA];
                 
                 
                 //UISlider
                 CGRect frame = CGRectMake(40, 25.0, 230.0, 0.5);
                 UISlider *btn_slider = [[UISlider alloc] initWithFrame:frame];
                 // [btn_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
                 [btn_slider setBackgroundColor:[UIColor clearColor]];
                 btn_slider.minimumValue = 5.0;
                 btn_slider.maximumValue = 100.0;
                 btn_slider.continuous = YES;
                 btn_slider.value = 25;
                 [cell.contentView addSubview:btn_slider];
                 
                 [cell setBackgroundColor:[UIColor colorWithRed:0.855f green:0.855f blue:0.855f alpha:1]];
             }
             else
                 if(indexPath.row ==0){
                     //button setting
                     btn_Setting = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                     btn_Setting.frame = CGRectMake(90, 7.0, 35, 35);
                     imgV_Setting = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_Setting.frame.size.width, btn_Setting.frame.size.height)];
                     [btn_Setting setTitle:@"changed" forState:UIControlStateHighlighted];
                     [btn_Setting addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
                     [btn_Setting addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
                     img_Setting = [UIImage imageNamed:@"setting.png"];
                     [imgV_Setting setImage:img_Setting];
                     [btn_Setting addSubview:imgV_Setting];
                     [cell.contentView addSubview:btn_Setting];
                     
                     //button bookmark
                     btn_Bookmark = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                     btn_Bookmark.frame = CGRectMake(140, 7.0, 35, 35);
                     imgV_Bookmark = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_Bookmark.frame.size.width, btn_Bookmark.frame.size.height)];
                     img_Bookmark = [UIImage imageNamed:@"bookmark.png"];
                     [btn_Bookmark addTarget:self action:@selector(btn_bookmark:) forControlEvents:UIControlEventTouchUpInside];
                     [imgV_Bookmark setImage:img_Bookmark];
                     [btn_Bookmark addSubview:imgV_Bookmark];
                     [cell.contentView addSubview:btn_Bookmark];
                     
                     //button search
                     btn_Search = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                     btn_Search.frame = CGRectMake(200, 7.0, 35, 35);
                     imgV_Search = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_Search.frame.size.width, btn_Search.frame.size.height)];
                     img_Search = [UIImage imageNamed:@"search.png"];
                     [btn_Search addTarget:self action:@selector(btn_Search:) forControlEvents:UIControlEventTouchUpInside];
                     [imgV_Search setImage:img_Search];
                     [btn_Search addSubview:imgV_Search];
                     [cell.contentView addSubview:btn_Search];
                     
                 }
                 else
                     if(indexPath.row == 2){
                         
                         //button trangchu
                         btn_trangChu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                         btn_trangChu.frame = CGRectMake(30, 10, 46, 46);
                         imgV_trangChu= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_trangChu.frame.size.width, btn_trangChu.frame.size.height)];
                         img_trangChu = [UIImage imageNamed:@"abc.jpg"];
                         [btn_trangChu addTarget:self action:@selector(btn_trangChu:) forControlEvents:UIControlEventTouchUpInside];
                         [imgV_trangChu setImage:img_trangChu];
                         imgV_trangChu.layer.cornerRadius=2.5;
                         imgV_trangChu.layer.masksToBounds = YES;
                         [btn_trangChu addSubview:imgV_trangChu];
                         [cell.contentView addSubview:btn_trangChu];
                         
                         
                         //button dienDan
                         /*
                          UIImage *imageForSetting = [UIImage imageNamed:@"Logo.png"];
                          UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
                          settingButton.bounds = CGRectMake(0, 0, 25, 25);
                          [settingButton setImage:imageForSetting forState:UIControlStateNormal];
                          [settingButton addTarget:self action:@selector(settingButton:) forControlEvents:UIControlEventTouchUpInside];
                          
                          
                          */
                         //
                         btn_dienDan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                         btn_dienDan.frame = CGRectMake(100, 10, 46, 46);
                         imgV_dienDan= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_dienDan.frame.size.width, btn_dienDan.frame.size.height)];
                         img_dienDan = [UIImage imageNamed:@"xyz.jpg"];
                         [btn_dienDan addTarget:self action:@selector(btn_dienDan:) forControlEvents:UIControlEventTouchUpInside];
                         [imgV_dienDan setImage:img_dienDan];
                         imgV_dienDan.layer.cornerRadius=2.5;
                         imgV_dienDan.layer.masksToBounds = YES;
                         [btn_dienDan addSubview:imgV_dienDan];
                         [cell.contentView addSubview:btn_dienDan];
                         
                         //
                         
                         
                         //button muaban
                         btn_muaBan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                         btn_muaBan.frame = CGRectMake(170, 10, 46, 46);
                         imgV_muaBan= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_muaBan.frame.size.width, btn_muaBan.frame.size.height)];
                         img_muaBan = [UIImage imageNamed:@"bkl.jpg"];
                         [btn_muaBan addTarget:self action:@selector(btn_muaBan:) forControlEvents:UIControlEventTouchUpInside];
                         [imgV_muaBan setImage:img_muaBan];
                         imgV_muaBan.layer.cornerRadius=2.5;
                         imgV_muaBan.layer.masksToBounds = YES;
                         [btn_muaBan addSubview:imgV_muaBan];
                         [cell.contentView addSubview:btn_muaBan];
                         
                         
                         //button daugia
                         btn_dauGia = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                         btn_dauGia.frame = CGRectMake(250, 10, 46, 46);
                         imgV_dauGia= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_dauGia.frame.size.width, btn_dauGia.frame.size.height)];
                         img_dauGia= [UIImage imageNamed:@"bji.jpg"];
                         [btn_dauGia addTarget:self action:@selector(btn_dauGia:) forControlEvents:UIControlEventTouchUpInside];
                         
                         [imgV_dauGia setImage:img_dauGia];
                         imgV_dauGia.layer.cornerRadius=2.5;
                         imgV_dauGia.layer.masksToBounds = YES;
                         [btn_dauGia addSubview:imgV_dauGia];
                         [cell.contentView addSubview:btn_dauGia];
                         
                         
                         //label trangchu
                         CGRect frm_trangChu = CGRectMake(27, 62.0, 60, 14.0);
                         lbl_trangChu = [[UILabel alloc] initWithFrame:frm_trangChu];
                         lbl_trangChu.text = @"TRANG CHỦ";
                         lbl_trangChu.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:9.0];
                         lbl_trangChu.backgroundColor = [UIColor clearColor];
                         [cell.contentView addSubview:lbl_trangChu];
                         
                         //label diendan
                         CGRect frm_diendan = CGRectMake(100, 62.0, 60, 14.0);
                         lbl_dienDan = [[UILabel alloc] initWithFrame:frm_diendan];
                         lbl_dienDan.text = @"DIỄN ĐÀN";
                         lbl_dienDan.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:9.0];
                         lbl_dienDan.backgroundColor = [UIColor clearColor];
                         [cell.contentView addSubview:lbl_dienDan];
                         
                         //label muaban
                         CGRect frm_muaban = CGRectMake(171, 62.0, 60, 14.0);
                         lbl_muaBan  = [[UILabel alloc] initWithFrame:frm_muaban];
                         lbl_muaBan.text = @"MUA BÁN";
                         lbl_muaBan.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:9.0];
                         lbl_muaBan.backgroundColor = [UIColor clearColor];
                         [cell.contentView addSubview:lbl_muaBan];
                         
                         //label daugia
                         CGRect frm_daugia = CGRectMake(254, 62.0, 60, 14.0);
                         lbl_dauGia = [[UILabel alloc] initWithFrame:frm_daugia];
                         lbl_dauGia.text = @"ĐẤU GIÁ";
                         lbl_dauGia.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:9.0];
                         lbl_dauGia.backgroundColor = [UIColor clearColor];
                         [cell.contentView addSubview:lbl_dauGia];
                         
                         
                     }
         }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.menutable){
        if(indexPath.row == 2){
            return 100.0f;
        }
        return 50.0f;
    }
    if(tableView == tableView1){
        return 30.0f;
    }
    return 150.0f;
}

-(void)settingButton:(id)sender{
  //  [self showDropDownView];
   // NSLog(@"lol mẹ");
  
}
-(void)MenuButton:(id)sender{
   [self performSegueWithIdentifier:@"muaban" sender:self];
}


- (IBAction)btn_Persional:(id)sender {
   
    
    
  
    
}
- (IBAction)buttonHighlight:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    //NSLog(@"Touched Down");
    //btn_Setting.backgroundColor=[UIColor redColor];
}
- (IBAction)buttonNormal:(id)sender{
   // NSLog(@"btnsetting");
    [self performSegueWithIdentifier:@"muaban" sender:self];
    // btn_Setting.backgroundColor=[UIColor grayColor];
}
- (IBAction)btn_trangChu:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    NSLog(@"btntrangchu");
    //btn_Setting.backgroundColor=[UIColor redColor];
}
- (IBAction)btn_dienDan:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    [self performSegueWithIdentifier:@"muaban" sender:self];
   // NSLog(@"btndiendan");
    //btn_Setting.backgroundColor=[UIColor redColor];
}
- (IBAction)btn_dauGia:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    //NSLog(@"btbdaugia");
    [self performSegueWithIdentifier:@"muaban" sender:self];
    //btn_Setting.backgroundColor=[UIColor redColor];
}
- (IBAction)btn_muaBan:(id)sender {   //event chỉnh ẩn hiển của thôg báo
   // NSLog(@"btnmuaban");
    [self performSegueWithIdentifier:@"muaban" sender:self];
    //btn_Setting.backgroundColor=[UIColor redColor]; btn_bookmark
}
- (IBAction)btn_bookmark:(id)sender {   //event chỉnh ẩn hiển của thôg báo
   // NSLog(@"btnbookmark");
    [self performSegueWithIdentifier:@"muaban" sender:self];
    //btn_Setting.backgroundColor=[UIColor redColor]; btn_bookmark
}
- (IBAction)btn_Search:(id)sender {   //event chỉnh ẩn hiển của thôg báo
    NSLog(@"btnsearch"); [self performSegueWithIdentifier:@"muaban" sender:self];
    //btn_Setting.backgroundColor=[UIColor redColor]; btn_bookmark
}

/*- (void)logout{
   [self dismissModalViewControllerAnimated:YES];
    ViewController *detailViewController = [[ViewController alloc] init];
    //detailViewController.activityIndicator =self;
    [detailViewController.activityIndicator stopAnimating];
    
   
}*/
@end
