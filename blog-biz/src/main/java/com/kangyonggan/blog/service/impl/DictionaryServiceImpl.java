package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.MonitorType;
import com.kangyonggan.blog.service.DictionaryService;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Dictionary;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.extra.core.annotation.Monitor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author kangyonggan
 * @date 3/24/18
 */
@Service
public class DictionaryServiceImpl extends BaseService<Dictionary> implements DictionaryService {

    @Override
    @Log
    public List<Dictionary> searchDictionaries(int pageNum, String type, String value) {
        Example example = new Example(Dictionary.class);
        Example.Criteria criteria = example.createCriteria();

        if (StringUtils.isNotEmpty(type)) {
            criteria.andEqualTo("type", type);
        }

        if (StringUtils.isNotEmpty(value)) {
            criteria.andLike("value", StringUtil.toLikeString(value));
        }

        example.setOrderByClause("type desc, sort asc");

        PageHelper.startPage(pageNum, AppConstants.PAGE_SIZE);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    @Cache(key = "dictionary:id:${id}")
    public Dictionary findDictionaryById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.UPDATE, description = "更新字典${dictionary.code}")
    @CacheDel(key = {"dictionary:id:${dictionary.id}", "dictionary:type*"})
    public void updateDictionary(Dictionary dictionary) {
        myMapper.updateByPrimaryKeySelective(dictionary);
    }

    @Override
    @Log
    @CacheDel(key = "dictionary:type*")
    @Monitor(type = MonitorType.INSERT, description = "保存字典${dictionary.code}")
    public void saveDictionary(Dictionary dictionary) {
        myMapper.insertSelective(dictionary);
    }

    @Override
    @Log
    @Cache(key = "dictionary:type:${type}")
    public List<Dictionary> findDictionariesByType(String type) {
        Example example = new Example(Dictionary.class);
        example.createCriteria().andEqualTo("type", type).andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        example.setOrderByClause("sort asc");
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    @Cache(key = "dictionary:type:${type}:code:${code}")
    public Dictionary findDictionaryByTypeAndCode(String type, String code) {
        Dictionary dictionary = new Dictionary();
        dictionary.setType(type);
        dictionary.setCode(code);
        dictionary.setIsDeleted(AppConstants.IS_DELETED_NO);

        return myMapper.selectOne(dictionary);
    }

    @Override
    @Log
    @CacheDel(key = {"dictionary:id:${id}", "dictionary:type*"})
    @Monitor(type = MonitorType.DELETE, description = "删除字典id=${id}")
    public void deleteDictionaryById(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }
}
