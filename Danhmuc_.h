//
//  Danhmuc_.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/16/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Danhmuc_ : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userPost;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UIWebView *img_load;
@property (weak, nonatomic) IBOutlet UILabel *lbl_lagesize;
@property (weak, nonatomic) IBOutlet UILabel *lbl_changeSize;



@end
