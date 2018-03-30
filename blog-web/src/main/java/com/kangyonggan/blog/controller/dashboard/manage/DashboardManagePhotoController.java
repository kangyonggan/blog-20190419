package com.kangyonggan.blog.controller.dashboard.manage;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.AttachmentService;
import com.kangyonggan.blog.service.PhotoService;
import com.kangyonggan.blog.util.FileUpload;
import com.kangyonggan.blog.util.ImageUtil;
import com.kangyonggan.blog.util.PropertiesUtil;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.blog.vo.Photo;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("dashboard/manage/photo")
@Log4j2
public class DashboardManagePhotoController extends BaseController {

    @Autowired
    private PhotoService photoService;

    @Autowired
    private AttachmentService attachmentService;

    /**
     * 相册管理
     *
     * @param pageNum
     * @param title
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_PHOTO")
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "title", required = false, defaultValue = "") String title,
                        Model model) {
        List<Photo> photos = photoService.searchPhotos(pageNum, AppConstants.PAGE_SIZE, title);
        PageInfo<Photo> page = new PageInfo(photos);

        model.addAttribute("page", page);
        return getPathList();
    }

    /**
     * 添加相册
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_PHOTO")
    public String create(Model model) {
        model.addAttribute("photo", new Photo());
        return getPathFormModal();
    }

    /**
     * 保存相册
     *
     * @param photo
     * @param result
     * @param file
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_PHOTO")
    public Map<String, Object> save(@ModelAttribute("photo") @Valid Photo photo, BindingResult result,
                                    @RequestParam(value = "file", required = false) MultipartFile file) throws FileUploadException {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            if (file != null && !file.isEmpty()) {
                String fileName = FileUpload.upload(file, "PHOTO");
                photo.setCoverImg(fileName);
            }
            photoService.savePhoto(photo);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 编辑相册
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/edit", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_PHOTO")
    public String edit(@PathVariable("id") Long id, Model model) {
        model.addAttribute("photo", photoService.findPhotoById(id));
        return getPathFormModal();
    }

    /**
     * 更新相册
     *
     * @param photo
     * @param result
     * @param file
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_PHOTO")
    public Map<String, Object> update(@ModelAttribute("photo") @Valid Photo photo, BindingResult result,
                                      @RequestParam(value = "file", required = false) MultipartFile file) throws FileUploadException {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            if (file != null && !file.isEmpty()) {
                String fileName = FileUpload.upload(file, "PHOTO");
                photo.setCoverImg(fileName);
            }
            photoService.updatePhoto(photo);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
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
    @RequiresPermissions("MANAGE_PHOTO")
    public String delete(@PathVariable("id") Long id, @PathVariable("isDeleted") String isDeleted, Model model) {
        Photo photo = photoService.findPhotoById(id);
        photo.setIsDeleted((byte) (isDeleted.equals("delete") ? 1 : 0));
        photoService.updatePhoto(photo);

        model.addAttribute("photo", photo);
        return getPathTableTr();
    }

    /**
     * 物理删除
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/remove", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_PHOTO")
    @ResponseBody
    public Map<String, Object> remove(@PathVariable("id") Long id) {
        photoService.deletePhoto(id);
        return super.getResultMap();
    }

    /**
     * 管理相册
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/manage", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_PHOTO")
    public String manage(@PathVariable("id") Long id, Model model) {
        Photo photo = photoService.findPhotoById(id);
        List<Attachment> attachments = attachmentService.findAttachmentsByTypeAndSourceId(AttachmentType.PHOTO.getType(), id);

        model.addAttribute("photo", photo);
        model.addAttribute("attachments", attachments);
        return getPathRoot() + "/manage";
    }


    /**
     * 上传相册
     *
     * @param id
     * @param file
     * @return
     */
    @RequestMapping(value = "upload", method = RequestMethod.POST)
    @RequiresPermissions("MANAGE_PHOTO")
    @ResponseBody
    public Map<String, Object> upload(@RequestParam("id") Long id, @RequestParam("file") MultipartFile file) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("status", "success");
        try {
            String fileName = FileUpload.upload(file, "PHOTO");
            Attachment attachment = new Attachment();
            attachment.setSourceId(id);
            attachment.setType(AttachmentType.PHOTO.getType());
            attachment.setOriginalFilename(file.getOriginalFilename());
            attachment.setUrl(fileName);

            // 生成缩略图
            ImageUtil.thumbnailImage(PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + fileName, 320, 240);
            attachment.setThumb(AppConstants.FILE_UPLOAD + ImageUtil.DEFAULT_PREVFIX + fileName.substring(7));

            attachmentService.saveAttachment(attachment);
            resultMap.put("fileId", attachment.getId());
        } catch (Exception e) {
            log.error("上传失败", e);
            resultMap.put("status", "fail");
        }

        return resultMap;
    }

    /**
     * 删除相片
     *
     * @param fileId
     * @return
     */
    @RequestMapping(value = "delete", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_PHOTO")
    @ResponseBody
    public Map<String, Object> deleteFile(@RequestParam("fileId") Long fileId) {
        attachmentService.deleteAttachment(fileId);
        return super.getResultMap();
    }

}
