//#pragma once


#define R_ROW 60 //8 21
//extern #define R_ROW 84;
void static backsub(
    float R[R_ROW][R_ROW],
    //const float T[R_ROW][R_ROW],
    float d[R_ROW],
    float x[R_ROW]
    //const float x_[R_ROW]
    ){
#pragma HLS ARRAY_PARTITION variable = x complete dim = 1
#pragma HLS ARRAY_PARTITION variable = R complete dim = 2
#pragma HLS ARRAY_PARTITION variable = T complete dim = 2
#pragma HLS ARRAY_PARTITION variable = x_ complete dim = 1
    for (int i = R_ROW - 1; i >= 0; i--)
    {
#pragma HLS DEPENDENCE variable = x intra false
#pragma HLS PIPELINE II=1 rewind
        

        x[i]=d[i];
        for (int j = i + 1; j < R_ROW; j++) {
            x[i] -= R[i][j] * x[j];
        }
        x[i] /= R[i][i];
    }
}

