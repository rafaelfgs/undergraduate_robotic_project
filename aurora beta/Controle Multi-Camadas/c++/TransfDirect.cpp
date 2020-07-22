//

void TransDirect(){
    
    // Variáveis da formacao
    float x, y, z, ph th, ps, p, q, r, b;
    
    // Coordenadas do baricentro da formação (xf,yf,zf)
    x = (RobotAct[0]+RobotAct[3]+RobotAct[6])/3;
    y = (RobotAct[1]+RobotAct[4]+RobotAct[7])/3;
    z = (RobotAct[2]+RobotAct[5]+RobotAct[8])/3;
    
// Orientação da formação
    ph =  atan((2*RobotAct[5]-RobotAct[2]-RobotAct[8])/(2*RobotAct[4]-RobotAct[1]-RobotAct[7]));
    th = -atan((2*RobotAct[2]-RobotAct[5]-RobotAct[8])/(2*RobotAct[0]-RobotAct[3]-RobotAct[6]));
    ps =  atan2((2*RobotAct[1]-RobotAct[4]-RobotAct[7]),(2*RobotAct[0]-RobotAct[3]-RobotAct[6]));
    
// Lados do triângulo
    p = sqrt(pow(RobotAct[0]-RobotAct[3],2)+pow(RobotAct[1]-RobotAct[4],2)+pow(RobotAct[2]-RobotAct[5],2));
    q = sqrt(pow(RobotAct[0]-RobotAct[6],2)+pow(RobotAct[1]-RobotAct[7],2)+pow(RobotAct[2]-RobotAct[8],2));
    r = sqrt(pow(RobotAct[3]-RobotAct[6],2)+pow(RobotAct[4]-RobotAct[7],2)+pow(RobotAct[5]-RobotAct[8],2));
    
// Ângulo de abertura dos robôs 2 e 3 em relação ao R1
    b = acos((p*p+q*q-(r*r))/(2*p*q));
    
    FormAct[0] = x;
    FormAct[1] = y;
    FormAct[2] = z;
    FormAct[3] = ph;
    FormAct[4] = th;
    FormAct[5] = ps;
    FormAct[6] = p;
    FormAct[7] = q;
    FormAct[8] = b;
    
    // return 0;
}