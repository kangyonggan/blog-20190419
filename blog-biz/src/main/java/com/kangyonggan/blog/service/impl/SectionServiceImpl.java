package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.service.SectionService;
import com.kangyonggan.blog.vo.Section;
import com.kangyonggan.extra.core.annotation.Log;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
@Service
public class SectionServiceImpl extends BaseService<Section> implements SectionService {

    @Override
    @Log
    public Section findLastSectionByNovelCode(Integer code) {
        Example example = new Example(Section.class);
        example.createCriteria().andEqualTo("novelCode", code);
        example.setOrderByClause("code desc");

        PageHelper.startPage(1, 1);
        List<Section> sections = myMapper.selectByExample(example);
        if (sections.isEmpty()) {
            return null;
        }
        return sections.get(0);
    }

    @Override
    public List<Section> findSectionsByNovelCode(int pageNum, int pageSize, Integer code) {
        Example example = new Example(Section.class);
        example.createCriteria().andEqualTo("code", code).andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        example.setOrderByClause("id desc");
        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }
}
