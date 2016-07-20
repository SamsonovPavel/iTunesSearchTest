//
//  MediaImageValueTransformer.m
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 20.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "MediaImageValueTransformer.h"

@implementation MediaImageValueTransformer

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (nullable id)transformedValue:(nullable id)value
{
    NSData *imageData = UIImagePNGRepresentation(value);
    return imageData;
}

- (nullable id)reverseTransformedValue:(nullable id)value
{
    UIImage *image = [[UIImage alloc] initWithData:value];
    return image;
}

@end
