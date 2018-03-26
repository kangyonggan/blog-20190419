package com.kangyonggan.blog.controller.mobile;

import com.kangyonggan.blog.constants.Resp;
import com.kangyonggan.blog.dto.response.NovelsResponse;
import com.kangyonggan.blog.service.NovelService;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Novel;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author kangyonggan
 * @since 8/15/17
 */
@RestController
@RequestMapping("mobile/novel")
@Log4j2
public class MobileNovelController {

    @Autowired
    private NovelService novelService;

    /**
     * 搜索小说
     *
     * @param key
     * @return
     */
    @RequestMapping(value = "search", method = RequestMethod.POST)
    public NovelsResponse search(@RequestParam("key") String key) {
        key = StringUtil.decode(key);

        NovelsResponse response = new NovelsResponse();

        try {
            List<Novel> novels = novelService.searchNovels(key);

            response.setNovels(novels);
            response.setRespCo(Resp.SUCCESS.getRespCo());
            response.setRespMsg(Resp.SUCCESS.getRespMsg());
        } catch (Exception e) {
            log.warn("搜索小说异常", e);
            response.setRespCo(Resp.FAILURE.getRespCo());
            response.setRespMsg(Resp.FAILURE.getRespMsg());
        }

        return response;
    }

    /**
     * 查找某分类的小说
     *
     * @param pageNum
     * @param categoryCode
     * @return
     */
    @RequestMapping(value = "category", method = RequestMethod.POST)
    public NovelsResponse category(@RequestParam(value = "pageNum", required = false, defaultValue = "1") int pageNum,
                                   @RequestParam("categoryCode") String categoryCode) {
        NovelsResponse response = new NovelsResponse();

        try {
            List<Novel> novels = novelService.findNovelsByCategory(pageNum, 100, categoryCode);

            response.setNovels(novels);
            response.setRespCo(Resp.SUCCESS.getRespCo());
            response.setRespMsg(Resp.SUCCESS.getRespMsg());
        } catch (Exception e) {
            log.warn("查找某分类的小说异常", e);
            response.setRespCo(Resp.FAILURE.getRespCo());
            response.setRespMsg(Resp.FAILURE.getRespMsg());
        }

        return response;
    }
}
