package com.kangyonggan.blog.controller.web;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.GuestService;
import com.kangyonggan.blog.service.MailService;
import com.kangyonggan.blog.util.IPUtil;
import com.kangyonggan.blog.util.PropertiesUtil;
import com.kangyonggan.blog.vo.Guest;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @since 9/1/17
 */
@Controller
@RequestMapping("guest")
@Log4j2
public class GuestController extends BaseController {

    @Autowired
    private GuestService guestService;

    @Autowired
    private MailService mailService;

    /**
     * 留言板
     *
     * @param pageNum
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        Model model) {
        List<Guest> guests = guestService.findGuestsByPage(pageNum);
        PageInfo<Guest> page = new PageInfo(guests);

        model.addAttribute("page", page);
        return getPathIndex();
    }

    /**
     * 保存言板
     *
     * @param guest
     * @param result
     * @param request
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> save(@ModelAttribute("guest") Guest guest, BindingResult result,
                                    HttpServletRequest request) {
        Map<String, Object> resultMap = getResultMap();

        if (result.hasErrors()) {
            setResultMapFailure(resultMap, "表单错误");
        } else {
            // 访问量控制
            String ip = IPUtil.getIp(request);
            boolean isQuickWrite = guestService.isQuickWrite(ip);
            if (!isQuickWrite) {
                guest.setIp(ip);
                guestService.saveGuest(guest);

                log.info("异步查询ip信息，查回后更新");
                guestService.updateGuestIpInfo(guest.getId(), ip);

                // 发邮件通知站长
                mailService.send(PropertiesUtil.getProperties("mail.receiver"), "康永敢的博客 - 收到 " + guest.getRealname() + " 的留言信息，请及时审核。", guest.getContent() + "<br/><br/>留言审核：<a href='https://kangyonggan.com/dashboard#manage/guest'>https://kangyonggan.com/dashboard#manage/guest</a>");

                resultMap.put(AppConstants.RESP_MSG, "留言成功，待审核通过之后会展示于下面留言板。");
            } else {
                setResultMapFailure(resultMap, "您的留言太过频繁，请于三分钟后再来留言！");
            }
        }

        return resultMap;
    }

}
