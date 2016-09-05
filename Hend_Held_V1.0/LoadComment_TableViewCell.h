//
//  LoadComment_TableViewCell.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/24/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadComment_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIImageView *img_time;
@property (weak, nonatomic) IBOutlet UIImageView *img_like;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_comment;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UILabel *lbl_like;
@end
