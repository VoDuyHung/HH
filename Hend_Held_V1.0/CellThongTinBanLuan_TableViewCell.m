//
//  CellThongTinBanLuan_TableViewCell.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 11/3/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "CellThongTinBanLuan_TableViewCell.h"

@implementation CellThongTinBanLuan_TableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void) setFrame:(CGRect)frame
{
    float inset = 8.0f;
    frame.origin.x += inset;
    frame.size.width -= 2 *inset;
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
