//
//  TrangChuReusableView.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/7/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrangChuReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *imageTrangchu2;
@property (weak, nonatomic) IBOutlet UILabel *labelTrangChu2;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userMain;
@property (weak, nonatomic) IBOutlet UILabel *lbl_datemain;
@property (weak, nonatomic) IBOutlet UIWebView *img_MainPage;
@property (weak, nonatomic) IBOutlet UILabel *lbl_tittlemainPage;
@property (weak, nonatomic) IBOutlet UILabel *lbl_temp;

@end
