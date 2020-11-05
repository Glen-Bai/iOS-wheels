//
//  iWUIMacro.h
//  iOSWheels
//
//  Created by autohome on 2020/11/5.
//  Copyright © 2020 baigang. All rights reserved.
//

// 一个项目内的页面UI风格应该是相同的，即 颜色，字体，字号，等基本固定几个值，所以，可以提出一个宏来作为专门的配置文件
// 当然也可以同时一个工具类来实现

#ifndef iWUIMacro_h
#define iWUIMacro_h

// 示例
#define kFont(s) ([UIFont fontWithName:@"HelveticaNeue-Light" size:s])
#define kBFont(s) ([UIFont fontWithName:@"HelveticaNeue-Bold" size:s])

#define kTitleFont (kBFont(17))
#define kSubTitleFont (kFont(15))
#define kContentFont (kFont(14))


#endif /* iWUIMacro_h */
