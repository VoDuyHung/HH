//
//  RefreshContrlCollection.m
//  Hand Held
//
//  Created by Toan Nguyen Duc on 12/16/15.
//  Copyright (c) 2015 Toan Nguyen Duc. All rights reserved.
//

#import "RefreshContrlCollection.h"

@implementation RefreshContrlCollection


- (void)beginRefreshing {
    // Only do this super view is a collection view
    if ([[self superview] isKindOfClass:[UICollectionView class]]) {
        UICollectionView * superCollectionView = (UICollectionView *)[self superview];
    } else {
        [super beginRefreshing];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
}
@end
