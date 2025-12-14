//
//  ModuleLoader.m
//  MiniPubSub
//
//  Created by sangmin park on 12/14/25.
//

#import <Foundation/Foundation.h>
#import "ModuleLoader.h"

@interface ModuleLoader(){
    NSMutableDictionary* _plugins;
}
-(instancetype)init;
@end

@implementation ModuleLoader

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static ModuleLoader* instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[ModuleLoader alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if(self){
        _plugins = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)load:(const char *)className {
    NSString* nsClassName = [[NSString alloc] initWithUTF8String:className];
    
    if( [_plugins objectForKey:nsClassName] ){
        return;
    }
    Class newClass = NSClassFromString(nsClassName);
    if(newClass == nil){
        return;
    }
    
    id newInstance = [[newClass alloc] init];
    if(newInstance == nil){
        return;
    }
    [_plugins setObject:newInstance forKey:nsClassName];
}

@end
