package com.kangyonggan.blog.util;

import lombok.extern.log4j.Log4j2;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;

/**
 * @author kangyonggan
 * @date 3/30/18
 */
@Log4j2
public class ImageUtil {

    public static final String DEFAULT_PREVFIX = "THUMB_";
    private static final boolean DEFAULT_FORCE = false;
    private static final String SUFFIX_SPLIT = ".";

    /**
     * 依据图片路径生成缩略图
     *
     * @param imagePath 原图片路径
     * @param w         缩略图宽
     * @param h         缩略图高
     */
    public static void thumbnailImage(String imagePath, int w, int h) {
        File imgFile = new File(imagePath);
        if (imgFile.exists()) {
            try {
                // ImageIO 支持的图片类型 : [BMP, bmp, jpg, JPG, wbmp, jpeg, png, PNG, JPEG, WBMP, GIF, gif]
                String types = Arrays.toString(ImageIO.getReaderFormatNames());
                String suffix = null;
                // 获取图片后缀
                if (imgFile.getName().indexOf(SUFFIX_SPLIT) > -1) {
                    suffix = imgFile.getName().substring(imgFile.getName().lastIndexOf(SUFFIX_SPLIT) + 1);
                }// 类型和图片后缀所有小写，然后推断后缀是否合法
                if (suffix == null || types.toLowerCase().indexOf(suffix.toLowerCase()) < 0) {
                    log.error("Sorry, the image suffix is illegal. the standard image suffix is {}.", types);
                    return;
                }
                log.debug("target image's size, width:{}, height:{}.", w, h);
                Image img = ImageIO.read(imgFile);
                if (!DEFAULT_FORCE) {
                    // 依据原图与要求的缩略图比例，找到最合适的缩略图比例
                    int width = img.getWidth(null);
                    int height = img.getHeight(null);
                    if ((width * 1.0) / w < (height * 1.0) / h) {
                        if (width > w) {
                            h = Integer.parseInt(new java.text.DecimalFormat("0").format(height * w / (width * 1.0)));
                            log.debug("change image's height, width:{}, height:{}.", w, h);
                        }
                    } else {
                        if (height > h) {
                            w = Integer.parseInt(new java.text.DecimalFormat("0").format(width * h / (height * 1.0)));
                            log.debug("change image's width, width:{}, height:{}.", w, h);
                        }
                    }
                }
                BufferedImage bi = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
                Graphics g = bi.getGraphics();
                g.drawImage(img, 0, 0, w, h, Color.LIGHT_GRAY, null);
                g.dispose();
                String p = imgFile.getPath();
                // 将图片保存在原文件夹并加上前缀
                ImageIO.write(bi, suffix, new File(p.substring(0, p.lastIndexOf(File.separator)) + File.separator + DEFAULT_PREVFIX + imgFile.getName()));
                log.debug("缩略图在原路径下生成成功");
            } catch (IOException e) {
                log.error("generate thumbnail image failed.", e);
            }
        } else {
            log.warn("the image is not exist.");
        }
    }
}
