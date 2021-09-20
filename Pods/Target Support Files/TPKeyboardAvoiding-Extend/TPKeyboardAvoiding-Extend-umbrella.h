#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TPKeyboardAvoidingCollectionView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "TPKeyboardAvoidingTableView.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"

FOUNDATION_EXPORT double TPKeyboardAvoiding_ExtendVersionNumber;
FOUNDATION_EXPORT const unsigned char TPKeyboardAvoiding_ExtendVersionString[];

