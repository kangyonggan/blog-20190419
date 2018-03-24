package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Dictionary;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/24/18
 */
public interface DictionaryService {

    /**
     * 搜索字典
     *
     * @param pageNum
     * @param type
     * @param value
     * @return
     */
    List<Dictionary> searchDictionaries(int pageNum, String type, String value);

    /**
     * 查找字典
     *
     * @param id
     * @return
     */
    Dictionary findDictionaryById(Long id);

    /**
     * 更新字典
     *
     * @param dictionary
     */
    void updateDictionary(Dictionary dictionary);

    /**
     * 保存字典
     *
     * @param dictionary
     */
    void saveDictionary(Dictionary dictionary);

    /**
     * 查找一类字典
     *
     * @param type
     * @return
     */
    List<Dictionary> findDictionariesByType(String type);

    /**
     * 查找字典
     *
     * @param type
     * @param code
     * @return
     */
    Dictionary findDictionaryByTypeAndCode(String type, String code);

    /**
     * 删除字典
     *
     * @param id
     */
    void deleteDictionaryById(Long id);

}


