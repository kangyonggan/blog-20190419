package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.MonitorType;
import com.kangyonggan.blog.constants.Status;
import com.kangyonggan.blog.service.GuestService;
import com.kangyonggan.blog.util.DateUtil;
import com.kangyonggan.blog.util.IPUtil;
import com.kangyonggan.blog.util.MarkdownUtil;
import com.kangyonggan.blog.vo.Guest;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.extra.core.annotation.Monitor;
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
public class GuestBookServiceImpl extends BaseService<Guest> implements GuestService {


    @Override
    public List<Guest> findGuestsByPage(int pageNum) {
        Example example = new Example(Guest.class);
        example.createCriteria().andEqualTo("status", Status.COMPLETE.getStatus())
                .andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, AppConstants.PAGE_SIZE);
        List<Guest> guests = myMapper.selectByExample(example);

        return processGuestsReplyMessage(guests);
    }

    @Override
    @Log
    public boolean isQuickWrite(String ip) {
        Example example = new Example(Guest.class);
        example.createCriteria().andEqualTo("ip", ip).andGreaterThan("createdTime", DateUtil.plusMinutes(-3));

        return myMapper.selectCountByExample(example) > 0;
    }

    @Override
    @Log
    @Monitor(type = MonitorType.INSERT, description = "保存留言${guest.realname}")
    public void saveGuest(Guest guest) {
        guest.setReplyMessage(StringUtils.EMPTY);
        guest.setIpInfo("正在查地址");

        myMapper.insertSelective(guest);
    }

    @Override
    @Log
    public void updateGuestIpInfo(Long id, String ip) {
        new Thread() {
            public void run() {
                Map<String, String> resultMap = IPUtil.getIpInfo(ip);

                String city = resultMap.get("city");
                if (StringUtils.isEmpty(city)) {
                    city = "未知地";
                }
                city += "网友";

                Guest guestbook = new Guest();
                guestbook.setId(id);
                guestbook.setIpInfo(city);
                myMapper.updateByPrimaryKeySelective(guestbook);
                log.info("留言的ip信息查询成功");
            }
        }.start();
    }

    @Override
    public List<Guest> searchGuest(int pageNum, String status) {
        Example example = new Example(Guest.class);

        if (StringUtils.isNotEmpty(status)) {
            example.createCriteria().andEqualTo("status", status);
        }

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, AppConstants.PAGE_SIZE);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    public Guest findGuestById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    @Log
    public void updateGuest(Guest guest) {
        myMapper.updateByPrimaryKeySelective(guest);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.DELETE, description = "删除留言id=${id}")
    public void deleteGuestById(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }

    /**
     * 处理回复信息
     *
     * @param guests
     */
    private List<Guest> processGuestsReplyMessage(List<Guest> guests) {
        for (Guest guest : guests) {
            guest.setReplyMessage(MarkdownUtil.markdownToHtml(guest.getReplyMessage()));
        }
        
        return guests;
    }
}
