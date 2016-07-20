//
//  UIView+UITableViewCell.m
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 21.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import "UIView+UITableViewCell.h"

@implementation UIView (UITableViewCell)

- (UITableViewCell *)superTableViewCell
{
    if (!self.superview) {
        return nil;
    }
    
    if ([self.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell *)self.superview;
    }
    
    return [self.superview superTableViewCell];
}

@end
