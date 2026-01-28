void Smooth(float A_front[2],float A[2], float A_back[2],float result[2]){
    //float result[2];
    float temp1[2],temp2[2];
    temp1[0]=A_front[0]-A[0];
    temp1[1]=A_front[1]-A[1];

    temp2[0]=A_back[0]-A[0];
    temp2[1]=A_back[1]-A[1];

    result[0]=temp1[0]+temp2[0];
    result[1]=temp1[1]+temp2[1];

}