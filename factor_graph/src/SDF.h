#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define SIZE 100

// 生成SDF矩阵
void generateSDF(float sdf[SIZE][SIZE]) {
    // 遍历矩阵的每个点
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            // 检查当前点是否在障碍物区域内
            if (i >= SIZE / 2 - 1 && i <= SIZE / 2 + 1 && j >= SIZE / 2 - 1 && j <= SIZE / 2 + 1) {
                sdf[i][j] = -1.0; // 障碍物内的点
            } else {
                // 计算到最近障碍物的距离
                float distance = sqrt(pow(i - SIZE / 2.0, 2) + pow(j - SIZE / 2.0, 2));
                sdf[i][j] = distance; // 将距离存入SDF
            }
        }
    }
}




