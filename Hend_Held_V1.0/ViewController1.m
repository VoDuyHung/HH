//
//  ViewController1.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/2/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "ViewController1.h"
#import "LMDropdownView.h"
#import "TableViewCell.h"
@interface ViewController1 ()<UITableViewDelegate, UITableViewDataSource,LMDropdownViewDelegate >
@property (strong, nonatomic) IBOutlet UITableView *menuTable;
@property (strong, nonatomic) LMDropdownView *dropdownView;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.menuTable setFrame:CGRectMake(0,
                                            0,
                                            CGRectGetWidth(self.view.bounds),
                                        MIN(CGRectGetHeight(self.view.bounds)/2,  200))];
    
}

     - (void)showDropDownView
    {
        // Init dropdown view
        if (!self.dropdownView) {
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
            [self.dropdownView showFromNavigationController:self.navigationController withContentView:self.menuTable];
            
        }
        
    }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UIButton *btn_Bookmark, *btn_Search,*btn_trangChu,*btn_dienDan,*btn_muaBan,*btn_dauGia,*btn_Setting;
        UILabel *lbl_textSize,*lbl_leftA,*lbl_rightA,*lbl_trangChu,*lbl_dienDan,*lbl_muaBan,*lbl_dauGia;
        UIImageView *imgV_Setting,*imgV_Bookmark,*imgV_Search,*imgV_trangChu,*imgV_dienDan,*imgV_muaBan,*imgV_dauGia;
        UIImage *img_Setting,*img_Bookmark,*img_Search,*img_trangChu,*img_dienDan,*img_muaBan,*img_dauGia;
        
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
        if (!cell) {
            cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];
        }
        
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
             //   [btn_Setting addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
             //   [btn_Setting addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
                img_Setting = [UIImage imageNamed:@"setting.png"];
                [imgV_Setting setImage:img_Setting];
                [btn_Setting addSubview:imgV_Setting];
                [cell.contentView addSubview:btn_Setting];
                
                //button bookmark
                btn_Bookmark = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn_Bookmark.frame = CGRectMake(140, 7.0, 35, 35);
                imgV_Bookmark = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_Bookmark.frame.size.width, btn_Bookmark.frame.size.height)];
                img_Bookmark = [UIImage imageNamed:@"bookmark.png"];
              //  [btn_Bookmark addTarget:self action:@selector(btn_bookmark:) forControlEvents:UIControlEventTouchUpInside];
                [imgV_Bookmark setImage:img_Bookmark];
                [btn_Bookmark addSubview:imgV_Bookmark];
                [cell.contentView addSubview:btn_Bookmark];
                
                //button search
                btn_Search = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn_Search.frame = CGRectMake(200, 7.0, 35, 35);
                imgV_Search = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_Search.frame.size.width, btn_Search.frame.size.height)];
                img_Search = [UIImage imageNamed:@"search.png"];
             //   [btn_Search addTarget:self action:@selector(btn_Search:) forControlEvents:UIControlEventTouchUpInside];
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
               //     [btn_trangChu addTarget:self action:@selector(btn_trangChu:) forControlEvents:UIControlEventTouchUpInside];
                    [imgV_trangChu setImage:img_trangChu];
                    imgV_trangChu.layer.cornerRadius=2.5;
                    imgV_trangChu.layer.masksToBounds = YES;
                    [btn_trangChu addSubview:imgV_trangChu];
                    [cell.contentView addSubview:btn_trangChu];
                    
                    
                    //button dienDan
                    btn_dienDan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    btn_dienDan.frame = CGRectMake(100, 10, 46, 46);
                    imgV_dienDan= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_dienDan.frame.size.width, btn_dienDan.frame.size.height)];
                    img_dienDan = [UIImage imageNamed:@"xyz.jpg"];
                //    [btn_dienDan addTarget:self action:@selector(btn_dienDan:) forControlEvents:UIControlEventTouchUpInside];
                    [imgV_dienDan setImage:img_dienDan];
                    imgV_dienDan.layer.cornerRadius=2.5;
                    imgV_dienDan.layer.masksToBounds = YES;
                    [btn_dienDan addSubview:imgV_dienDan];
                    [cell.contentView addSubview:btn_dienDan];
                    
                    
                    //button muaban
                    btn_muaBan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    btn_muaBan.frame = CGRectMake(170, 10, 46, 46);
                    imgV_muaBan= [[UIImageView alloc] initWithFrame:CGRectMake(0,0,btn_muaBan.frame.size.width, btn_muaBan.frame.size.height)];
                    img_muaBan = [UIImage imageNamed:@"bkl.jpg"];
                 //   [btn_muaBan addTarget:self action:@selector(btn_muaBan:) forControlEvents:UIControlEventTouchUpInside];
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
                //    [btn_dauGia addTarget:self action:@selector(btn_dauGia:) forControlEvents:UIControlEventTouchUpInside];
                    
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
        return cell;
    }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{   //event chiều cao của dòng
        if(indexPath.row == 2){
            return 100.0f;
        }
        return 50.0f;
}
- (IBAction)button1:(id)sender {
    [self showDropDownView];
    NSLog(@"Setting Button");
}
@end
