//
//  MediaLocation.m
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 17.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import "MediaLocation.h"

@implementation MediaLocation

- (id)initWithServerResponder:(NSDictionary *)responderDictionary;
{
    self = [super init];
    if (self)
    {
        self.artistName = [responderDictionary objectForKey:@"artistName"];
        self.collectionName = [responderDictionary objectForKey:@"collectionName"];
        self.trackName = [responderDictionary objectForKey:@"trackName"];
        
        NSString *collection = [responderDictionary objectForKey:@"collectionPrice"];
        self.collectionPrice = [collection floatValue];
        
        NSString *track = [responderDictionary objectForKey:@"trackPrice"];
        self.trackPrice = [track floatValue];
        
        self.releaseDate = [responderDictionary objectForKey:@"releaseDate"];
        self.primaryGenreName = [responderDictionary objectForKey:@"primaryGenreName"];
        
        NSString *integer = [responderDictionary objectForKey:@"trackCount"];
        self.trackCount = [integer integerValue];
        
        NSString *imageURL = [responderDictionary objectForKey:@"artworkUrl100"];
        NSURL *url = [NSURL URLWithString:imageURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        self.artworkUrl100 = [UIImage imageWithData:data];
    }
    return self;
}

@end