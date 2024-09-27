% This function calculates the degree of support a binary random variable x1 with integer index x is provided by another variable x2 with integer index y under some joint probability distribution z given as a row vector with canonical structure according to matrix b. Notice that if z has multiple rows, the function output is ordered accordingy. For example, let y=[1/8,1/8,1/8,1/8,1/8,1/8,1/8,1/8], then sup(1,2,z) calculates the degree of coherence of propositions 1 and 2 relative to z.

function val=sup(x,y,z)
warning off;

% Binary Matrices
b=dec2bin(0:(size(z,2)-1),log2(size(z,2)))=="1";

% Matrix for x1
bx=all(b(:,abs(x))==(sign(x)+1)/2,2);

% Matrix for x2			
by=all(b(:,abs(y))==(sign(y)+1)/2,2); 			

% Joint Probabilities
p00=sum(z(:,all([bx,by]==[0,0],2)),2); 		
p01=sum(z(:,all([bx,by]==[0,1],2)),2);			
p10=sum(z(:,all([bx,by]==[1,0],2)),2); 			
p11=sum(z(:,all([bx,by]==[1,1],2)),2);			

% Marginal Probabilities
p1x=p11.+p10; 							
p0x=p00.+p01; 							
px1=p11.+p01; 							
px0=p00.+p10; 							

% Conditional Probabilities

% P(x1|x2)
p12=p11./px1; 

% P(x2|x1)							
p21=p11./p1x;

% P(x2|~x1) 						
p2n1=p01./p0x;

% P(x1|~x2)						
p1n2=p10./px0;

% P(~x1|x2) 						
pn12=p01./px1;

% P(~x2|x1)						
pn21=p10./p1x;

% P(~x1|~x2)								
pn1n2=p00./px0;

% P(~x2|~x1)	
pn2n1=p00./p0x;

% Keynes' (1921) relevance quotient
RQ=p12./p1x;	 						

% Carnap's (1950) difference function
DF=p12.-p1x; 	

% Carnap's (1950) relevance measure						
RM=p11.-(p1x.*px1); 

% Kemeny and Oppenheim's (1952) factual support measure						
FS=(p21.-p2n1)./(p21.+p2n1);

% Popper's (1954) degree of confirmation measure		
DC=(p21.-px1)./(p21.+px1).*(1.+p1x.*p12);

% Rescher's (1958) evidential support measure
DES=((p12.-p1x)./((p12>=p1x).-((sign(p12>=p1x).*2-1).*p1x))).*px1;

% Gaifman's (1979) confirmation rate	
CR=p0x./pn12;

% Nozick's (1981) counterfactual likelihood difference						
CLD=p21.-p2n1;

% Good's (1984) likelihood ratio 						
LR=p21./p2n1;

% Mortimer's (1988) inverted difference measure					
IDF=p21.-px1;

% Christensen's (1999) likelihood difference measure							
LD=p12.-p1n2;

% Crupi et al.'s (2007) Z-measure					
Z=(p12.-p1x)./((p12>=p1x).-((sign(p12>=p1x).*2-1).*p1x));

% Shogenji's (2012) epistemic justification measure
EJ=(log2(p12).-log2(p1x))./-log2(p1x);

% Schippers' normalized likelihood difference
NLD=(p12.-p1n2)./((p12>=p1x).-((sign(p12>=p1x).*2-1).*p1n2));

val=[RQ,DF,RM,FS,DC,DES,CR,CLD,IDF,LD,Z,EJ,NLD];

endfunction
