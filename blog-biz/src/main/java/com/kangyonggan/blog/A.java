package com.kangyonggan.blog;

import java.util.HashSet;
import java.util.Set;

/**
 * @author kangyonggan
 * @since 5/9/18
 */
public class A {

    public static void main(String[] args) {
        Set<String> aaa = new HashSet<>();
        aaa.add("001");
        aaa.add("001");
        aaa.add("001");

        System.out.println(aaa.size());
    }

}
