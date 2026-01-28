#include"TOP.h"

#define NUM 4
#define Area 6
#define Area_ROW 21
#define Area_COL 15 // 由于部分QR分解要求必须是一个方阵，因此必须做出扩展，不能再是15，修改与ROW一致（同步修改backsub.h与QRD.h）
#define M_ROW (Area_ROW*(NUM+1)) // 6*6 A(6*6) 4 x   

#define M_COL (Area_COL*(NUM+1)) //
// 为了使最后一次QR分解与之前的一致，扩展一行一列0；

// 每个块的大小

using namespace std;
struct ResL
{
    AxisAngle fai;
    float dx,dy,dz;
};


struct Vertex
{       
    float x,y,z;
    float v[3],ba[3],bg[3];
    Quaternion qv; 
    float R[3][3];
};

struct Edge
{       
    float x,y,z;
    Quaternion qe; 
    float R[3][3];
};
struct Edge_IMU
{       
    float alp[3],bet[3];
    Quaternion gam;
};




void top(float x[NUM][16],
        float ee[NUM-1][7],
        float ee_IMU[NUM-1][10],
        float delta_t,
        float prior[7],
        float result[NUM][7],
        int iter,float res,
        int algorithm){
    
    // 因子计算的结果 构建Mx=b方程组,
    
    Vertex v[NUM];
    Edge e[NUM-1];
    Edge_IMU e_IMU[NUM-1];
    iter =0;
    float gravity[3]={0,0,-9.81};
    float I[3][3]={
        {1,0,0},
        {0,1,0},
        {0,0,1},
    };
    float I34[3][4]={
        {0, 1, 0, 0},
		{0, 0, 1, 0},
		{0, 0, 0, 1}
    };
    float I43[4][3]={
        1,0,0,
		0,1,0,
		0,0,1,
		0,0,0
    };

    for(int i=0;i<NUM;i++){
        v[i].x=x[i][0];
        v[i].y=x[i][1];
        v[i].z=x[i][2];
        v[i].qv.w=x[i][3];
        v[i].qv.x=x[i][4];
        v[i].qv.y=x[i][5];
        v[i].qv.z=x[i][6];
        QtoR(&v[i].qv,v[i].R);
        v[i].v[0]=x[i][7];
        v[i].v[1]=x[i][8];
        v[i].v[2]=x[i][9];
        v[i].ba[0]=x[i][10];
        v[i].ba[1]=x[i][11];
        v[i].ba[2]=x[i][12];
        v[i].bg[0]=x[i][13];
        v[i].bg[1]=x[i][14];
        v[i].bg[2]=x[i][15];
    }
    for(int i=0;i<NUM-1;i++){
        e[i].x=ee[i][0];
        e[i].y=ee[i][1];
        e[i].z=ee[i][2];
        e[i].qe.w=ee[i][3];
        e[i].qe.x=ee[i][4];
        e[i].qe.y=ee[i][5];
        e[i].qe.z=ee[i][6];
        QtoR(&e[i].qe,e[i].R);
    }
    for(int i=0;i<NUM-1;i++){
        e_IMU[i].alp[0]=ee_IMU[i][0];
        e_IMU[i].alp[1]=ee_IMU[i][1];
        e_IMU[i].alp[2]=ee_IMU[i][2];

        e_IMU[i].bet[0]=ee_IMU[i][3];
        e_IMU[i].bet[1]=ee_IMU[i][4];
        e_IMU[i].bet[2]=ee_IMU[i][5];

        e_IMU[i].gam.w=ee_IMU[i][6];
        e_IMU[i].gam.x=ee_IMU[i][7];
        e_IMU[i].gam.y=ee_IMU[i][8];
        e_IMU[i].gam.z=ee_IMU[i][9];
    }
      
    // 以下为计算LiDAR先验
    float prior_tkk1[3]={prior[0],prior[1],prior[2]};
    //float prior_qkk1[4]={F[4][3]-1,F[4][4],F[4][5],F[4][6]};
    Quaternion prior_qkk1;
    prior_qkk1.w=prior[3]-1;
    prior_qkk1.x=prior[4]-0;
    prior_qkk1.y=prior[5]-0;
    prior_qkk1.z=prior[6]-0;

    float prior_rkk1[3][3],prior_rkk1T[3][3];
    QtoR(&prior_qkk1,prior_rkk1);
    matrix_transpose(prior_rkk1,prior_rkk1T);
    float prior_Rk[3][3]={
        {1,0,0},
        {0,1,0},
        {0,0,1}
    };
    ResL prior_res;
    RtoA(prior_rkk1T,&prior_res.fai);
    float prior_temp[3],prior_temp1[3];
    prior_temp[0]=-prior[0];
    prior_temp[1]=-prior[1];
    prior_temp[2]=-prior[2];
    matrix_vector_muti(prior_rkk1T,prior_temp,prior_temp1);

    


    while (1)
    {        
        float M[M_ROW][M_COL];
        float b[M_ROW];
        
        for (int i = 0; i < M_ROW; i++){
                for (int j = 0; j < M_COL; j++){
                    M[i][j] = 0;                
                }
                b[i]=0;
            }
               
        // 还需要添加x更新迭代的方法以及x初始值 模板化时先忽略了先验部分的修改，后续再改 已修改
        if(algorithm==0){               
            for(int i=0;i<3;i++){
                for(int j=0;j<3;j++){
                    M[i][j]=prior_Rk[i][j];
                    M[i+3][j+3]=prior_rkk1T[i][j];
                    M[i+6][j+0]=I[i][j];
                    M[i+9][j+3]=I[i][j];
                    M[i+12][j+6]=I[i][j];
                    M[i+15][j+9]=I[i][j];
                    M[i+18][j+12]=I[i][j];
                }
            }
            b[0]=prior_res.fai.x;
            b[1]=prior_res.fai.y;
            b[2]=prior_res.fai.z;
            b[3]=prior_temp1[0];
            b[4]=prior_temp1[1];
            b[5]=prior_temp1[2];
            b[6]=0;
            b[7]=0;
            b[8]=0;
            b[9]=0;
            b[10]=0;
            b[11]=0;
            b[12]=0;
            b[13]=0;
            b[14]=0;
            b[15]=0;
            b[16]=0;
            b[17]=0;
            b[18]=0;
            b[19]=0;
            b[20]=0;
            
            // 先验之外的
            // LiDAR和IMU的计算
            for (int i=0;i<NUM-1;i++){               
                //float res[6];
                //float J2[6][6];

                float temp_t[3]={
                    (v[i].x-v[i+1].x),
                    (v[i].y-v[i+1].y),
                    (v[i].z-v[i+1].z)
                };
                float tkk1[3]={e[i].x,e[i].y,e[i].z};
                float J2_1[3][3];
                float J2_2[3][3];
                float J2_3[3][3];
                float J1_3[3][3];

                float RkT[3][3],Rk1T[3][3],Rkk1T[3][3];

                matrix_transpose(v[i].R,RkT);
                matrix_transpose(v[i+1].R,Rk1T);
                matrix_transpose(e[i].R,Rkk1T);
                
                // 雅可比的计算
                matrix_multiply(v[i].R,v[i+1].R,J2_1);
                matrix_scalar_muti(J2_1,-1,J2_1);
                    
                matrix_multiply(Rkk1T,Rk1T,J1_3);
                matrix_scalar_muti(J1_3,-1,J2_3);

                
                float t_inv[3][3];
                matrix_inv(temp_t,t_inv);
                float temp1[3][3],temp2[3][3];
                matrix_multiply(Rkk1T,Rk1T,temp1);
                matrix_multiply(t_inv,v[i+1].R,temp2);
                matrix_multiply(temp1,temp2,J2_2);
                // 残差的计算
                ResL res1;
                
                float r_temp1[3][3];
                float r_temp2[3],r_temp3[3],r_temp4[3];
                matrix_multiply(temp1,v[i].R,r_temp1);
                RtoA(r_temp1,&res1.fai);
                matrix_vector_muti(v[i+1].R,temp_t,r_temp2);
                for (int k=0;k<3;k++){
                    r_temp3[k]=r_temp2[k]-tkk1[k];
                }
                matrix_vector_muti(Rkk1T,r_temp3,r_temp4);
                res1.dx=r_temp4[0];
                res1.dy=r_temp4[1];
                res1.dz=r_temp4[2];
                // IMU的计算
                // IMU雅可比的计算
                //float IMU_Jk[9][9]; // 实际上没算ba，bg因此省略一部分
                //float IMU_Jk1[9][9];
                float IMU_JB1[3][3];
                float IMU_JB2[3][3];
                float IMU_JB3[3][3];
                float IMU_JB5[3][3];
                float IMU_JB6[3][3];            
                // Rk的转置和取反都 已经实现
                float JB1_temp[3]={
                    v[i+1].x-v[i].x-v[i].v[0]*delta_t-gravity[0]*delta_t*delta_t/2,
                    v[i+1].y-v[i].y-v[i].v[1]*delta_t-gravity[1]*delta_t*delta_t/2,
                    v[i+1].z-v[i].z-v[i].v[2]*delta_t-gravity[2]*delta_t*delta_t/2
                };
                float JB1_temp1[3][3];
                matrix_inv(JB1_temp,JB1_temp1);
                matrix_multiply(RkT,JB1_temp1,IMU_JB1);
                
                matrix_scalar_muti(RkT,delta_t,IMU_JB2); // 实际上得取反

                Quaternion qk1_inv,JB3_temp1;
                Quaternion_Conjugate(&v[i+1].qv,&qk1_inv);
                Quaternion_Multiply(&qk1_inv,&v[i].qv,&JB3_temp1);
                float JB3_left[4][4],gam_right[4][4];
                QuaternionLeft(&JB3_temp1,JB3_left);
                QuaternionRight(&e_IMU->gam,gam_right);
                float JB3_temp2[3][4],JB3_temp3[3][4];
                matrix_Multiply_34_44(I34,JB3_left,JB3_temp2);
                matrix_Multiply_34_44(JB3_temp2,gam_right,JB3_temp3);
                matrix_Multiply_34_43(JB3_temp3,I43,IMU_JB3);

                Quaternion qk_inv,gam_inv,JB5_temp1;
                Quaternion_Conjugate(&v[i].qv,&qk_inv);
                Quaternion_Conjugate(&e_IMU->gam,&gam_inv);
                Quaternion_Multiply(&qk_inv,&gam_inv,&JB5_temp1);
                float JB5_left[4][4];
                QuaternionLeft(&JB5_temp1,JB5_left);
                float JB5_temp2[3][4];
                matrix_Multiply_34_44(I34,JB5_left,JB5_temp2);
                matrix_Multiply_34_43(JB5_temp2,I43,IMU_JB5);

                float JB6_temp[3]={
                    v[i+1].x-v[i].x-gravity[0]*delta_t,
                    v[i+1].y-v[i].y-gravity[1]*delta_t,
                    v[i+1].z-v[i].z-gravity[2]*delta_t,
                };
                float JB6_temp1[3][3];
                matrix_inv(JB6_temp,JB6_temp1);
                matrix_multiply(RkT,JB6_temp1,IMU_JB6);
                

                // IMU残差的计算
                // 其中 ba bg 直接更新即可 p,q,v在此处计算
                float res_p_temp[3]={
                    v[i+1].x-v[i].x-v[i].v[0]*delta_t+gravity[0]*delta_t*delta_t/2,
                    v[i+1].y-v[i].y-v[i].v[1]*delta_t+gravity[1]*delta_t*delta_t/2,
                    v[i+1].z-v[i].z-v[i].v[2]*delta_t+gravity[2]*delta_t*delta_t/2,
                };
                float res_p_rot_temp[3];
                matrix_vector_muti(v[i].R,res_p_temp,res_p_rot_temp); // 记得最后减去alpha

                Quaternion res_q_temp1,res_q_temp2;
                Quaternion_Multiply(&qk_inv,&v[i+1].qv,&res_q_temp1);
                Quaternion_Multiply(&res_q_temp1,&gam_inv,&res_q_temp2); //取虚部

                float res_v_temp[3]={
                    v[i+1].v[0]-v[i].v[0]*gravity[0]*delta_t,
                    v[i+1].v[1]-v[i].v[1]*gravity[1]*delta_t,
                    v[i+1].v[2]-v[i].v[2]*gravity[2]*delta_t,
                };
                float res_v_rot_temp[3];
                matrix_vector_muti(v[i].R,res_v_temp,res_v_rot_temp); //记得减beta


                // 计算完毕
                // 放入到大矩阵中 此时大矩阵采用  p q b ba bg 的顺序
                for (int ii = (i+1)*Area_ROW; ii < (i+1)*Area_ROW+3; ii++){
                    for (int j = i*Area_COL; j < i*Area_COL+3; j++){
                        M[ii+3][j]=I[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        M[ii][j+3]=J1_3[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        //M[ii+3][j+3]=(ii==j+6)? 1:0;
                        M[ii+3][j+15]=J2_1[ii-(i+1)*Area_ROW][j-i*Area_COL];//
                        M[ii][j+15]=J2_2[ii-(i+1)*Area_ROW][j-i*Area_COL];//
                        M[ii][j+18]=J2_3[ii-(i+1)*Area_ROW][j-i*Area_COL]; //
                        // LiDAR这里是要修改的 已修改
                        M[ii+6][j]=-1*v[i].R[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        M[ii+6][j+3]=IMU_JB1[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        M[ii+6][j+6]=-1*IMU_JB2[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        M[ii+6][j+15]=v[i].R[ii-(i+1)*Area_ROW][j-i*Area_COL];//
                        M[ii+9][j+3]=IMU_JB3[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        M[ii+9][j+18]=IMU_JB5[ii-(i+1)*Area_ROW][j-i*Area_COL];//
                        M[ii+12][j+3]=IMU_JB6[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        M[ii+12][j+6]=-1*v[i].R[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        M[ii+12][j+21]=v[i].R[ii-(i+1)*Area_ROW][j-i*Area_COL];//
                        M[ii+15][j+9]=I[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        M[ii+15][j+24]=I[ii-(i+1)*Area_ROW][j-i*Area_COL];//
                        M[ii+18][j+12]=I[ii-(i+1)*Area_ROW][j-i*Area_COL];
                        M[ii+18][j+27]=I[ii-(i+1)*Area_ROW][j-i*Area_COL];//

                    }
                }
                b[(i+1)*Area_ROW+0]=res1.dx;
                b[(i+1)*Area_ROW+1]=res1.dy;
                b[(i+1)*Area_ROW+2]=res1.dz;
                b[(i+1)*Area_ROW+3]=res1.fai.x;
                b[(i+1)*Area_ROW+4]=res1.fai.y;
                b[(i+1)*Area_ROW+5]=res1.fai.z;

                b[(i+1)*Area_ROW+6]=res_p_rot_temp[0]-e_IMU[i].alp[0];
                b[(i+1)*Area_ROW+7]=res_p_rot_temp[1]-e_IMU[i].alp[1];
                b[(i+1)*Area_ROW+8]=res_p_rot_temp[2]-e_IMU[i].alp[2];

                b[(i+1)*Area_ROW+9]=res_q_temp2.x;
                b[(i+1)*Area_ROW+10]=res_q_temp2.y;
                b[(i+1)*Area_ROW+11]=res_q_temp2.z;

                b[(i+1)*Area_ROW+12]=res_v_rot_temp[0]-e_IMU[i].bet[0];
                b[(i+1)*Area_ROW+13]=res_v_rot_temp[1]-e_IMU[i].bet[1];
                b[(i+1)*Area_ROW+14]=res_v_rot_temp[2]-e_IMU[i].bet[2];

                b[(i+1)*Area_ROW+15]=v[i+1].ba[0]-v[i].ba[0];
                b[(i+1)*Area_ROW+16]=v[i+1].ba[1]-v[i].ba[1];
                b[(i+1)*Area_ROW+17]=v[i+1].ba[2]-v[i].ba[2];

                b[(i+1)*Area_ROW+18]=v[i+1].bg[0]-v[i].bg[0];
                b[(i+1)*Area_ROW+19]=v[i+1].bg[1]-v[i].bg[1];
                b[(i+1)*Area_ROW+20]=v[i+1].bg[2]-v[i].bg[2];

                
                
            }

        }else if(algorithm==1){
            for (int i = 0; i < M_ROW; i++)
            {
                b[i]=1;
            }
            
            float factorBegin[2]={prior[0],prior[1]}; // prior
            float factorEnd[2]={prior[2],prior[3]};
            // Factor Compute for Collision_free
            // Factor Compute for Smooth
            

            for (int i = 0; i < NUM; i++)
            {
                
                float factorNow[2]={x[i][0],x[i][1]};
                float factorFront[2],factorBack[2];

                // 选取待计算的因子
                if(i==0){
                    factorFront[0]=factorBegin[0];
                    factorFront[1]=factorBegin[1];

                    factorNow[0]=x[i][0];
                    factorNow[1]=x[i][1];

                    factorBack[0]=x[i+1][0];
                    factorBack[1]=x[i+1][1];
                } else if(i==NUM-1){
                    factorFront[0]=x[i-1][0];
                    factorFront[1]=x[i-1][1];

                    factorNow[0]=x[i][0];
                    factorNow[1]=x[i][1];

                    factorBack[0]=factorEnd[0];
                    factorBack[1]=factorEnd[1];
                }
                else{
                    factorFront[0]=x[i-1][0];
                    factorFront[1]=x[i-1][1];

                    factorNow[0]=x[i][0];
                    factorNow[1]=x[i][1];

                    factorBack[0]=x[i+1][0];
                    factorBack[1]=x[i+1][0];
                }

                float collisionResultTemp[2];
                float smoothResultTemp[2];

                Collision_free(factorNow,collisionResultTemp);
                Smooth(factorFront,factorNow,factorBack,smoothResultTemp);

                M[i*Area_ROW+0][i*Area_COL+0]=collisionResultTemp[0];
                M[i*Area_ROW+1][i*Area_COL+1]=collisionResultTemp[1];
                M[i*Area_ROW+2][i*Area_COL+0]=smoothResultTemp[0];
                M[i*Area_ROW+3][i*Area_COL+1]=smoothResultTemp[1];

            }
        }else if(algorithm==2){
                float Q_2[N][N],R_2[N][N],P_2[N][N];  
                
                
                InitialZero(Q_2);
                InitialZero(R_2);
                InitialZero(P_2);

                DiagSqrt(Q,Q_2);
                DiagSqrt(R,R_2);
                DiagSqrt(P,P_2);

                float temp_pa[N][N],temp_pb[N][N];
                matrix_multiply(P_2,A,temp_pa);
                matrix_multiply(P_2,B,temp_pb);
                // 放入到 M 中
                float M[M_ROW][M_COL];
                int S[S_ROW][S_COL]; //伴随信息矩阵
                
                for(int i=0;i<M_ROW;i++){
                    for(int j=0;j<M_COL;j++){
                        M[i][j]=0;
                    }
                }

                for(int i=0;i<S_ROW;i++){
                    for(int j=0;j<S_COL;j++){
                        S[i][j]=0;
                    }
                }
                
                for(int k=0;k<NUM;k++){
                    for(int i=0;i<N;i++){
                        for(int j=0;j<N;j++){
                        //  每个NUM之间 行加9 列加6
                        //  NUM内N*N次
                        // 这个思路有问题 ? 不知哪有问题了已经9.16 修改完毕正常运行
                        M[i+k*9+0][j+k*6+0]=Q_2[i][j];
                        M[i+k*9+1*3][j+k*6+0*3]=-P_2[i][j];
                        M[i+k*9+1*3][j+k*6+1*3]=temp_pa[i][j];
                        M[i+k*9+1*3][j+k*6+2*3]=temp_pb[i][j];
                        M[i+k*9+2*3][j+k*6+1*3]=R_2[i][j];
                        }
                    }
                    S[k*3+0][k*2+0]=1;
                    S[k*3+1][k*2+0]=1;
                    S[k*3+1][k*2+1]=1;
                    S[k*3+1][k*2+2]=1;
                    S[k*3+2][k*2+1]=1;

                }
                for(int i=0;i<N;i++){
                    for(int j=0;j<N;j++){
                    M[M_ROW-3+i][M_COL-3+j]=Q_2[i][j];
                    }    
                }
                S[S_ROW-1][S_COL-1]=1;
                
               
                float Temp_QR[NUM*N][NUM*N];
                

                float b[NUM];

                for(int k=0;k<S_COL;k++){
                    // NUM = 4;
                    for (int i = 0; i < NUM*N; i++)
                        for (int j = 0; j < NUM*N; j++)
                            Temp_QR[i][j]=0;
                    // 这一部分逻辑存在一些问题 需修改
                    
                    int count_i=0,count_j=0; // 计数 哪些行需要更新 计最大列

                    for(int i=0;i<NUM;i++){
                        //Temp_Index[i][j]=0;
                        if(S[i+k][k]==1){
                            count_i=i>count_i?i:count_i;
                            //Temp_QR[0][j]=M[k*3][(k+j)*3]
                            for(int j=0;j<NUM;j++){
                                if(S[i+k][j+k]==1){
                                    count_j = j>count_j ? j:count_j;
                            //Temp_Index[i][j]=1;
                                    for(int ii=0;ii<N;ii++){
                                        for(int jj=0;jj<N;jj++){
                                            Temp_QR[i*N+ii][j*N+jj]=M[k*N+i*N+ii][k*N+j*N+jj];
                                        }
                                    }
                                        
                                }
                            }
                        }
                    }
                        // 更新S;
                    for(int i=1;i<count_i+1;i++){
                        S[i+k][k]=0;
                    }

                    for(int j=1;j<count_j+1;j++){
                        for(int i=0;i<count_i+1;i++){
                            S[i+k][j+k]=1;                                
                        }
                    }
                    
                }
                    
                    
                        
        }else{
            
        }

        float error=0.0;
        for(int i=0;i<Area_ROW*NUM;i++){
            error+=b[i]*b[i];
        }
            
        res=error;
            
            
        if(error<20.0 || iter>100){
            for(int i=0;i<NUM;i++){                    
                result[i][0]=v[i].x;
                result[i][1]=v[i].y;
                result[i][2]=v[i].z;
                result[i][3]=v[i].qv.w;
                result[i][4]=v[i].qv.x;
                result[i][5]=v[i].qv.y;
                result[i][6]=v[i].qv.z;                   
            }
            break;
        }
           
        // 部分QR分解
        extern Partial_QRD pqrd;

        for (int k=0;k<NUM;k++){ 
            for (int i = 0; i < A_ROW; i++)
                for (int j = 0; j < A_COL; j++)
                pqrd.A[i][j] = M[i+Area_ROW*k][j+Area_COL*k];

            
            for(int i=0;i<A_ROW;i++){
                //pqrd.d[i+Area_ROW*k]=b[i+Area_ROW*k];
                pqrd.d[i]=b[i+Area_ROW*k];
            }
            
          

            QRD();   
            
           
            for (int i = 0; i < A_ROW; i++)
                for (int j = 0; j < A_COL; j++)
                M[i+Area_ROW*k][j+Area_COL*k] = pqrd.A[i][j];

            for(int i=0;i<A_ROW;i++){
                //b[i+Area_ROW*k]=pqrd.d[i+Area_ROW+k];
                b[i+Area_ROW*k]=pqrd.d[i];
            }
        
        }
        // 该方程分解完毕

        // 消元求解并反向回代
        // 遇到秩的问题 待解决 已解决

        // 此处是因为反向回代处理的是一个方阵，下几行为零，需修改，后续研究发现必须将其修改为一个方阵的形式，因此不做修改 这种方法无解
        // 因此直接删去下面几行得了
        float M_compute[NUM*Area_COL][NUM*Area_COL];
        float dx[NUM*Area_COL];
        float b_compute[NUM*Area_COL];
        for(int i=0;i<NUM*Area_ROW;i++){
            int n=i%Area_ROW;
            int ii=(i/Area_ROW)*Area_COL;
            if(n<Area_COL){
                for(int j=0;j<NUM*Area_COL;j++){
                    M_compute[ii+n][j]=M[i][j];
                }
                b_compute[ii+n]=b[i];
            }
        }
        backsub(M_compute,b_compute,dx);
        
        // 更新位姿
        float lambla =-0.0001;
        

        // update x x0,x1,x2,x3;

        // 
        AxisAngle xx;
        Quaternion x_new;
        Quaternion pose_new;
        for(int i=0;i<NUM;i++){
            xx.x=lambla*dx[3+Area_COL*i];
            xx.y=lambla*dx[4+Area_COL*i];
            xx.z=lambla*dx[5+Area_COL*i];
            
            AtoQ(&xx,&x_new);
            QuaternionNormalize(&x_new);
            Quaternion_Multiply(&x_new,&v[i].qv,&pose_new);
            v[i].qv.w=pose_new.w;
            v[i].qv.x=pose_new.x;
            v[i].qv.y=pose_new.y;
            v[i].qv.z=pose_new.z;
            v[i].x=v[i].x+lambla*dx[0+Area_COL*i];
            v[i].y=v[i].y+lambla*dx[1+Area_COL*i];
            v[i].z=v[i].z+lambla*dx[2+Area_COL*i];

            v[i].v[0]=v[i].v[0]+lambla*dx[6+Area_COL*i];
            v[i].v[1]=v[i].v[1]+lambla*dx[7+Area_COL*i];
            v[i].v[2]=v[i].v[2]+lambla*dx[8+Area_COL*i];

            v[i].ba[0]=v[i].ba[0]+lambla*dx[9+Area_COL*i];
            v[i].ba[1]=v[i].ba[1]+lambla*dx[10+Area_COL*i];
            v[i].ba[2]=v[i].ba[2]+lambla*dx[11+Area_COL*i];
            
            v[i].bg[0]=v[i].bg[0]+lambla*dx[12+Area_COL*i];
            v[i].bg[1]=v[i].bg[1]+lambla*dx[13+Area_COL*i];
            v[i].bg[2]=v[i].bg[2]+lambla*dx[14+Area_COL*i];

            QtoR(&v[i].qv,v[i].R);
        }
        
        

        iter++;
    }
};


