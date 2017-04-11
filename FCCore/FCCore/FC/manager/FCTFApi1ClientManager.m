//
//  FCTFApi1ClientManager.m
//
//  Created by 周鑫 on 9/14/15.
//  Copyright (c) 2015 HZTeam. All rights reserved.
//

#import "FCTFApi1ClientManager.h"
#import "NSString+SHA.h"
#import <UIKit/UIKit.h>
#import "NotificationKeyHeader.h"
#import "NetworkConfigure.h"
#import "FCLogin.h"
#import "TSSLSocketClient.h"
#import "TCompactProtocol.h"
#import "TSocketClient.h"

static FCTFApi1ClientManager * _sharedTFApi1ClientManager;

@implementation FCTFApi1ClientManager


+ (instancetype)sharedTFApi1Client {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _sharedTFApi1ClientManager = [[FCTFApi1ClientManager alloc] init];
        _sharedTFApi1ClientManager.commonSignature = @"P35HLlPHsNQYlecJCKpSw8dSXCpR1XhlFrqsgj3z09jiBn3DXV9N9hW6ConRBr+x";
        _sharedTFApi1ClientManager.theConnectTimerArray = [NSMutableArray arrayWithCapacity:3];
    });
    
    return _sharedTFApi1ClientManager;
}

+ (NXTFReqHeader *)getHeader:(BOOL)needToken {
    
    NXTFReqHeader *header = [[NXTFReqHeader alloc] init];
    
    UInt64 timestamp = [[NSDate date] timeIntervalSince1970]*1000;
    NSString* nonce = [[FCTFApi1ClientManager sharedTFApi1Client] getNonce];
    NSString *salt = [nonce substringFromIndex:timestamp % 10];
    
    NSString *sKeyandTime = @"";
    if ([FCLogin sharedFCLogin].didSignIn) {
        if (needToken) {
             [header setToken:[FCLogin sharedFCLogin].token];
            sKeyandTime = [NSString stringWithFormat:@"%@%llu%@%@",[FCLogin sharedFCLogin].signingKey,timestamp,nonce,salt];
        } else {
            sKeyandTime = [NSString stringWithFormat:@"%@%llu%@%@",[FCTFApi1ClientManager sharedTFApi1Client].commonSignature,timestamp,nonce,salt];
        }
        if ([FCLogin sharedFCLogin].userId.length>0) {
            [header setUserId:[FCLogin sharedFCLogin].userId.intValue];
        }
    } else {
        sKeyandTime = [NSString stringWithFormat:@"%@%llu%@%@",[FCTFApi1ClientManager sharedTFApi1Client].commonSignature,timestamp,nonce,salt];
    }

    NSString *sha256String = [sKeyandTime sha256];
    
    [header setSignature:sha256String];
    [header setNonce:nonce];
    [header setAppType:2];
    [header setAppVersion:[NetworkConfigure shareConfigure].networkFCAppVersion];
    [header setTimestamp:timestamp];
    [header setDevice:[FCTFApi1ClientManager getDeviceInfos]];
    
    return header;
}

+ (NXTFDevice*)getDeviceInfos {
    
    
    NXTFDevice *tfDevice = [[NXTFDevice alloc] init];
    
    UIDevice *device = [[UIDevice alloc] init];
    
    tfDevice.deviceName = device.model;
    tfDevice.osName = device.systemVersion;
    
    return tfDevice;
    
}


- (NSString*) getNonce {
    
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidString;
    
}

- (NSOperation *)addOperationWithBlock:(void (^)(NSOperation *operation))block queue:(NSOperationQueue*)queue timeout:(CGFloat)timeout timeoutBlock:(void (^)(void))timeoutBlock
{
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    NSBlockOperation __weak *weakOperation = blockOperation;
    
    [blockOperation addExecutionBlock:^{
        block(weakOperation);
    }];
    
    [queue addOperation:blockOperation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (weakOperation && ![weakOperation isFinished]) {
            [weakOperation cancel];
            if (timeoutBlock) {
                timeoutBlock();
            }
        }
    });
    
    return blockOperation;
}


- (void)addToQuene:(NSObject *)req selName:(NSString *)selName success:(void(^)(id content))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    if ([FCTFApi1ClientManager sharedTFApi1Client].asyncQueue == nil) {
        [FCTFApi1ClientManager sharedTFApi1Client].asyncQueue       = [[NSOperationQueue alloc] init];
        [FCTFApi1ClientManager sharedTFApi1Client].asyncQueue.name  = @"common async Queue";
        [FCTFApi1ClientManager sharedTFApi1Client].asyncQueue.maxConcurrentOperationCount = 3;
    }

    __block TSocketClient *tSocketClient = nil;
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addOperationWithBlock:^(NSOperation *operation) {

        @try {
            NSString *networkTFHostname = [NetworkConfigure shareConfigure].networkTFHostname;
            UInt32 networkTFCommonport = [NetworkConfigure shareConfigure].networkTFCommonport;
            tSocketClient = [[TSocketClient alloc] initWithHostname:networkTFHostname port:networkTFCommonport];
            if(tSocketClient == nil) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSError *error = [[NSError alloc] initWithDomain:@"连接超时，请检查网络或稍后再试。" code:-1015 userInfo:nil];
                    failureBlock(error);
                }];
                return;
            }
            TCompactProtocol *protocol = [[TCompactProtocol alloc] initWithTransport:tSocketClient];
            
            NXTFApi1Client *tFApi1Client = [[NXTFApi1Client alloc] initWithProtocol:protocol];
            
            SEL dosel = NSSelectorFromString(selName);
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            if ([tFApi1Client respondsToSelector:dosel]) {
                
                NSObject *resp =  [tFApi1Client performSelector:dosel withObject:req];
                if (resp) {
                    
                    NXTFRespHeader * header = [resp performSelector:@selector(header) withObject:nil];
                    if ([header isKindOfClass:[NXTFRespHeader class]]) {
                        if (header.status == 0) {
                            
                            if (tSocketClient) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                                    successBlock(resp);
                                }];
                            }
                            
                        } else {
                            
                            if (tSocketClient) {
                                if (header.status == -3 || header.status == -4) {
                                    if (header.msg.length == 0) {
                                        header.msg = @"服务器返回错误";
                                    }
                                    NSError *error = [[NSError alloc] initWithDomain:header.msg code:header.status userInfo:nil];
                                    [FCLogin sharedFCLogin].didSignIn    = NO;
                                    [FCLogin sharedFCLogin].token        = @"";
                                    [FCLogin sharedFCLogin].signingKey   = @"";
                                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                                        [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_NXLogoutNotification object:self];
                                        failureBlock(error);
                                    }];
                                } else {
                                    
                                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                                        if (header.msg.length == 0) {
                                            header.msg = @"服务器返回错误";
                                        }
                                        NSError *error = [[NSError alloc] initWithDomain:header.msg code:header.status userInfo:nil];
                                        failureBlock(error);
                                    }];
                                }

                            }
                            
                        }
                    } else {
                        [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                            NSError *error = [[NSError alloc] initWithDomain:@"返回header有错误" code:-6020 userInfo:nil];
                            failureBlock(error);
                        }];
                    }
                } else {
                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                        NSError *error = [[NSError alloc] initWithDomain:@"返回类型错误" code:-6016 userInfo:nil];
                        failureBlock(error);
                    }];
                }
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                    NSError *error = [[NSError alloc] initWithDomain:@"执行请求错误" code:-6017 userInfo:nil];
                    failureBlock(error);
                }];
            }
            
#pragma clang diagnostic pop
            
        }
        @catch (NSException *e) {
            
            if (tSocketClient) {
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                    NSError *error = [[NSError alloc] initWithDomain:@"无法连接到服务器，请检查网络或稍后再试。" code:-1015 userInfo:nil];
                    failureBlock(error);
                }];
            }

        }
        @finally {
            if (tSocketClient) {
                [tSocketClient.mInput close];
                [tSocketClient.mOutput close];
                tSocketClient = nil;
            }
        }
        
    }  queue:[FCTFApi1ClientManager sharedTFApi1Client].asyncQueue timeout:60 timeoutBlock:^{
        
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
            NSError *error = [[NSError alloc] initWithDomain:@"无法连接到服务器，请检查网络或稍后再试。" code:-1015 userInfo:nil];
            failureBlock(error);
        }];
    }];
  
}

- (void) addToSSlQuene:(NSObject *)req selName:(NSString *)selName success:(void(^)(id content))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    if ([FCTFApi1ClientManager sharedTFApi1Client].sslQueue == nil) {
        [FCTFApi1ClientManager sharedTFApi1Client].sslQueue       = [[NSOperationQueue alloc] init];
        [FCTFApi1ClientManager sharedTFApi1Client].sslQueue.name  = @"ssl Queue";
        [FCTFApi1ClientManager sharedTFApi1Client].sslQueue.maxConcurrentOperationCount = 3;
    }
    
    __block TSSLSocketClient *tSSLSocketClient = nil;
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addOperationWithBlock:^(NSOperation *operation) {

        @try {
            
            NSString *networkTFHostname = [NetworkConfigure shareConfigure].networkTFHostname;
            UInt32 networkTFSSLport = [NetworkConfigure shareConfigure].networkTFSSLport;
            tSSLSocketClient = [[TSSLSocketClient alloc] initWithHostname:networkTFHostname port:networkTFSSLport];
            if(tSSLSocketClient == nil) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSError *error = [[NSError alloc] initWithDomain:@"连接超时，请检查网络或稍后再试。" code:-1015 userInfo:nil];
                    failureBlock(error);
                }];
                return;
            }
            TCompactProtocol *protocol = [[TCompactProtocol alloc] initWithTransport:tSSLSocketClient];
            
            NXTFApi1Client *tFApi1Client = [[NXTFApi1Client alloc] initWithProtocol:protocol];

            SEL dosel = NSSelectorFromString(selName);
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            if ([tFApi1Client respondsToSelector:dosel]) {
                
                NSObject *resp =  [tFApi1Client performSelector:dosel withObject:req];
                if ([resp respondsToSelector:@selector(header)]) {
                    NXTFRespHeader * header = [resp performSelector:@selector(header) withObject:nil];
                    if ([header isKindOfClass:[NXTFRespHeader class]]) {
                        if (header.status == 0) {
                            
                            if (tSSLSocketClient) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                                    successBlock(resp);
                                }];
                            }
                            
                        } else {
                            
                            if (tSSLSocketClient) {
                                if (header.status == -3 || header.status == -4) {

                                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                                        if (header.msg.length == 0) {
                                            header.msg = @"服务器返回错误";
                                        }
                                        NSError *error = [[NSError alloc] initWithDomain:header.msg code:header.status userInfo:nil];
                                        [FCLogin sharedFCLogin].didSignIn    = NO;
                                        [FCLogin sharedFCLogin].token        = @"";
                                        [FCLogin sharedFCLogin].signingKey   = @"";
                                        [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_NXLogoutNotification object:self];
                                        failureBlock(error);
                                        
                                    }];
                                } else {
                                    
                                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                                        if (header.msg.length == 0) {
                                            header.msg = @"服务器返回错误";
                                        }
                                        NSError *error = [[NSError alloc] initWithDomain:header.msg code:header.status userInfo:nil];
                                        failureBlock(error);
                                    }];
                                }
                            }
  

                        }
                    } else {
                       
                        [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                            NSError *error = [[NSError alloc] initWithDomain:@"返回类型错误" code:-6014 userInfo:nil];
                                failureBlock(error);
                        }];
                        
                    }
                    
                } else {
                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                        NSError *error = [[NSError alloc] initWithDomain:@"执行错误，请检查网络或稍后再试。" code:-6015 userInfo:nil];
                        failureBlock(error);
                    }];
                }
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                    NSError *error = [[NSError alloc] initWithDomain:@"执行请求错误，请检查网络或稍后再试。" code:-6017 userInfo:nil];
                    failureBlock(error);
                }];
            }
            
#pragma clang diagnostic pop
            
        }
        @catch (NSException *e) {
            
            if (tSSLSocketClient) {
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                    NSError *error = [[NSError alloc] initWithDomain:@"无法连接到服务器，请检查网络或稍后再试。" code:-6018 userInfo:nil];
                    failureBlock(error);
                }];
            }
            
        }
        @finally {
            if(tSSLSocketClient) {
                [tSSLSocketClient.mInput close];
                [tSSLSocketClient.mOutput close];
                tSSLSocketClient = nil;
            }
        }
        
    } queue:[FCTFApi1ClientManager sharedTFApi1Client].asyncQueue timeout:60 timeoutBlock:^{
        
        if(tSSLSocketClient) {
            [tSSLSocketClient.mInput close];
            [tSSLSocketClient.mOutput close];
            tSSLSocketClient = nil;
        }

        [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
            NSError *error = [[NSError alloc] initWithDomain:@"无法连接到服务器，请检查网络或稍后再试。" code:-1015 userInfo:nil];
            failureBlock(error);
        }];
    }];

    
}

- (void)addMsgToQuene:(NSObject *)req selName:(NSString *)selName messageID:(NSString *)messageID success:(void(^)(id content))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    if ([FCTFApi1ClientManager sharedTFApi1Client].filesQueue == nil) {
        [FCTFApi1ClientManager sharedTFApi1Client].filesQueue       = [[NSOperationQueue alloc] init];
        [FCTFApi1ClientManager sharedTFApi1Client].filesQueue.name  = @"common async Queue";
        [FCTFApi1ClientManager sharedTFApi1Client].filesQueue.maxConcurrentOperationCount = 3;
    }
    
    __block TSocketClient *tSocketClient = nil;
    
    [[FCTFApi1ClientManager sharedTFApi1Client] addOperationWithBlock:^(NSOperation *operation) {
        
        @try {
            
            NSString *networkTFHostname = [NetworkConfigure shareConfigure].networkTFHostname;
            UInt32 networkTFCommonport = [NetworkConfigure shareConfigure].networkTFCommonport;
            tSocketClient = [[TSocketClient alloc] initWithHostname:networkTFHostname port:networkTFCommonport];
            if(tSocketClient == nil) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSError *error = [[NSError alloc] initWithDomain:@"连接超时，请检查网络或稍后再试。" code:-1015 userInfo:nil];
                    failureBlock(error);
                }];
                return;
            }
            TCompactProtocol *protocol = [[TCompactProtocol alloc] initWithTransport:tSocketClient];
            
            NXTFApi1Client *tFApi1Client = [[NXTFApi1Client alloc] initWithProtocol:protocol];
            
            SEL dosel = NSSelectorFromString(selName);
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            
            if ([tFApi1Client respondsToSelector:dosel]) {
                
                NSObject *resp =  [tFApi1Client performSelector:dosel withObject:req];
                if (resp) {
                    
                    NXTFRespHeader * header = [resp performSelector:@selector(header) withObject:nil];
                    if ([header isKindOfClass:[NXTFRespHeader class]]) {
                        if (header.status == 0) {
                            
                            if (tSocketClient) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                                    successBlock(resp);
                                }];
                            }
                            
                        } else {
                            
                            if (tSocketClient) {
                                if (header.status == -3 || header.status == -4) {
                                    if (header.msg.length == 0) {
                                        header.msg = @"服务器返回错误";
                                    }
                                    NSError *error = [[NSError alloc] initWithDomain:header.msg code:header.status userInfo:nil];
                                    [FCLogin sharedFCLogin].didSignIn    = NO;
                                    [FCLogin sharedFCLogin].token        = @"";
                                    [FCLogin sharedFCLogin].signingKey   = @"";
                                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                                        [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_NXLogoutNotification object:self];
                                        failureBlock(error);
                                    }];
                                } else {
                                    
                                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                                        NSError *error = [[NSError alloc] initWithDomain:header.msg code:header.status userInfo:nil];
                                        failureBlock(error);
                                    }];
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                } else {
                    [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                        NSError *error = [[NSError alloc] initWithDomain:@"返回类型错误" code:-6016 userInfo:nil];
                        failureBlock(error);
                    }];
                }
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                    NSError *error = [[NSError alloc] initWithDomain:@"执行请求错误" code:-6017 userInfo:nil];
                    failureBlock(error);
                }];
            }
            
#pragma clang diagnostic pop
            
        }
        @catch (NSException *e) {
            
            if (tSocketClient) {
                [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                    NSError *error = [[NSError alloc] initWithDomain:messageID code:-1015 userInfo:nil];
                    failureBlock(error);
                }];
            }
            
        }
        @finally {
            if (tSocketClient) {
                [tSocketClient.mInput close];
                [tSocketClient.mOutput close];
                tSocketClient = nil;
            }
        }
        
    }  queue:[FCTFApi1ClientManager sharedTFApi1Client].filesQueue timeout:120 timeoutBlock:^{
        
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
            NSError *error = [[NSError alloc] initWithDomain:messageID code:-1015 userInfo:nil];
            failureBlock(error);
        }];
    }];
    


}
@end
