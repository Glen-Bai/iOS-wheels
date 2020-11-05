//
//  GBThreadMacro.h
//  iOSWheels
//
//  Created by autohome on 2020/11/5.
//  Copyright © 2020 Glen. All rights reserved.
//

#ifndef GBThreadMacro_h
#define GBThreadMacro_h

#define gb_dispatch_main_sync_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_sync(dispatch_get_main_queue(), block);\
    }

#define gb_dispatch_main_async_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }



#endif /* GBThreadMacro_h */
