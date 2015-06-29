#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <iostream>
#include <fstream>
#include <sstream>
using namespace std;

double vectorDistance(double *s, double *t, int ns, int nt, int k, int i, int j)
{
    double result=0;
    double ss,tt;
    int x;
    for(x=0;x<k;x++){
        ss=s[i+ns*x];
        tt=t[j+nt*x];
        result+=((ss-tt)*(ss-tt));
    }
    result=sqrt(result);
    return result;
}

double dtw_c(double *s, double *t, int w, int ns, int nt, int k)
{
    double d=0;
    int sizediff=ns-nt>0 ? ns-nt : nt-ns;
    double ** D;
    int i,j;
    int j1,j2;
    double cost,temp;
    
    /* printf("ns=%d, nt=%d, w=%d, s[0]=%f, t[0]=%f\n",ns,nt,w,s[0],t[0]); */
    
    if(w!=-1 && w<sizediff) w=sizediff; /* adapt window size */
    
    /* create D */
    D=(double **)malloc((ns+1)*sizeof(double *));
    for(i=0;i<ns+1;i++){
        D[i]=(double *)malloc((nt+1)*sizeof(double));
    }
    
    /* initialization */
    for(i=0;i<ns+1;i++){
        for(j=0;j<nt+1;j++){
            D[i][j]=-1;
        }
    }
    D[0][0]=0;
    
    /* dynamic programming */
    for(i=1;i<=ns;i++){
        if(w==-1){
            j1=1;
            j2=nt;
        }
        else
        {
            j1= i-w>1 ? i-w : 1;
            j2= i+w<nt ? i+w : nt;
        }
        for(j=j1;j<=j2;j++)
        {
            cost=vectorDistance(s,t,ns,nt,k,i-1,j-1);
            
            temp=D[i-1][j];
            if(D[i][j-1]!=-1){
                if(temp==-1 || D[i][j-1]<temp) temp=D[i][j-1];
            }
            if(D[i-1][j-1]!=-1){
                if(temp==-1 || D[i-1][j-1]<temp) temp=D[i-1][j-1];
            }       
            D[i][j]=cost+temp;
        }
    }
    
    d=D[ns][nt];
    
    /* free D */
    for(i=0;i<ns+1;i++){
        free(D[i]);
    }
    free(D);    
    return d;
}

void arkread(const char* filename,double* data){
	string line,tok;
	ifstream file(filename);

	getline(file,line);
	for(int i=0;i<98;i++){	// frame i
		getline(file,line);
		istringstream iss(line);
		//cout << line <<endl;
		for(int j=0;j<13;j++){  // element j
			iss >> tok;
			data[i+98*j] = stod(tok);
		}
	}
}

main ( int arc, char **argv ) {
	ifstream file("../wav/wav.scp");
	string id,fpath,tmp,_class;
	double best_d = 10000,*s = new double [98*13],*t = new double [98*13],d;
	int w = 50,dim = 13,nframe = 98;
	
	arkread(argv[1],s);	// read test file
	while(file >> id >> fpath){
		tmp = "../feature/"+ id + ".ark";
		//cout << tmp << endl;
		arkread( tmp.c_str(),t ); // read template file
		d=dtw_c(s,t,w,nframe,nframe,dim);
		if(d < best_d){
			best_d = d;
			_class = id;
		}
		cout << id << " score = " << d << endl;
	}

	cout << _class << endl;

	return 0;
}
