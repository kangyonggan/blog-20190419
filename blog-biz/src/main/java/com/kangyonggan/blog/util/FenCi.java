package com.kangyonggan.blog.util;


import com.huaban.analysis.jieba.JiebaSegmenter;
import com.huaban.analysis.jieba.SegToken;

import java.util.List;

/**
 * @author kangyonggan
 * @date 4/8/18
 */
public class FenCi {
    /**
     * 分词器
     */
    private static final JiebaSegmenter segmenter = new JiebaSegmenter();

    /**
     * 中文分词, 并转成拼音
     *
     * @param data
     * @return
     */
    public static String process(String data) {
        List<SegToken> list = segmenter.process(data, JiebaSegmenter.SegMode.INDEX);
        StringBuilder sb = new StringBuilder();
        list.forEach(segToken -> sb.append(segToken.word.trim()).append(","));
        if (sb.length() > 0) {
            sb.deleteCharAt(sb.lastIndexOf(","));
        }
        return sb.toString();
    }

}
