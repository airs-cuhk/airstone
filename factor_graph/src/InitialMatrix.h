#define N 3
#include<math.h>
void static InitialZero(float A[N][N]){
    for(int i=0;i<N;i++){
        for(int j=0;j<N;j++){
            A[i][j]=0;
        }
    }
}

void static InitialUnit(float A[N][N]){
    A[0][0]=1;
    A[0][1]=0;
    A[0][2]=0;

    A[1][0]=0;
    A[1][1]=1;
    A[1][2]=0;

    A[2][0]=0;
    A[2][1]=0;
    A[2][2]=1;
}

void static DiagSqrt(float A[N][N],float B[N][N]){
    for(int i=0;i<N;i++){
        B[i][i]=sqrt(A[i][i]);
    }
}

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

void static DiagValue(float A[N][N],float x,float y,float z){
    A[0][0]=x;
    A[1][1]=y;
    A[2][2]=z;    
}