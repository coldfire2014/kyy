#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "BaiduMobStat.h"
#import "AssetHelper.h"
#import "WXApi.h"
#import "WXApiObject.h"

#define WX_APPID "wx06ea6c3bc82c99ac"
#define WX_SECRET "1e9e5b207389d2959a43ad203f74a6fd"

#define MSG_ALERT "MSG_ALERT"
#define MSG_SET_BADGE "MSG_SET_BADGE"
#define MSG_BACK "MSG_BACK"
#define MSG_SETUP_DESELECT "MSG_SETUP_DESELECT"
#define MSG_MY_SHOW "MSG_MY_SHOW"
#define MSG_IMG_SELECT_SHOW "MSG_IMG_SELECT_SHOW"
#define MSG_IMG_SELECT_HIDE "MSG_IMG_SELECT_HIDE"
#define MSG_IMGS_OK "MSG_IMGS_OK"

#define MSG_BTN_NANE_FOR_LIST "MSG_BTN_NANE_FOR_LIST"
#define MSG_BTN_NANE_FOR_EDIT "MSG_BTN_NANE_FOR_EDIT"

#define MSG_EDIT_HEAD "MSG_EDIT_HEAD"
#define MSG_EDIT_IMGS "MSG_EDIT_IMGS"

#define MSG_BAR_SHOW "MSG_BAR_SHOW"
#define MSG_BAR_HIDE "MSG_BAR_HIDE"
#define MSG_GOBACK_ALL "MSG_GOBACK_ALL"

#define TAG_IMG_ITEM_BTN 201
#define TAG_IMG_ITEM_IMG 202
#define TAG_IMG_ITEM_BTN_GREEN 203
#define TAG_PREIMG_BK 204
#define TAG_PREIMG_BKD 205
#define TAG_PREIMG_IMG 206

#define TAG_BTN_BADGE 10001
#define TAG_BTN_BADGE_NUM 10043

#define TAG_NAV_BK 101
#define TAG_NAV_LBTN 102
#define TAG_NAV_RBTN 103

#define TAG_INPUT_IMG_HEAD 401

#define TAG_ULIST_MAEK 501
#define TAG_ULIST_BK 502

