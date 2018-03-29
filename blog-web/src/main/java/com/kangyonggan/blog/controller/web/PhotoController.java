package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.AttachmentService;
import com.kangyonggan.blog.service.PhotoService;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.blog.vo.Photo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/24/18
 */
@Controller
@RequestMapping("photo")
public class PhotoController extends BaseController {

    @Autowired
    private PhotoService photoService;

    @Autowired
    private AttachmentService attachmentService;

    /**
     * 相册
     *
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index(Model model) {
        List<Photo> photos = photoService.findAllPhotos();

        model.addAttribute("photos", photos);
        return getPathIndex();
    }

    /**
     * 相册详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}", method = RequestMethod.GET)
    public String detail(@PathVariable("id") Long id, Model model) {
        Photo photo = photoService.findPhotoById(id);
        List<Attachment> attachments = attachmentService.findAttachmentsByTypeAndSourceId(AttachmentType.PHOTO.getType(), photo.getId());

        model.addAttribute("photo", photo);
        model.addAttribute("attachments", attachments);
        return getPathDetail();
    }

}
