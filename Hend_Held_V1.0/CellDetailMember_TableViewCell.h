//
//  CellDetailMember_TableViewCell.h
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/4/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDetailMember_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;
@property (weak, nonatomic) IBOutlet UILabel *lbl_userPost;
@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@end
