#ifndef _QUIK_COMMON_H_
#define _QUIK_COMMON_H_

#include "stdlib.h"

#if __GNUC__ || _MSC_VER
    #define __QUIK_FUNCTION__ __FUNCTION__
#else
    #define __QUIK_FUNCTION__ NULL
#endif

#if WIN32 || _MSC_VER > 0 || __MINGW__
    #define QEXTERN __declspec(dllexport)
#else
    #define QEXTERN
#endif

/**
 * @brief Callback for failed assert function for QUIK redist libraries.
 * @param[in] expr The expression that failed.
 * @param[in] file The failing file (if available)
 * @param[in] line The failing line number (if available)
 * @param[in] func The failing function (if available)
*/
typedef void (*quik_failed_assert_cb_t)(const char *expr, const char *file, int line, const char* func);

#define DECLARE_ASSERT_CB(NAME) \
    QEXTERN quik_failed_assert_cb_t NAME##_failed_assert
#define DECLARE_ASSERT_STORE(NAME) \
    QEXTERN void NAME##_failed_assert_store(quik_failed_assert_cb_t cb)

#define DEFINE_ASSERT_CB(NAME) \
    quik_failed_assert_cb_t NAME##_failed_assert
#define DEFINE_ASSERT_STORE(NAME) \
    void NAME##_failed_assert_store(quik_failed_assert_cb_t cb) { \
        NAME##_failed_assert = cb != NULL ? cb : quik_default_assert; \
    }

#define QUIK_DECLARE_LIB(NAME) \
    DECLARE_ASSERT_CB(NAME); \
    DECLARE_ASSERT_STORE(NAME);

#define QUIK_DEFINE_LIB(NAME) \
    DEFINE_ASSERT_CB(NAME); \
    DEFINE_ASSERT_STORE(NAME);

inline static void quik_default_assert(const char *expr, const char *file, int line, const char *function)
{
    abort();
}

#endif
