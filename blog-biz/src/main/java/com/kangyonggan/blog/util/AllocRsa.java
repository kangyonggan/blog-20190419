package com.kangyonggan.blog.util;

import java.util.ArrayList;
import java.util.List;

/**
 * @author kangyonggan
 * @date 4/16/18
 */
public class AllocRsa {

    private static List<List<Double>> resultBaskets = new ArrayList<>();

    /**
     * 问题：一堆苹果N个，重量不一。现在想要把这一堆苹果按照重量相对公平的放到M个篮子里，怎么才能相对公平的分配呢？
     * <p>
     * 思路：何谓相对公平？那就是这M份中的总重量要"尽量接近"，那如何判断"尽量接近"呢？用数学中的标准差，它可以反映组内个体间的离散程度。
     * <p>
     * 算法：遍历所有分配方案，逐一计算标准差，留下标准差最小的分配方案。
     * <p>
     * 优化：遍历所有的分配方案时，时间复杂度太大，怎么过滤掉大部分明细不公平的方案呢？
     *
     * @param args
     */
    public static void main(String[] args) {
        // N个苹果的重量
        int n = 7;
        List<Double> apples = new ArrayList<>(n);
        System.out.println("一共" + n + "个苹果：");
        for (int i = 0; i < n; i++) {
            apples.add(i + 1.0);
            System.out.print(i + 1 + " ");
        }
        System.out.println();

        // M个篮子
        int m = 3;
        List<List<Double>> baskets = new ArrayList<>();
        for (int i = 0; i < m; i++) {
            baskets.add(new ArrayList<>());
        }
        System.out.println("一共" + m + "个篮子");
        System.out.println();
        System.out.println();
        System.out.println("下面是计算日志:");

        // 最小标准差
        double minStandardDeviation = Double.MAX_VALUE;
        System.out.println("初始化标准差:" + minStandardDeviation);

        System.out.println("最终计算所得最小标准差：" + func(apples, baskets, m, minStandardDeviation));
        System.out.println("对应每个篮子苹果分配：");
        for (int i = 0; i < resultBaskets.size(); i++) {
            System.out.print("篮子" + (i + 1) + "：");
            for (int j = 0; j < resultBaskets.get(i).size(); j++) {
                System.out.print(String.format("%.0f ", resultBaskets.get(i).get(j)));
            }
            System.out.println();
        }
    }

    private static Double func(List<Double> apples, List<List<Double>> baskets, int m, double minStandardDeviation) {
        if (apples.isEmpty()) {

            List<Double> basketTotalApples = calcSumApples(baskets);
            Double standardDeviation = calcStandardDeviation(basketTotalApples);
            if (standardDeviation < minStandardDeviation) {
                minStandardDeviation = standardDeviation;
                System.out.println("发现一个更小的标准差:" + minStandardDeviation);
                resultBaskets = new ArrayList<>();
                for (int i = 0; i < baskets.size(); i++) {
                    resultBaskets.add(new ArrayList<>());
                    for (int j = 0; j < baskets.get(i).size(); j++) {
                        resultBaskets.get(i).add(baskets.get(i).get(j));
                    }
                }
            }

            return minStandardDeviation;
        }

        List<List<Double>> copyBaskets = new ArrayList<>(baskets);
        List<Double> copyApples = new ArrayList<>(apples);
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < apples.size(); j++) {
                Double a = apples.get(j);
                copyBaskets.get(i).add(a);
                copyApples.remove(j);
                minStandardDeviation = func(copyApples, copyBaskets, m, minStandardDeviation);
                copyApples.add(j, a);
                copyBaskets.get(i).remove(copyBaskets.get(i).size() - 1);
            }
        }

        return minStandardDeviation;
    }

    /**
     * 计算每组苹果的总重量
     *
     * @param baskets
     * @return
     */
    private static List<Double> calcSumApples(List<List<Double>> baskets) {
        List<Double> result = new ArrayList<>(baskets.size());
        for (int i = 0; i < baskets.size(); i++) {
            result.add(calcSum(baskets.get(i)));
        }

        return result;
    }

    /**
     * 计算标准差
     *
     * @param list
     * @return
     */
    private static double calcStandardDeviation(List<Double> list) {
        double average = calcAverage(list);
        double sum = 0;
        for (int i = 0; i < list.size(); i++) {
            sum += Math.pow((list.get(i) - average), 2);
        }

        return Math.sqrt(sum / list.size());
    }

    /**
     * 计算平均数
     *
     * @param list
     * @return
     */
    private static double calcAverage(List<Double> list) {
        return calcSum(list) / list.size();
    }

    /**
     * 计算总算
     *
     * @param list
     * @return
     */
    private static Double calcSum(List<Double> list) {
        Double sum = 0d;
        for (int i = 0; i < list.size(); i++) {
            sum += list.get(i);
        }

        return sum;
    }

}
