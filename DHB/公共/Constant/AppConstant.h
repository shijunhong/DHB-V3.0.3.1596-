/*!
 @header      AppConstant.h
 @abstract    阿商信息技术有限公司
 @author      玄健
 @version     15/10/14
 */

#pragma mark -
#pragma mark 首页

#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

#define NSLog_Blue(fmt, ...)   NSLog((XCODE_COLORS_ESCAPE @"fg20,221,255;" fmt XCODE_COLORS_RESET),##__VA_ARGS__);
#define NSLog_Red(fmt, ...)   NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" fmt XCODE_COLORS_RESET),##__VA_ARGS__);
# define DLog(fmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" @"[文件名:%s]/n" "[函数名:%s]/n" "[行号:%d]/n" fmt XCODE_COLORS_RESET), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);


//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.width-350)?NO:YES)
#define Multiple SCREEN_WIDTH/375

/***********************Begin:默认的视图参数设置***************************/
#define TabBar_HEIGHT 49.0f ///(TabBar的高度)
#define Titel_HEIGHT 64.0f ///(导航栏高度)
#define DEFAULT_BUTTON_HEIGHT 45.0f ///(默认大按钮的高度)
#define DEFAULT_LINE_HEIGHT 0.5f ///(默认分割线的高度)
#define DEFAULT_SECTION_HEIGHT 8.0f ///(默认TableView的section的高度)
/***********************End:默认的视图参数设置****************************/

#define FREE_ACCOUNT_SKEY @"00796a2e531674257dbd2e7b585b2d85"

#define AMapKEY @"823ce4320a1e6fe3c386a1326cd0f3c5"

#define UMengKEY @"55f7c85667e58e47680002ba"

#define LOCAL_DATABASE @"LOCAL_DATABASE"