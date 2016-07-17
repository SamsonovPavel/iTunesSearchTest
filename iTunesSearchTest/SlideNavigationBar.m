//
//  SlideNavigationBar.m
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 16.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import "SlideNavigationBar.h"

@implementation SlideNavigationBar

/*
// Only ove0rride drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeNavigationBar = [super sizeThatFits:size];
    sizeNavigationBar.height = 65;
    
    return sizeNavigationBar;
}

@end
