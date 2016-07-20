//
//  ServerRequestManager.m
//  iTunesSearchTest
//
//  Created by Pavel Samsonov on 17.07.16.
//  Copyright © 2016 Pavel Samsonov. All rights reserved.
//

#import "ServerRequestManager.h"
#import "MediaLocation.h"

@interface ServerRequestManager ()

@property (strong, nonatomic) NSString *stringURL;
@property (strong, nonatomic) AFHTTPRequestOperation *requestOperation;

@end

@implementation ServerRequestManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.stringURL = @"https://itunes.apple.com/search?term=";
        NSArray *artistArray = @[@"jack+johnson", @"jack", @"Madonna", @"Selena Gomez", @"Mr. President",
                                 @"Michael Jackson", @"Pink Floyd", @"Britney Spears", @"Rammstein", @"Status Quo"];
        NSString *string = artistArray[arc4random_uniform(10)];
        [self urlRequestWhithString:string];
    }
    return self;
}

- (void)urlRequestWhithString:(NSString *)string
{
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:[self.stringURL stringByAppendingString:string]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    self.requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestOperation.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

- (void)invokedDelegate:(BOOL)param
{
    if (param)
    {
        [self.delegate downloadIsComplete:self];
    }
    else
    {
        [self.delegate downloadFailed:self];
    }
}

- (void)postUsersServerWithString:(NSString *)urlString
                        OnSuccess:(void(^)(NSArray *array))success
                        onFailure:(void(^)(NSError *error, NSInteger statusCode))failure
                          loading:(void(^)(BOOL load))loadParam;
{
    if ([urlString length] != 0)
    {
        [self urlRequestWhithString:urlString];
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self.requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation,
                                                           NSDictionary  *_Nonnull responseObject) {
        
        NSArray *arrayWithServer = [responseObject objectForKey:@"results"];
        NSMutableArray *rezultArray = [NSMutableArray array];
        
        for (NSDictionary *dictionary in arrayWithServer)
        {
            MediaLocation *media = [[MediaLocation alloc] initWithServerResponder:dictionary];
            [rezultArray addObject:media];
        }

        if (success) {
            success(rezultArray);
        }
        
        if (loadParam) {
            loadParam(YES);
            [weakSelf invokedDelegate:YES];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error, operation.response.statusCode);
        }
        
        if (loadParam) {
            loadParam(NO);
            [weakSelf invokedDelegate:NO];
        }
        
    }];
    
    [self.requestOperation start];
}

@end





























