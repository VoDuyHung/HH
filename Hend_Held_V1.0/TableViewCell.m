//
//  TableViewCell.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/9/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
