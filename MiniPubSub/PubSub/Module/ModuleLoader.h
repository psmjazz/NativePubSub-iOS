//
//  ModuleLoader.h
//  MiniPubSub
//
//  Created by sangmin park on 12/14/25.
//

#ifndef ModuleLoader_h
#define ModuleLoader_h

@interface ModuleLoader : NSObject
+ (instancetype)shared;
- (void)load:(const chart *)className;

@end

#endif /* ModuleLoader_h */
