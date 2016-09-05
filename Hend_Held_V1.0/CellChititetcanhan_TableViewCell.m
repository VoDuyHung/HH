//
//  CellChititetcanhan_TableViewCell.m
//  Hend_Held_V1.0
//
//  Created by Toan Nguyen Duc on 10/9/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "CellChititetcanhan_TableViewCell.h"

@implementation CellChititetcanhan_TableViewCell
-(void) setFrame:(CGRect)frame
{
    float inset = 8.0f;
    frame.origin.x += inset;
    frame.size.width -= 2 *inset;
    [super setFrame:frame];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
