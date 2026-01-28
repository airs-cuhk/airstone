#include"SDF.h"
float sdf[SIZE][SIZE];

void sdf_create() {
    // 创建SDF矩阵  
    // 生成SDF
    generateSDF(sdf);
}

void compareWithNeighbors(int row, int col,int &rowMax,int &colMax) {
    // 定义八个方向的偏移量
    int directions[8][2] = {
        {-1, -1}, // 左上
        {-1, 0},  // 正上
        {-1, 1},  // 右上
        {0, -1},   // 左
        {0, 1},    // 右
        {1, -1},   // 左下
        {1, 0},    // 正下
        {1, 1}     // 右下
    };

    float currentValue = sdf[row][col];
    //int rowMax,colMax;
    int newRow,newCol;
    rowMax=row;
    colMax=col;
    for (int i = 0; i < 8; i++) {
        newRow = row + directions[i][0];
        newCol = col + directions[i][1];

        // 检查是否越界
        if (newRow >= 0 && newRow < SIZE && newCol >= 0 && newCol < SIZE) {
            float neighborValue = sdf[newRow][newCol];
            if (currentValue < neighborValue) {               
                currentValue=neighborValue;    
                rowMax=newRow;
                colMax=newCol;       
            } else {
                //currentValue=currentValue;
                //rowMax=rowMax;
                //colMax=colMax;
            }
        } else {
                //currentValue=currentValue;
                //rowMax=rowMax;
                //colMax=colMax;
        }
    }
}



void Collision_free(float A[2],float result[2]){ // 该函数的目的是根据当前因子和SDF进行 无碰 的优化
    //int A_int[2];
    int row=A[0];
    int col=A[1];
    // v[2];
    int v[2];
    //int temp0=0,temp1=0;
    compareWithNeighbors(row,col,v[0],v[1]);

    // float v_dire[2];
    result[0]=v[0]-A[0];
    result[1]=v[1]-A[1];
    
}