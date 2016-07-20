//
//  MediaLocation.h
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 17.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import "UIKit/UIKit.h"
#import <Foundation/Foundation.h>

@interface MediaLocation : NSObject

@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) NSString *collectionName;
@property (strong, nonatomic) NSString *trackName;
@property (assign, nonatomic) CGFloat collectionPrice;
@property (assign, nonatomic) CGFloat trackPrice;
@property (strong, nonatomic) NSString *releaseDate;
@property (strong, nonatomic) NSString *primaryGenreName;
@property (assign, nonatomic) NSInteger trackCount;
@property (strong, nonatomic) UIImage *artworkUrl100;

- (id)initWithServerResponder:(NSDictionary *)responderDictionary;

@end
