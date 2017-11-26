//
//  KWNetworkController.m
//
//
//  Created by Kevin on 2016/12/5.
//  Copyright © 2016年 Kevin. All rights reserved.
//

#import "KWNetworkController.h"
#import <AFHTTPSessionManager.h>
#import "KWNetworkConstants.h"


@interface KWNetworkController()
{
    AFHTTPSessionManager    *sessionManager;
}

@end

@implementation KWNetworkController



+ (KWNetworkController *)sharedController{
    static KWNetworkController *controller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    return controller;
    
}

- (instancetype)init {
    if (self = [super init]) {
        
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer.timeoutInterval = 15;
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes  =[NSSet setWithObject:@"application/json"];
        
        //sessionManager.securityPolicy = securityPolicy;
        
      //  [sessionManager setSecurityPolicy:[self customSecurityPolicy]];
        
    }
    return self;
}



- (AFSecurityPolicy*)customSecurityPolicy

{
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"af" ofType:@"cer"];
    
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *cerSet = [[NSSet alloc] initWithObjects:certData, nil];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    securityPolicy.allowInvalidCertificates = YES;
    
    
    securityPolicy.validatesDomainName = NO;
    
    //securityPolicy.pinnedCertificates = @[certData];
    [securityPolicy setPinnedCertificates:cerSet];
    
    return securityPolicy;
    
}

#pragma mark -- Cancel Operation
- (void)cancelAllOperations
{
    [sessionManager.operationQueue cancelAllOperations];
}


#pragma mark -- Utilites

+ (NSDateFormatter *)dateApiRequiredFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'";
    NSTimeZone *utc = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    [dateFormatter setTimeZone:utc];
    return dateFormatter;
}

- (void)printHTTPUrlWithBaseUrl:(NSString *)url
                     parameters:(NSDictionary *)parameters {
    NSString *httpUrl = nil;
    NSString *dicKey = nil;
    for (int i = 0; i < [[parameters allKeys] count]; i++) {
        httpUrl = i == 0 ? @"?" : [httpUrl stringByAppendingString:@"&"];
        
        dicKey = [parameters allKeys][i];
        httpUrl = [httpUrl stringByAppendingFormat:@"%@=%@", dicKey, parameters[dicKey]];
    }
    httpUrl = [url stringByAppendingString:httpUrl];
    
//    DLog(@"\n-----------------[HTTP Url]-----------------\n%@\
//         \n--------------------------------------------", httpUrl);
}

- (NSData*)printAndConvertToJSONFormat:(NSDictionary*)dataDic
{
    NSData* jsonData;
    if ([NSJSONSerialization isValidJSONObject:dataDic]) {
        NSError *err;
        NSString *jsonString = nil;
        jsonData  = [NSJSONSerialization dataWithJSONObject:dataDic options:NSJSONWritingPrettyPrinted error:&err];
        
        if (! jsonData) {
           // DLog(@"Got an error: %@", err);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
       // DLog(@"\n%@",jsonString);
    }
    
    return jsonData;
}
#pragma mark -- Session Base Post Method
- (void)sendPostRequestParameter:(id)parameters
                             url:(NSString*)url
                         success:(void (^)(id data))succ
                         failure:(void (^)(id data))fail
{
    void (^success)(NSURLSessionDataTask *task, id responseObject) = ^(NSURLSessionDataTask *task, id responseObject)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == kHTTPStatusSuccess&&[[responseObject valueForKey:@"success"] isEqualToString:@"1"]) {
            if (succ) {
                succ(responseObject);
            }
        }else
        {
            if (fail) {
                fail(responseObject);
            }
            
            [self printAndConvertToJSONFormat:responseObject];
            NSLog(@"Received HTTP %ld", (long)httpResponse.statusCode);
        }
        
    };
    
    void (^failure)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error)
    {
        if (fail) {
            fail([task response]);
        }
    };
    
  //  DLog(@"----------------------Begin-------------\n%@",url);
    
    [self printAndConvertToJSONFormat:parameters];
    
  //  DLog(@"----------------------End---------------");
    
    [sessionManager POST:url
              parameters:parameters
                progress:nil
                 success:success
                 failure:failure];
    
}

- (NSString*)getUrlWithMethod:(NSString*)method
{
    
    return [NSString stringWithFormat:@"%@%@",kBaseUrl,method];
}







#pragma mark ----------------------------------------APIs ------------------------------------
#pragma mark -- FinanceRate
- (void)getFinanceRateWithSuccess:(void (^)(id data))succ
                          Failure:(void (^)(id data))fail

{
    NSString *url = [self getUrlWithMethod:kRate];
    
    NSDictionary *requestDic = @{
                                 
                                 };
    
    [self sendPostRequestParameter:requestDic
                               url:url
                           success:succ
                           failure:fail];
}















@end
