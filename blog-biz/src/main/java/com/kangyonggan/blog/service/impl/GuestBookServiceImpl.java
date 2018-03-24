package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.Status;
import com.kangyonggan.blog.service.GuestBookService;
import com.kangyonggan.blog.util.DateUtil;
import com.kangyonggan.blog.util.IPUtil;
import com.kangyonggan.blog.util.MarkdownUtil;
import com.kangyonggan.blog.vo.GuestBook;
import com.kangyonggan.extra.core.annotation.Log;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @since 3/24/18
 */
@Service
@Log4j2
public class GuestBookServiceImpl extends BaseService<GuestBook> implements GuestBookService {


    @Override
    public List<GuestBook> findGuestBooksByPage(int pageNum) {
        Example example = new Example(GuestBook.class);
        example.createCriteria().andEqualTo("status", Status.COMPLETE.getStatus())
                .andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, AppConstants.PAGE_SIZE);
        List<GuestBook> guestBooks = myMapper.selectByExample(example);

        return processGuestbBooksReplyMessage(guestBooks);
    }

    @Override
    @Log
    public boolean isQuickWrite(String ip) {
        Example example = new Example(GuestBook.class);
        example.createCriteria().andEqualTo("ip", ip).andGreaterThan("createdTime", DateUtil.plusMinutes(-3));

        return myMapper.selectCountByExample(example) > 0;
    }

    @Override
    @Log
    public void saveGuestBook(GuestBook guestBook) {
        guestBook.setReplyMessage(StringUtils.EMPTY);
        guestBook.setIpInfo("正在查地址");

        myMapper.insertSelective(guestBook);
    }

    @Override
    @Log
    public void updateGuestBookIpInfo(Long id, String ip) {
        new Thread() {
            public void run() {
                Map<String, String> resultMap = IPUtil.getIpInfo(ip);

                String city = resultMap.get("city");
                if (StringUtils.isEmpty(city)) {
                    city = "未知地";
                }
                city += "网友";

                GuestBook guestbook = new GuestBook();
                guestbook.setId(id);
                guestbook.setIpInfo(city);
                myMapper.updateByPrimaryKeySelective(guestbook);
                log.info("留言的ip信息查询成功");
            }
        }.start();
    }

    /**
     * 处理回复信息
     *
     * @param guestBooks
     */
    private List<GuestBook> processGuestbBooksReplyMessage(List<GuestBook> guestBooks) {
        for (GuestBook guestBook : guestBooks) {
            guestBook.setReplyMessage(MarkdownUtil.markdownToHtml(guestBook.getReplyMessage()));
        }
        
        return guestBooks;
    }
}
