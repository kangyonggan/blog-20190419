package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Novel;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
public interface NovelService {

    /**
     * 小说更新标识
     */
    String NOVEL_UPDATE_FLAG = "novel:update:flag";

    /**
     * 错误次数
     */
    int ERR_COUNT = 5;

    /**
     * 笔趣阁地址
     */
    String BI_QU_GE_URL = "http://www.biquge.cn/";

    /**
     * 查找最新的小说代码
     *
     * @return
     */
    Integer findLastNovelCode();

    /**
     * 根据栏目查找小说
     *
     * @param pageNum
     * @param pageSize
     * @param categoryCode
     * @return
     */
    List<Novel> findNovelsByCategory(int pageNum, int pageSize, String categoryCode);

    /**
     * 搜索小说
     *
     * @param pageNum
     * @param pageSize
     * @param code
     * @param name
     * @param author
     * @param categoryCode
     * @return
     */
    List<Novel> searchNovels(int pageNum, int pageSize, String code, String name, String author, String categoryCode);

    /**
     * 查找小说
     *
     * @param code
     * @return
     */
    Novel findNovelByCode(Integer code);

    /**
     * 更新小说
     *
     * @param novel
     */
    void updateNovel(Novel novel);

    /**
     * 删除小说
     *
     * @param code
     */
    void deleteNovel(Integer code);

    /**
     * 从此处开始更新小说
     *
     * @param code
     */
    void updateNovelFromNow(Integer code);

    /**
     * 搜索小说
     *
     * @param key
     * @return
     */
    List<Novel> searchNovels(int pageNum, int pageSize, String key);

    /**
     * 更新小说封面
     */
    void updateNovelCover();

}
