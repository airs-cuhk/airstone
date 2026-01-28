#include "QRD.h"


Partial_QRD pqrd;


void QRD()
{
#pragma HLS INLINE recursive
#pragma HLS PIPELINE
//#pragma HLS DATAFLOW
//#pragma HLS INTERFACE port = pqrd.A
//#pragma HLS INTERFACE port = pqrd.d
//#pragma HLS ARRAY_PARTITION variable=pqrd.A complete dim = 1
//#pragma HLS ARRAY_PARTITION variable=pqrd.A complete dim = 2
//#pragma HLS ARRAY_PARTITION variable=pqrd.P complete dim=1
//#pragma HLS ARRAY_PARTITION variable=pqrd.A_tmp complete dim=1
//#pragma HLS ARRAY_PARTITION variable=pqrd.A_tmp complete dim=2
//#pragma HLS ARRAY_PARTITION variable=pqrd.d complete dim=1
//#pragma HLS ARRAY_PARTITION variable=pqrd.d_tmp complete dim=1
#pragma HLS INTERFACE mode=bram port=pqrd.A
#pragma HLS INTERFACE mode=bram port=pqrd.d


    for (pqrd.c = 0; pqrd.c < A_COL/2; pqrd.c++) //部分QR分解
    {
    
#pragma HLS LOOP_TRIPCOUNT min = 7 max = 7
        pqrd.X_mod();
        pqrd.constructP();
        pqrd.updateA();
        pqrd.outputA();
        pqrd.updated();
        pqrd.outputd();
        
    }
}

//void ConstructP()
//{
//#pragma HLS INTERFACE port=pqrd.A
//#pragma HLS INTERFACE port=pqrd.P
//#pragma HLS ARRAY_PARTITION variable=pqrd.A complete dim = 1
//#pragma HLS ARRAY_PARTITION variable=pqrd.A complete dim = 2
//#pragma HLS ARRAY_PARTITION variable=pqrd.P complete dim=1
//
//    for (pqrd.c = 0; pqrd.c < 7; pqrd.c++)
//    {
//#pragma HLS LOOP_TRIPCOUNT min = 7 max = 7
//        pqrd.constructP();
//    }
//}
//
//void updateA()
//{
//#pragma HLS INTERFACE port=pqrd.A
//#pragma HLS INTERFACE port=pqrd.A_tmp
//#pragma HLS ARRAY_PARTITION variable=pqrd.A complete dim = 1
//#pragma HLS ARRAY_PARTITION variable=pqrd.A complete dim = 2
//#pragma HLS ARRAY_PARTITION variable=pqrd.P complete dim=1
//#pragma HLS ARRAY_PARTITION variable=pqrd.A_tmp complete dim=1
//    for (pqrd.c = 0; pqrd.c < 7; pqrd.c++)
//    {
//#pragma HLS LOOP_TRIPCOUNT min = 7 max = 7
//        pqrd.updateA();
//    }
//}

// void outputA()
// {
// #pragma HLS INTERFACE port=pqrd.A_tmp
// #pragma HLS INTERFACE port=pqrd.A
// #pragma HLS ARRAY_PARTITION variable=pqrd.A complete dim = 1
// #pragma HLS ARRAY_PARTITION variable=pqrd.A complete dim = 2
// #pragma HLS ARRAY_PARTITION variable=pqrd.A_tmp complete dim=1
// #pragma HLS ARRAY_PARTITION variable=pqrd.A_tmp complete dim=2
//     for (pqrd.c = 0; pqrd.c < 7; pqrd.c++)
//     {
// #pragma HLS LOOP_TRIPCOUNT min = 7 max = 7
//         pqrd.outputA();
//     }
// }
