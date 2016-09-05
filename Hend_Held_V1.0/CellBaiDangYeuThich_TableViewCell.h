//
//  CellBaiDangYeuThich_TableViewCell.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/5/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellBaiDangYeuThich_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_Post;
@property (weak, nonatomic) IBOutlet UILabel *lbl_tittle;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UIWebView *img_load;

@end
