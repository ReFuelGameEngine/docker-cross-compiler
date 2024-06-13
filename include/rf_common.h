#ifndef _REFUEL_COMMON_H_
#define _REFUEL_COMMON_H_

#include "stdlib.h"
#include "stdio.h"

#if __GNUC__ || _MSC_VER
    #define __REFUEL_FUNCTION__ __FUNCTION__
#else
    #define __REFUEL_FUNCTION__ NULL
#endif

#if WIN32 || _MSC_VER > 0 || __MINGW__
    #define RFEXTERN __declspec(dllexport)
#else
    #define RFEXTERN
#endif

/**
 * @brief Callback for failed assert function for QUIK redist libraries.
 * @param[in] expr The expression that failed.
 * @param[in] file The failing file (if available)
 * @param[in] line The failing line number (if available)
 * @param[in] func The failing function (if available)
*/
typedef void (*rf_failed_assert_cb_t)(const char *expr, const char *file, int line, const char* func);

#define DECLARE_ASSERT_CB(NAME) \
    RFEXTERN rf_failed_assert_cb_t NAME##_failed_assert
#define DECLARE_ASSERT_STORE(NAME) \
    RFEXTERN void NAME##_failed_assert_store(rf_failed_assert_cb_t cb)

#define DEFINE_ASSERT_CB(NAME) \
    rf_failed_assert_cb_t NAME##_failed_assert
#define DEFINE_ASSERT_STORE(NAME) \
    void NAME##_failed_assert_store(rf_failed_assert_cb_t cb) { \
        NAME##_failed_assert = cb != NULL ? cb : rf_default_assert; \
    }

#define REFUEL_DECLARE_LIB(NAME) \
    DECLARE_ASSERT_CB(NAME); \
    DECLARE_ASSERT_STORE(NAME);

#define REFUEL_DEFINE_LIB(NAME) \
    DEFINE_ASSERT_CB(NAME); \
    DEFINE_ASSERT_STORE(NAME);

inline static void rf_default_assert(const char *expr, const char *file, int line, const char *function)
{
    fprintf(stderr, "Assert failed at %s:%d in %s()\n    %s", file, line, function, expr);
    abort();
}

#endif
