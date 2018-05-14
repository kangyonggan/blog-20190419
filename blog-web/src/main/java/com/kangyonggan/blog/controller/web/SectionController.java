package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.service.SectionService;
import com.kangyonggan.blog.vo.Section;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author kangyonggan
 * @since 5/14/18
 */
@RestController
@RequestMapping("section")
public class SectionController {

    @Autowired
    private SectionService sectionService;

    @RequestMapping(value = "detail", method = RequestMethod.GET)
    @ResponseBody
    @CrossOrigin("*")
    public Section detail(@RequestParam("code") Integer code) {
        return sectionService.findSectionByCode(code);
    }

    @RequestMapping(value = "prev", method = RequestMethod.GET)
    @ResponseBody
    @CrossOrigin("*")
    public Section prev(@RequestParam("code") Integer code) {
        Section section = sectionService.findSectionByCode(code);
        section = sectionService.findPrevSectionByCode(section.getNovelCode(), section.getCode());
        if (section == null) {
            return null;
        }
        return sectionService.findSectionByCode(section.getCode());
    }

    @RequestMapping(value = "next", method = RequestMethod.GET)
    @ResponseBody
    @CrossOrigin("*")
    public Section next(@RequestParam("code") Integer code) {
        Section section = sectionService.findSectionByCode(code);
        section = sectionService.findNextSectionByCode(section.getNovelCode(), section.getCode());
        if (section == null) {
            return null;
        }
        return sectionService.findSectionByCode(section.getCode());
    }

}
