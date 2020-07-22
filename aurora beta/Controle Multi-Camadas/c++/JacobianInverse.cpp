
JacInv[0][0] = 1;
JacInv[0][1] = 0;
JacInv[0][2] = 0;
JacInv[0][3] = 0;
JacInv[0][4] = -(cos(ps)*sin(th)*sqrt(p*p + 2*cos(b)*p*q + q*q))/3;
JacInv[0][5] = -(cos(th)*sin(ps)*sqrt(p*p + 2*cos(b)*p*q + q*q))/3;
JacInv[0][6] = (cos(ps)*cos(th)*(p + q*cos(b)))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q));
JacInv[0][7] = (cos(ps)*cos(th)*(q + p*cos(b)))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q));
JacInv[0][8] = -(p*q*cos(ps)*sin(b)*cos(th))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q));


JacInv[1][0] = 0;
JacInv[1][1] = 1;
JacInv[1][2] = 0;
JacInv[1][3] = 0;
JacInv[1][4] = -(sin(ps)*sin(th)*sqrt(p*p + 2*cos(b)*p*q + q*q))/3;
JacInv[1][5] = (cos(ps)*cos(th)*sqrt(p*p + 2*cos(b)*p*q + q*q))/3;
JacInv[1][6] = (cos(th)*sin(ps)*(p + q*cos(b)))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q));
JacInv[1][7] = (cos(th)*sin(ps)*(q + p*cos(b)))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q));
JacInv[1][8] = -(p*q*sin(b)*cos(th)*sin(ps))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q));


JacInv[2][0] = 0;
JacInv[2][1] = 0;
JacInv[2][2] = 1;
JacInv[2][3] = 0;
JacInv[2][4] = -(cos(th)*sqrt(p*p + 2*cos(b)*p*q + q*q))/3;
JacInv[2][5] = 0;
JacInv[2][6] = -(sin(th)*(p + q*cos(b)))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q));
JacInv[2][7] = -(sin(th)*(q + p*cos(b)))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q));
JacInv[2][8] = (p*q*sin(b)*sin(th))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q));



JacInv[3][0] = 1;
JacInv[3][1] = 0;
JacInv[3][2] = 0;
JacInv[3][3] = (sqrt(1 - pow(2*p*p + cos(b)*p*q - q*q,2)/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))*(sin(ph)*sin(ps) + cos(ph)*cos(ps)*sin(th))*sqrt(4*p*p - 4*cos(b)*p*q + q*q))/3;
JacInv[3][4] = (cos(ps)*sin(th)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(6*sqrt(p*p + 2*cos(b)*p*q + q*q)) + (cos(ps)*cos(th)*sin(ph)*sqrt(1 - pow(2*p*p + cos(b)*p*q - q*q,2)/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))*sqrt(4*p*p - 4*cos(b)*p*q + q*q))/3;
JacInv[3][5] = (cos(th)*sin(ps)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(6*sqrt(p*p + 2*cos(b)*p*q + q*q)) - (sqrt(1 - pow(2*p*p + cos(b)*p*q - q*q,2)/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*sqrt(4*p*p - 4*cos(b)*p*q + q*q))/3;
JacInv[3][6] = (cos(ps)*cos(th)*(p/2 + (q*cos(b))/2)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(3*pow(p*p + 2*cos(b)*p*q + q*q,3/2)) - (2*sqrt(1 - pow(2*p*p + cos(b)*p*q - q*q,2)/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(2*p - q*cos(b)))/(3*sqrt(4*p*p - 4*cos(b)*p*q + q*q)) - (cos(ps)*cos(th)*(8*p + 2*q*cos(b)))/(6*sqrt(p*p + 2*cos(b)*p*q + q*q)) - (3*p*q*q*(2*p*p + q*q)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(pow(cos(b),2) - 1)*sqrt(4*p*p - 4*cos(b)*p*q + q*q)*(2*p*p + cos(b)*p*q - q*q))/(sqrt(1 - pow(2*p*p + cos(b)*p*q - q*q,2)/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))*pow(4*pow(p,4) + 4*pow(p,3)*q*cos(b) - 8*p*p*q*q*pow(cos(b),2) + 5*p*p*q*q - 2*p*pow(q,3)*cos(b) + pow(q,4),2);
JacInv[3][7] = (cos(ps)*cos(th)*(4*q - 2*p*cos(b)))/(6*sqrt(p*p + 2*cos(b)*p*q + q*q)) - (2*sqrt(1 - pow(2*p*p + cos(b)*p*q - q*q,2)/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(q/2 - p*cos(b)))/(3*sqrt(4*p*p - 4*cos(b)*p*q + q*q) + (cos(ps)*cos(th)*(q/2 + (p*cos(b))/2)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(3*pow(p*p + 2*cos(b)*p*q + q*q,3/2)) + (3*p*p*q*(2*p*p + q*q)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(pow(cos(b),2) - 1)*sqrt(4*p*p - 4*cos(b)*p*q + q*q)*(2*p*p + cos(b)*p*q - q*q))/(sqrt(1 - pow(2*p*p + cos(b)*p*q - q*q,2)/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))*pow(4*pow(p,4) + 4*pow(p,3)*q*cos(b) - 8*p*p*q*q*pow(cos(b),2) + 5*p*p*q*q - 2*p*pow(q,3)*cos(b) + pow(q,4),2));
JacInv[3][8] = (p*q*cos(ps)*sin(b)*cos(th))/(3*sqrt(p*p + 2*cos(b)*p*q + q*q)) - (2*p*q*sin(b)*sqrt(1 - pow(2*p*p + cos(b)*p*q - q*q,2)/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th)))/(3*sqrt(4*p*p - 4*cos(b)*p*q + q*q)) - (p*q*cos(ps)*sin(b)*cos(th)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(6*pow(p*p + 2*cos(b)*p*q + q*q,3/2)) - (3*p*p*q*q*sin(b)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*sqrt(4*p*p - 4*cos(b)*p*q + q*q)*(2*pow(p,3)*q - p*pow(q,3) + 4*pow(p,4)*cos(b) + pow(q,4)*cos(b) - 3*p*p*q*q*cos(b) - p*pow(q,3)*pow(cos(b),2) + 2*pow(p,3)*q*pow(cos(b),2)))/(sqrt(1 - pow(2*p*p + cos(b)*p*q - q*q,2)/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))*pow(4*pow(p,4) + 4*pow(p,3)*q*cos(b) - 8*p*p*q*q*pow(cos(b),2) + 5*p*p*q*q - 2*p*pow(q,3)*cos(b) + pow(q,4),2));
        
// ================================        
JacInv[4][0] = 0;
JacInv[4][1] = 1;
JacInv[4][2] = 0;
JacInv[4][3] = -((1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(cos(ps)*sin(ph) - cos(ph)*sin(ps)*sin(th))*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2))/3;
JacInv[4][4] = (sin(ps)*sin(th)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) + (cos(th)*sin(ph)*sin(ps)*(1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2))/3;
JacInv[4][5] = - ((1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2))/3 - (cos(ps)*cos(th)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2));
JacInv[4][6] = (2*(1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(2*p - q*cos(b)))/(3*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)) - (cos(th)*sin(ps)*(8*p + 2*q*cos(b)))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) + (cos(th)*sin(ps)*(p/2 + (q*cos(b))/2)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) + (3*p*q*q*(2*p*p + q*q)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(cos(b)^2 - 1)*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)*(2*p*p + cos(b)*p*q - q*q))/((1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(4*pow(p,4) + 4*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q - 2*p*pow(q,3)*cos(b) + pow(q,4))^2);
JacInv[4][7] = (cos(th)*sin(ps)*(4*q - 2*p*cos(b)))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) + (2*(1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(q/2 - p*cos(b)))/(3*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)) + (cos(th)*sin(ps)*(q/2 + (p*cos(b))/2)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) - (3*p*p*q*(2*p*p + q*q)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(cos(b)^2 - 1)*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)*(2*p*p + cos(b)*p*q - q*q))/((1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(4*pow(p,4) + 4*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q - 2*p*pow(q,3)*cos(b) + pow(q,4))^2);
JacInv[4][8] = (p*q*sin(b)*cos(th)*sin(ps))/(3*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) + (2*p*q*sin(b)*(1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th)))/(3*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)) - (p*q*sin(b)*cos(th)*sin(ps)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) + (3*p*p*q*q*sin(b)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)*(2*pow(p,3)*q - p*pow(q,3) + 4*pow(p,4)*cos(b) + pow(q,4)*cos(b) - 3*p*p*q*q*cos(b) - p*pow(q,3)*cos(b)^2 + 2*pow(p,3)*q*cos(b)^2))/((1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(4*pow(p,4) + 4*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q - 2*p*pow(q,3)*cos(b) + pow(q,4))^2);



JacInv[5][0] = 0;
JacInv[5][1] = 0;
JacInv[5][2] = 1;
JacInv[5][3] = (cos(ph)*cos(th)*(1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2))/3;
JacInv[5][4] = (cos(th)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (sin(ph)*sin(th)*(1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2))/3;
JacInv[5][5] = 0;
JacInv[5][6] = (sin(th)*(4*p + q*cos(b)))/(3*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (sin(th)*(p/2 + (q*cos(b))/2)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) + (2*cos(th)*sin(ph)*(1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(2*p - q*cos(b)))/(3*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)) + (3*p*q*q*cos(th)*sin(ph)*(2*p*p + q*q)*(cos(b)^2 - 1)*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)*(2*p*p + cos(b)*p*q - q*q))/((1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(4*pow(p,4) + 4*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q - 2*p*pow(q,3)*cos(b) + pow(q,4))^2);
JacInv[5][7] = (2*cos(th)*sin(ph)*(1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(q/2 - p*cos(b)))/(3*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)) - (sin(th)*(q/2 + (p*cos(b))/2)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) - (sin(th)*(4*q - 2*p*cos(b)))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (3*p*p*q*cos(th)*sin(ph)*(2*p*p + q*q)*(cos(b)^2 - 1)*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)*(2*p*p + cos(b)*p*q - q*q))/((1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(4*pow(p,4) + 4*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q - 2*p*pow(q,3)*cos(b) + pow(q,4))^2);
JacInv[5][8] = (p*q*sin(b)*sin(th)*(4*p*p + 2*cos(b)*p*q - 2*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) - (p*q*sin(b)*sin(th))/(3*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) + (2*p*q*sin(b)*cos(th)*sin(ph)*(1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2))/(3*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)) + (3*p*p*q*q*sin(b)*cos(th)*sin(ph)*(4*p*p - 4*cos(b)*p*q + q*q)^(1/2)*(2*pow(p,3)*q - p*pow(q,3) + 4*pow(p,4)*cos(b) + pow(q,4)*cos(b) - 3*p*p*q*q*cos(b) - p*pow(q,3)*cos(b)^2 + 2*pow(p,3)*q*cos(b)^2))/((1 - (2*p*p + cos(b)*p*q - q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(4*p*p - 4*cos(b)*p*q + q*q)))^(1/2)*(4*pow(p,4) + 4*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q - 2*p*pow(q,3)*cos(b) + pow(q,4))^2);



JacInv[6][0] = 1;
JacInv[6][1] = 0;
JacInv[6][2] = 0;
JacInv[6][3] = -((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(sin(ph)*sin(ps) + cos(ph)*cos(ps)*sin(th))*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2))/3;
JacInv[6][4] = (cos(ps)*sin(th)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (cos(ps)*cos(th)*sin(ph)*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2))/3;
JacInv[6][5] = ((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2))/3 + (cos(th)*sin(ps)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2));
JacInv[6][6] = (cos(ps)*cos(th)*(4*p - 2*q*cos(b)))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) + (2*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(p/2 - q*cos(b)))/(3*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)) + (cos(ps)*cos(th)*(p/2 + (q*cos(b))/2)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) - (3*p*q*q*(p*p + 2*q*q)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(cos(b)^2 - 1)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)*(- p*p + cos(b)*p*q + 2*q*q))/((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(pow(p,4) - 2*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q + 4*p*pow(q,3)*cos(b) + 4*pow(q,4))^2);
JacInv[6][7] = (2*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(2*q - p*cos(b)))/(3*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)) - (cos(ps)*cos(th)*(8*q + 2*p*cos(b)))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) + (cos(ps)*cos(th)*(q/2 + (p*cos(b))/2)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) + (3*p*p*q*(p*p + 2*q*q)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(cos(b)^2 - 1)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)*(- p*p + cos(b)*p*q + 2*q*q))/((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(pow(p,4) - 2*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q + 4*p*pow(q,3)*cos(b) + 4*pow(q,4))^2);
JacInv[6][8] = (p*q*cos(ps)*sin(b)*cos(th))/(3*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) + (2*p*q*sin(b)*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th)))/(3*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)) - (p*q*cos(ps)*sin(b)*cos(th)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) + (3*p*p*q*q*sin(b)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)*(2*p*pow(q,3) - pow(p,3)*q + pow(p,4)*cos(b) + 4*pow(q,4)*cos(b) - 3*p*p*q*q*cos(b) + 2*p*pow(q,3)*cos(b)^2 - pow(p,3)*q*cos(b)^2))/((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(pow(p,4) - 2*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q + 4*p*pow(q,3)*cos(b) + 4*pow(q,4))^2);
        
        
JacInv[7][0] = 0;
JacInv[7][1] = 1;
JacInv[7][2] = 0;
JacInv[7][3] = ((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(cos(ps)*sin(ph) - cos(ph)*sin(ps)*sin(th))*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2))/3;
JacInv[7][4] = (sin(ps)*sin(th)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (cos(th)*sin(ph)*sin(ps)*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2))/3;
JacInv[7][5] = ((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(cos(ph)*sin(ps) - cos(ps)*sin(ph)*sin(th))*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2))/3 - (cos(ps)*cos(th)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2));
JacInv[7][6] = (cos(th)*sin(ps)*(4*p - 2*q*cos(b)))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (2*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(p/2 - q*cos(b)))/(3*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)) + (cos(th)*sin(ps)*(p/2 + (q*cos(b))/2)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) + (3*p*q*q*(p*p + 2*q*q)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(cos(b)^2 - 1)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)*(- p*p + cos(b)*p*q + 2*q*q))/((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(pow(p,4) - 2*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q + 4*p*pow(q,3)*cos(b) + 4*pow(q,4))^2);
JacInv[7][7] = (cos(th)*sin(ps)*(q/2 + (p*cos(b))/2)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) - (2*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(2*q - p*cos(b)))/(3*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)) - (cos(th)*sin(ps)*(8*q + 2*p*cos(b)))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (3*p*p*q*(p*p + 2*q*q)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(cos(b)^2 - 1)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)*(- p*p + cos(b)*p*q + 2*q*q))/((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(pow(p,4) - 2*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q + 4*p*pow(q,3)*cos(b) + 4*pow(q,4))^2);
JacInv[7][8] = (p*q*sin(b)*cos(th)*sin(ps))/(3*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (2*p*q*sin(b)*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th)))/(3*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)) - (p*q*sin(b)*cos(th)*sin(ps)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) - (3*p*p*q*q*sin(b)*(cos(ph)*cos(ps) + sin(ph)*sin(ps)*sin(th))*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)*(2*p*pow(q,3) - pow(p,3)*q + pow(p,4)*cos(b) + 4*pow(q,4)*cos(b) - 3*p*p*q*q*cos(b) + 2*p*pow(q,3)*cos(b)^2 - pow(p,3)*q*cos(b)^2))/((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(pow(p,4) - 2*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q + 4*p*pow(q,3)*cos(b) + 4*pow(q,4))^2);
        
        
JacInv[8][0] = 0;
JacInv[8][1] = 0;
JacInv[8][2] = 1;
JacInv[8][3] = -(cos(ph)*cos(th)*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2))/3;
JacInv[8][4] = (cos(th)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) + (sin(ph)*sin(th)*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2))/3;
JacInv[8][5] = 0;
JacInv[8][6] = (3*p*q*q*cos(th)*sin(ph)*(p*p + 2*q*q)*(cos(b)^2 - 1)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)*(- p*p + cos(b)*p*q + 2*q*q))/((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(pow(p,4) - 2*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q + 4*p*pow(q,3)*cos(b) + 4*pow(q,4))^2) - (sin(th)*(p/2 + (q*cos(b))/2)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) - (2*cos(th)*sin(ph)*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(p/2 - q*cos(b)))/(3*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)) - (sin(th)*(4*p - 2*q*cos(b)))/(6*(p*p + 2*cos(b)*p*q + q*q)^(1/2));
JacInv[8][7] = (sin(th)*(4*q + p*cos(b)))/(3*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (sin(th)*(q/2 + (p*cos(b))/2)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(3*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) - (2*cos(th)*sin(ph)*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(2*q - p*cos(b)))/(3*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)) - (3*p*p*q*cos(th)*sin(ph)*(p*p + 2*q*q)*(cos(b)^2 - 1)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)*(- p*p + cos(b)*p*q + 2*q*q))/((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(pow(p,4) - 2*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q + 4*p*pow(q,3)*cos(b) + 4*pow(q,4))^2);
JacInv[8][8] = (p*q*sin(b)*sin(th)*(- 2*p*p + 2*cos(b)*p*q + 4*q*q))/(6*(p*p + 2*cos(b)*p*q + q*q)^(3/2)) - (p*q*sin(b)*sin(th))/(3*(p*p + 2*cos(b)*p*q + q*q)^(1/2)) - (2*p*q*sin(b)*cos(th)*sin(ph)*(1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2))/(3*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)) - (3*p*p*q*q*sin(b)*cos(th)*sin(ph)*(p*p - 4*cos(b)*p*q + 4*q*q)^(1/2)*(2*p*pow(q,3) - pow(p,3)*q + pow(p,4)*cos(b) + 4*pow(q,4)*cos(b) - 3*p*p*q*q*cos(b) + 2*p*pow(q,3)*cos(b)^2 - pow(p,3)*q*cos(b)^2))/((1 - (- p*p + cos(b)*p*q + 2*q*q)^2/((p*p + 2*cos(b)*p*q + q*q)*(p*p - 4*cos(b)*p*q + 4*q*q)))^(1/2)*(pow(p,4) - 2*pow(p,3)*q*cos(b) - 8*p*p*q*q*cos(b)^2 + 5*p*p*q*q + 4*p*pow(q,3)*cos(b) + 4*pow(q,4))^2)];
