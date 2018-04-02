package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.AttachmentService;
import com.kangyonggan.blog.service.PhotoService;
import com.kangyonggan.blog.util.ImageUtil;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.blog.vo.Photo;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.util.List;

/**
 * @author kangyonggan
 * @date 3/24/18
 */
@Controller
@RequestMapping("photo")
@Log4j2
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

    /**
     * 生成缩略图
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "thumb", method = RequestMethod.GET)
    @ResponseBody
    public String genThumb() throws Exception {
        File dir = new File("/home/hxzq/data/blog/upload");
        File[] files = dir.listFiles();

        for (File file : files) {
            String fileName = file.getName();
            if (fileName.contains("寸") || fileName.contains("戴安娜") || fileName.startsWith("IMG_9")) {
                ImageUtil.thumbnailImage(file.getPath(), 320, 240);
                log.info("gen thumb: {}", file.getPath());
            }
        }

        return "ok";
    }

}
