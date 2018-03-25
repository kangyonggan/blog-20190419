package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Novel;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
public interface NovelService {

    /**
     * 错误次数
     */
    int ERR_COUNT = 5;

    /**
     * 笔趣阁地址
     */
    String BI_QU_GE_URL = "http://www.biquge.cn/";

    /**
     * 更新小说
     */
    void updateNovels();

    /**
     * 查找小说
     *
     * @param pageNum
     * @param pageSize
     * @param categoryCode
     * @return
     */
    List<Novel> findNovelsByCategory(int pageNum, int pageSize, String categoryCode);
}
