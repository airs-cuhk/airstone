#include<math.h>

struct AxisAngle
{
    float x,y,z;
};
typedef struct {
    float w, x, y, z;
} Quaternion;

void static QtoR(Quaternion *q, float R[3][3]) {
    float w = q->w, x = q->x, y = q->y, z = q->z;

    // 计算旋转矩阵的元素
    R[0][0] = 1 - 2 * (y * y + z * z);
    R[0][1] = 2 * (x * y - w * z);
    R[0][2] = 2 * (x * z + w * y);
    
    R[1][0] = 2 * (x * y + w * z);
    R[1][1] = 1 - 2 * (x * x + z * z);
    R[1][2] = 2 * (y * z - w * x);
    
    R[2][0] = 2 * (x * z - w * y);
    R[2][1] = 2 * (y * z + w * x);
    R[2][2] = 1 - 2 * (x * x + y * y);
}

void static RtoQ(float R[3][3], Quaternion *q) {
    float trace = R[0][0] + R[1][1] + R[2][2];

    if (trace > 0) {
        float s = 0.5 / sqrt(trace + 1.0);
        // float s = 0.5 / hls::sqrtf(trace + 1.0);
        q->w = 0.25 / s;
        q->x = (R[2][1] - R[1][2]) * s;
        q->y = (R[0][2] - R[2][0]) * s;
        q->z = (R[1][0] - R[0][1]) * s;
    } else {
        if (R[0][0] > R[1][1] && R[0][0] > R[2][2]) {
            float s = 2.0 * sqrt(1.0 + R[0][0] - R[1][1] - R[2][2]);
            //float s = 2.0 * hls::sqrtf(1.0 + R[0][0] - R[1][1] - R[2][2]);
            q->w = (R[2][1] - R[1][2]) / s;
            q->x = 0.25 * s;
            q->y = (R[0][1] + R[1][0]) / s;
            q->z = (R[0][2] + R[2][0]) / s;
        } else if (R[1][1] > R[2][2]) {
            float s = 2.0 * sqrt(1.0 + R[1][1] - R[0][0] - R[2][2]);
            //float s = 2.0 * sqrt(1.0 + R[1][1] - R[0][0] - R[2][2]);
            q->w = (R[0][2] - R[2][0]) / s;
            q->x = (R[0][1] + R[1][0]) / s;
            q->y = 0.25 * s;
            q->z = (R[1][2] + R[2][1]) / s;
        } else {
            float s = 2.0 * sqrt(1.0 + R[2][2] - R[0][0] - R[1][1]);
            //float s = 2.0 * sqrt(1.0 + R[2][2] - R[0][0] - R[1][1]);
            q->w = (R[1][0] - R[0][1]) / s;
            q->x = (R[0][2] + R[2][0]) / s;
            q->y = (R[1][2] + R[2][1]) / s;
            q->z = 0.25 * s;
        }
    }
}


void static RtoA(float R[3][3],AxisAngle *rv){
    float trace = R[0][0] + R[1][1] + R[2][2];
    float theta = acos((trace - 1) / 2.0);

    if (theta > 1e-6) {
        float sin_theta = sin(theta);
        rv->x = (R[2][1] - R[1][2]) / (2 * sin_theta);
        rv->y = (R[0][2] - R[2][0]) / (2 * sin_theta);
        rv->z = (R[1][0] - R[0][1]) / (2 * sin_theta);

        // 将旋转轴方向的单位向量乘以旋转角度得到旋转向量
        rv->x *= theta;
        rv->y *= theta;
        rv->z *= theta;
    } else {
        // 处理旋转角度接近 0 的特殊情况
        rv->x = 0;
        rv->y = 0;
        rv->z = 0;
    }
}


void static AtoR(AxisAngle *r, float R[3][3]) 
    {
    // 计算旋转角度 theta 和单位旋转轴向量 (ux, uy, uz)
    float theta = sqrt(r->x * r->x +
                        r->y * r->y +
                        r->z * r->z);
    //float theta = hls::sqrtf(r->x * r->x +
    //                    r->y * r->y +
    //                    r->z * r->z);

    if (theta == 0) {
        // 若 theta 为 0，表示没有旋转，返回单位矩阵
        R[0][0] = R[1][1] = R[2][2] = 1.0;
        R[0][1] = R[0][2] = R[1][0] = R[1][2] = R[2][0] = R[2][1] = 0.0;
        return;
    }

    float ux = r->x / theta;
    float uy = r->y / theta;
    float uz = r->z / theta;

    // 计算旋转矩阵的分量
    float cos_theta = cos(theta);
    float sin_theta = sin(theta);
    float one_minus_cos = 1.0 - cos_theta;

    R[0][0] = cos_theta + ux * ux * one_minus_cos;
    R[0][1] = ux * uy * one_minus_cos - uz * sin_theta;
    R[0][2] = ux * uz * one_minus_cos + uy * sin_theta;

    R[1][0] = uy * ux * one_minus_cos + uz * sin_theta;
    R[1][1] = cos_theta + uy * uy * one_minus_cos;
    R[1][2] = uy * uz * one_minus_cos - ux * sin_theta;

    R[2][0] = uz * ux * one_minus_cos - uy * sin_theta;
    R[2][1] = uz * uy * one_minus_cos + ux * sin_theta;
    R[2][2] = cos_theta + uz * uz * one_minus_cos;
}

void static QtoA(Quaternion *q, AxisAngle *axisAngle) {
    // 计算旋转角度 theta
    float theta = 2.0 * acos(q->w);
    
    // 计算 sin(theta / 2)
    float sin_half_theta = sqrt(1.0 - q->w * q->w);
    //float sin_half_theta = hls::sqrtf(1.0 - q->w * q->w);

    // 如果 sin(theta / 2) 接近于零，说明旋转角度接近于零，此时旋转轴可以任意
    if (fabs(sin_half_theta) < 1e-8) {
        axisAngle->x = 1.0;
        axisAngle->y = 0.0;
        axisAngle->z = 0.0;
    } else {
        // 否则，归一化旋转轴
        axisAngle->x = q->x / sin_half_theta;
        axisAngle->y = q->y / sin_half_theta;
        axisAngle->z = q->z / sin_half_theta;
    }
}

void static AtoQ(AxisAngle *axisAngle, Quaternion *q) {
    float theta=sqrt(axisAngle->x * axisAngle->x +
                        axisAngle->y * axisAngle->y +
                        axisAngle->z * axisAngle->z);
    float half_theta = theta / 2.0;
    float sin_half_theta = sin(half_theta);

    // 四元数的实部
    q->w = cos(half_theta);

    // 四元数的虚部
    q->x = axisAngle->x * sin_half_theta;
    q->y = axisAngle->y * sin_half_theta;
    q->z = axisAngle->z * sin_half_theta;
}

void static Quaternion_Multiply(Quaternion *q1, Quaternion *q2, Quaternion *result) {
    // 计算乘积四元数的各个分量
    result->w = q1->w * q2->w - q1->x * q2->x - q1->y * q2->y - q1->z * q2->z;
    result->x = q1->w * q2->x + q1->x * q2->w + q1->y * q2->z - q1->z * q2->y;
    result->y = q1->w * q2->y - q1->x * q2->z + q1->y * q2->w + q1->z * q2->x;
    result->z = q1->w * q2->z + q1->x * q2->y - q1->y * q2->x + q1->z * q2->w;
}

void static Quaternion_Conjugate(Quaternion *q, Quaternion *conj) {
    conj->w = q->w;    // 实部不变
    conj->x = -q->x;   // 取反虚部 x
    conj->y = -q->y;   // 取反虚部 y
    conj->z = -q->z;   // 取反虚部 z
}

float static QuaternionNorm(Quaternion q) {
    return sqrt(q.w * q.w + q.x * q.x + q.y * q.y + q.z * q.z);
}

// 归一化四元数
void static QuaternionNormalize(Quaternion *q) {
    float norm = QuaternionNorm(*q);
    if (norm == 0) {
        // 防止除以零的情况
        q->w = 0;
        q->x = 0;
        q->y = 0;
        q->z = 0;
    } else {
        q->w = q->w / norm;
        q->x = q->x / norm;
        q->y = q->y / norm;
        q->z = q->z / norm;
    }
}

void static QuaternionLeft(Quaternion *q,float qleft[4][4]){
        qleft[0][0] =q->w;
		qleft[0][1] = -q->x;
		qleft[0][2] = -q->y;
		qleft[0][3] = -q->z;
		qleft[1][0] = q->x;
		qleft[1][1] = q->w;
		qleft[1][2] = -q->z;
		qleft[1][3] = q->y;
		qleft[2][0] = q->y;
		qleft[2][1] = q->z;
		qleft[2][2] = q->w;
		qleft[2][3] = -q->x;
		qleft[3][0] = q->z;
		qleft[3][1] = -q->y;
		qleft[3][2] = q->x;
		qleft[3][3] = q->w;
}

void static QuaternionRight(Quaternion *q,float qright[4][4]){
        qright[0][0] =q->w;
		qright[0][1] = -q->x;
		qright[0][2] = -q->y;
		qright[0][3] = -q->z;
		qright[1][0] = q->x;
		qright[1][1] = q->w;
		qright[1][2] = q->z;
		qright[1][3] = -q->y;
		qright[2][0] = q->y;
		qright[2][1] = -q->z;
		qright[2][2] = q->w;
		qright[2][3] = q->x;
		qright[3][0] = q->z;
		qright[3][1] = q->y;
		qright[3][2] = -q->x;
		qright[3][3] = q->w;
}