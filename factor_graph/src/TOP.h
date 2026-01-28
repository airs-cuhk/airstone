#define NUM 4


#include "QRD.h"
#include "BaseMatrix.h"
#include "backsub.h"
#include "RotationTrans.h"

#include "Collision_free.h"
#include "InitialMatrix.h"
#include "SDF.h"
#include "Smooth.h"

void top(float x[NUM][16],
        float ee[NUM-1][7],
        float ee_IMU[NUM-1][10],
        float delta_t,
        float prior[7],
        float result[NUM][7],
        int iter,
        float res,
        int algorithm);

