#ifndef BaseMatrix    // 如果没有定义 MY_HEADER_H
#define BaseMatrix    // 定义 MY_HEADER_H



#define N 3
void static matrix_multiply(float A[N][N], float B[N][N], float C[N][N]) {
    // 初始化结果矩阵 C
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            C[i][j] = 0.0;
        }
    }

    // 矩阵乘法
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            for (int k = 0; k < N; ++k) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
};


// 三维矩阵转置函数
void static matrix_transpose(float matrix[N][N],float A[3][3]) {
    float temp;

    // 对角线元素不动，交换非对角线元素
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            // 交换 matrix[i][j] 和 matrix[j][i] 的值
            A[j][i] = matrix[i][j];
            // matrix[i][j] = matrix[j][i];
            // matrix[j][i] = temp;
        }
    }
};

void static matrix_inv(float u[3],float K[3][3]){
    //  K[3][3] = {
    //     { 0, -u[2], u[1] },
    //     { u[2], 0, -u[0] },
    //     { -u[1], u[0], 0 };
        K[0][0]=0;
        K[0][1]=-u[2];
        K[0][2]=u[1];

        K[1][0]=u[2];
        K[1][1]=0;
        K[1][2]=-u[0];

        K[2][0]=-u[1];
        K[2][1]=u[0];
        K[2][2]=0;
    }

void static matrix_vector_muti(float R[3][3],float v[3],float u[3]){
    for(int i=0;i<3;i++){
    u[i]=R[i][0]*v[0]+R[i][1]*v[1]+R[i][2]*v[2];
    
    }
};

void static matrix_scalar_muti(float R[3][3],float u,float T[3][3]){
    for(int i=0;i<3;i++){
        for (int j = 0; j < 3; j++) {
            // 交换 matrix[i][j] 和 matrix[j][i] 的值
            T[i][j] = u*R[i][j];
            // matrix[i][j] = matrix[j][i];
            // matrix[j][i] = temp;
        }    
    }
};

void static matrix_Multiply_34_44(float A[3][4], float B[4][4], float C[3][4]) {
    // 初始化结果矩阵C为0
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 4; ++j) {
            C[i][j] = 0.0f;
        }
    }

    // 执行矩阵乘法
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 4; ++j) {
            for (int k = 0; k < 4; ++k) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
};

void static matrix_Multiply_34_43(float A[3][4], float B[4][3], float C[3][3]) {
    // 初始化结果矩阵C为0
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            C[i][j] = 0.0f;
        }
    }

    // 执行矩阵乘法
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            for (int k = 0; k < 4; ++k) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
};

void static Skew_muti_left(float u[3],float B[3][3],float C[3][3]){
    C[0][0] = -u[2] * B[1][0] + u[1] * B[2][0];
    C[0][1] = -u[2] * B[1][1] + u[1] * B[2][1];
    C[0][2] = -u[2] * B[1][2] + u[1] * B[2][2];
    
    // 第二行
    C[1][0] = u[2] * B[0][0] +  u[0] * B[2][0];
    C[1][1] = u[2] * B[0][1] +  u[0] * B[2][1];
    C[1][2] = u[2] * B[0][2] +  u[0] * B[2][2];
    
    // 第三行
    C[2][0] = -u[1] * B[0][0] + u[0] * B[1][0] ;
    C[2][1] = -u[1] * B[0][1] + u[0] * B[1][1] ;
    C[2][2] = -u[1] * B[0][2] + u[0] * B[1][2] ;
}
void static Skew_muti_right(float A[3][3],float u[3],float C[3][3]){
    C[0][0] = A[0][1] * u[2] + A[0][2] * (-u[1]);
    C[0][1] = A[0][0] * (-u[2]) + A[0][2] * u[0];
    C[0][2] = A[0][0] * u[1] + A[0][1] * (-u[0]);
    
    // 第二行
    C[1][0] = A[1][1] * u[2] + A[1][2] * (-u[1]);
    C[1][1] = A[1][0] * (-u[2]) + A[1][2] * u[0];
    C[1][2] = A[1][0] * u[1] + A[1][1] * (-u[0]);
    
    // 第三行
    C[2][0] = A[2][1] * u[2] + A[2][2] * (-u[1]);
    C[2][1] = A[2][0] * (-u[2]) + A[2][2] * u[0];
    C[2][2] = A[2][0] * u[1] + A[2][1] * (-u[0]);
};

#endif