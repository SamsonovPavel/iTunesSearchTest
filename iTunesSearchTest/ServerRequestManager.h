//
//  ServerRequestManager.h
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 17.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

@protocol ServerRequestManagerDelegate;

@interface ServerRequestManager : NSObject

@property (weak, nonatomic) id <ServerRequestManagerDelegate> delegate;

- (void)postUsersServerWithString:(NSString *)urlString
                        OnSuccess:(void(^)(NSArray *array))success
                           onFailure:(void(^)(NSError *error, NSInteger statusCode))failure
                             loading:(void(^)(BOOL load))loadParam;

@end

@protocol ServerRequestManagerDelegate

- (void)downloadIsComplete:(ServerRequestManager *)manager;
- (void)downloadFailed:(ServerRequestManager *)manager;

@end

