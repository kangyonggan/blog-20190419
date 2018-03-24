package com.kangyonggan.blog.controller.web;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.GuestBookService;
import com.kangyonggan.blog.service.MailService;
import com.kangyonggan.blog.util.IPUtil;
import com.kangyonggan.blog.util.PropertiesUtil;
import com.kangyonggan.blog.vo.GuestBook;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author kangyonggan
 * @since 9/1/17
 */
@Controller
@RequestMapping("guestBook")
@Log4j2
public class GuestBookController extends BaseController {

    @Autowired
    private GuestBookService guestBookService;

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
        List<GuestBook> guestBooks = guestBookService.findGuestBooksByPage(pageNum);
        PageInfo<GuestBook> page = new PageInfo(guestBooks);

        model.addAttribute("page", page);
        return getPathIndex();
    }

    /**
     * 保存言板
     *
     * @param guestBook
     * @param result
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    public String save(@ModelAttribute("guestBook") GuestBook guestBook, BindingResult result,
                       HttpServletRequest request, Model model) {
        String respMsg;
        if (result.hasErrors()) {
            respMsg = "表单错误";
        } else {
            // 访问量控制
            String ip = IPUtil.getIp(request);
            boolean isQuickWrite = guestBookService.isQuickWrite(ip);
            if (!isQuickWrite) {
                guestBook.setIp(ip);
                guestBookService.saveGuestBook(guestBook);

                log.info("异步查询ip信息，查回后更新");
                guestBookService.updateGuestBookIpInfo(guestBook.getId(), ip);

                // 发邮件通知站长
                mailService.send(PropertiesUtil.getProperties("mail.receiver"), "康永敢的博客 - 收到 " + guestBook.getRealname() + " 的留言信息，请及时审核。", guestBook.getContent() + "<br/><br/>留言审核：<a href='https://kangyonggan.com/dashboard#manage/guestBook'>https://kangyonggan.com/dashboard#manage/guestBook</a>");

                respMsg = "留言成功，待审核通过之后会展示于下面留言板。";
            } else {
                respMsg = "您的留言太过频繁，请于三分钟后再来留言！";
            }
        }

        model.addAttribute(AppConstants.RESP_MSG, respMsg);
        return getPathIndex();
    }

}
