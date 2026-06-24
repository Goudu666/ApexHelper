package com.apex.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * 日期工具类，负责把 Timestamp 格式化成页面可读文本。
 */
public class DateUtil {
    /**
     * 格式化数据库时间。
     */
    public static String format(Timestamp timestamp) {
        if (timestamp == null) {
            return "";
        }
        return new SimpleDateFormat("yyyy-MM-dd HH:mm").format(timestamp);
    }
}
