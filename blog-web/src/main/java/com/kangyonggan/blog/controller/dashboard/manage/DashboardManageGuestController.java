package com.kangyonggan.blog.controller.dashboard.manage;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.Status;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.dto.ShiroUser;
import com.kangyonggan.blog.service.GuestService;
import com.kangyonggan.blog.service.MailService;
import com.kangyonggan.blog.service.UserService;
import com.kangyonggan.blog.util.MarkdownUtil;
import com.kangyonggan.blog.vo.Guest;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @date 9/1/17
 */
@Controller
@RequestMapping("dashboard/manage/guest")
public class DashboardManageGuestController extends BaseController {

    @Autowired
    private GuestService guestService;

    @Autowired
    private UserService userService;

    @Autowired
    private MailService mailService;

    /**
     * 留言列表
     *
     * @param pageNum
     * @param status
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_GUEST")
    public String list(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                       @RequestParam(value = "status", required = false, defaultValue = "") String status,
                       Model model) {
        List<Guest> guests = guestService.searchGuest(pageNum, status);
        PageInfo<Guest> page = new PageInfo(guests);

        model.addAttribute("page", page);
        model.addAttribute("statuses", Status.values());
        return getPathList();
    }


    /**
     * 删除/恢复
     *
     * @param id
     * @param isDeleted
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/{isDeleted:\\bundelete\\b|\\bdelete\\b}", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @RequiresPermissions("MANAGE_GUEST")
    public String delete(@PathVariable("id") Long id, @PathVariable("isDeleted") String isDeleted, Model model) {
        Guest guest = guestService.findGuestById(id);
        guest.setIsDeleted((byte) ("delete".equals(isDeleted) ? 1 : 0));
        guestService.updateGuest(guest);

        model.addAttribute("guest", guest);
        return getPathTableTr();
    }

    /**
     * 审核通过/审核不通过
     *
     * @param id
     * @param status
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/{status:\\bCOMPLETE\\b|\\bREJECT\\b|\\bWAITING\\b}", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @RequiresPermissions("MANAGE_GUEST")
    public String status(@PathVariable("id") Long id, @PathVariable("status") String status, Model model) {
        ShiroUser shiroUser = userService.getShiroUser();
        Guest guest = guestService.findGuestById(id);

        guest.setStatus(status);
        guest.setAdjustUsername(shiroUser.getUsername());
        guestService.updateGuest(guest);

        model.addAttribute("guest", guest);
        return getPathTableTr();
    }

    /**
     * 查看详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_GUEST")
    public String detail(@PathVariable("id") Long id, Model model) {
        Guest guest = guestService.findGuestById(id);

        guest.setReplyMessage(MarkdownUtil.markdownToHtml(guest.getReplyMessage()));

        model.addAttribute("guest", guest);
        return getPathDetail();
    }

    /**
     * 物理删除
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/remove", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_GUEST")
    @ResponseBody
    public Map<String, Object> remove(@PathVariable("id") Long id) {
        guestService.deleteGuestById(id);
        return super.getResultMap();
    }

    /**
     * 回复
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/reply", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_GUEST")
    public String reply(@PathVariable("id") Long id, Model model) {
        model.addAttribute("id", id);
        return getPathRoot() + "/reply-modal";
    }

    /**
     * 回复
     *
     * @param id
     * @param replyMessage
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/reply", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_GUEST")
    public Map<String, Object> reply(@PathVariable("id") Long id, @RequestParam("replyMessage") String replyMessage) {
        ShiroUser shiroUser = userService.getShiroUser();

        Guest guest = guestService.findGuestById(id);
        guest.setReplyMessage(replyMessage);
        guest.setReplyUsername(shiroUser.getUsername());

        guestService.updateGuest(guest);

        replyMessage += "\n\n\n\n\n\n---\n\n\n\n快速访问：[https://kangyonggan.com/guest](https://kangyonggan.com/guest)";

        // 发邮件通知
        mailService.send(guest.getEmail(), "康永敢博客的站长回复了您的留言", MarkdownUtil.markdownToHtml(replyMessage) + "<br/><br/><span style='color:#ccc'>（本邮件是系统自动发送，请勿回复该邮件）</span>");

        return getResultMap();
    }

}
