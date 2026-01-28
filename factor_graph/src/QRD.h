#ifndef HLS_QRD
#define HLS_QRD
//#include <ap_int.h>
//#include <hls_math.h>
#include<math.h>
#define A_ROW 42 // 4 12
#define A_COL 30 // 2 12

constexpr int N = A_ROW * (A_ROW + 1) / 2;

// void QRD(
//     float A[A_ROW][A_COL]);

class Partial_QRD
{
public:
    void X_mod()
    {
#pragma HLS INLINE off
#pragma HLS ARRAY_PARTITION variable = A complete dim = 1
        x_mod2 = 0;
    loop_xmod:
        for (int i = 0; i < A_ROW; i++)
        {
#pragma HLS PIPELINE
            if (i >= c)
                x_mod2 += A[i][c] * A[i][c];
        }
        //x_mod = hls::sqrtf(x_mod2);
        x_mod = sqrtf(x_mod2);
        u_mod2 = x_mod2 - 2 * A[c][c] * x_mod + x_mod2;
    }

    void constructP()
    {
#pragma HLS ARRAY_PARTITION variable = P complete dim = 1

    loop_constructP_outer:
        for (int i = 0; i < A_ROW; i++)
        {
#pragma HLS PIPELINE
        loop_constructP_inner:
            for (int j = 0; j < A_ROW; j++)
            {
//#pragma HLS LOOP_FLATTEN off
                
                if (i < c || j < c || i < j)
                    continue;
                float Ai = i == c ? A[i][c] - x_mod : A[i][c];
                float Aj = j == c ? A[j][c] - x_mod : A[j][c];
                float tmp = 2 * Ai * Aj / u_mod2; // 2w * wt
                P[i * (i + 1) / 2 + j] = i == j ? 1 - tmp : -tmp;
            }
        }
    }

    void updateA()
    {
        // A[c][c] = x_mod;
        float tmp, multi;
    loop_updateA_outer:
        for (int j = 1; j < A_COL; j++)
        {
        loop_updateA_middle:
            for (int i = 0; i < A_ROW; i++)
            {
//#pragma HLS LOOP_FLATTEN off
#pragma HLS PIPELINE
            loop_updateA_inner:
                for (int k = 0; k < A_ROW; k++)
                {
                    if (i < c || j < c + 1 || k < c){
                        continue;
                    }

                    if (k == c){
                        tmp = 0;
                    } 

                    multi = i >= k ? P[i * (i + 1) / 2 + k] * A[k][j] : P[k * (k + 1) / 2 + i] * A[k][j];

                    tmp = tmp+multi;

                    if (k == A_ROW - 1){
                        A_tmp[i][j] = tmp;
                    }
                    
                }
                // if (i == A_ROW - 1)
                // loop_outputA:
                //     for (int m = 0; m < A_ROW; m++)
                //     {
                //         if (m < c || j < c + 1)
                //             continue;
                //         A[m][j] = A_tmp[m];
                //     }
            }
        }
    }

    void outputA()
    {
        //#pragma HLS PIPELINE
        A[c][c] = x_mod;
    loop_outputA_outer:
        for (int i = 0; i < A_ROW; i++)
        {
#pragma HLS UNROLL
        loop_outputA_inner:
            for (int j = 0; j < A_COL; j++)
            {
#pragma HLS UNROLL
                if (i >= c && j >= c + 1&& A_tmp[i][j]==A_tmp[i][j]){
                    A[i][j] = A_tmp[i][j];
                    }
                //else{
                //    A[i][j]=0;
                //}
                if(j==c&&i>c){
                    A[i][j] = 0;
                }
            }
        }
    }

    void updated()
    {
        float tmp, multi;
    loop_updated_outer:
        for (int i = 0; i < A_ROW; i++)
        {
#pragma HLS PIPELINE

        loop_updated_inner:
            for (int k = 0; k < A_ROW; k++)
            {

                if (i < c || k < c)
                    continue;

                if (k == c)
                    tmp = 0;
                else if (k == A_ROW - 1)
                    d_tmp[i] = tmp;
                else
                {
                    multi = i >= k ? P[i * (i + 1) / 2 + k] * d[k] : P[k * (k + 1) / 2 + i] * d[k];
                    tmp += multi;
                }
            }
        }
    }

    void outputd()
    {
    loop_outputd:
        for (int i = 0; i < A_ROW; i++)
        {
#pragma HLS UNROLL

            if (i >= c&& d_tmp[i]==d_tmp[i])
                d[i] = d_tmp[i];
        }
    }

    float A[A_ROW][A_COL];
    float A_tmp[A_ROW][A_COL];
    float P[N];
    float x_mod;
    float x_mod2;
    float u_mod2;
    float d[A_ROW];
    float d_tmp[A_ROW];
    //ap_uint<3> c;
    int c;
};

// Partial_QRD pqrd;
void QRD();

#endif
