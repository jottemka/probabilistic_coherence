% This function calculates the degree of coherence of a set of binary random variables x under some joint probability distribution y. Notice that y has to have a canonical structure, for instance, for three valiables, the probabilities in y correspond to the Boolean combinations 000,001,010,011,100,101,110,111. Also notice that if y has multiple rows, the function output is ordered accordingy. Example: let y=[1/8,1/8,1/8,1/8,1/8,1/8,1/8,1/8], then coh([1,2],y) calculates the degree of coherence of variables number 1 and 2 relative to y.

function val=coh(x,y)
warning off;

% Binary matrices of all possible states
b=(dec2bin(0:(size(y,2)-1),log2(size(y,2)))=="1")(:,[x]);
c=(dec2bin(0:(size(y,2)-1),log2(size(y,2)))=="1");

% Selection matrix for all non-empty, non-singleton subsets of x
s=unique(b(sum(b,2)>=2,:),"rows"); 

% Selection matrix for all non-empty, non-overlapping subsets
t=unique(b(1:end-1,:)(sum(b(1:end-1,:),2)>=1,:),"rows");

% Calculating relevant values for all subsets of x and all distributions
p_mar=y*b; % All |x| marginal probabilities for |y| distributions
p_neg=y*not(b); % All negated |x| marginal probabilities for |y| distributions

for i=1:size(s,1)
	p_con(:,i)=sum(y(:,all(c(:,x(s(i,:))),2)),2); % Joint probabilities for all subsets of x
	p_dis(:,i)=sum(y(:,any(c(:,x(s(i,:))),2)),2); % Disjunctive probabilities for all subsets of x
	p_spe(:,i)=prod(p_mar(:,s(i,:)),2); % Specificity (product of marginals) of all subsets of x
	p_spn(:,i)=prod(1.-p_mar(:,s(i,:)),2);
	weight(i,:)=nchoosek(size(x,2),sum(s(i,:))); % Weight vector for Schupbach's measure
endfor

% Ratio-wise deviation from independece
dfi_rat=p_con./p_spe;

% Difference-wise deviation from independence
dfi_dif=p_con.-p_spe; 

% Relative overlap for all distributions
rol_rat=p_con./p_dis; % Ratio-wise relative overlap

% Shogenji's (1999) coherence measure
sho=dfi_rat(:,end);

% Carnap's (1950) relevance measure (generalized) 
car=dfi_dif(:,end); 

% Schupbach's (2011) variation of Shogenji's measure
sch=(log10(dfi_rat)*(1./weight))/(size(x,2)-1); 

% Koscholke's (2016) variation of Carnap's measure
kos=(dfi_dif*(1./weight))/(size(x,2)-1); 

% Glass' (2002) and Olsson's (2002) measure
go=rol_rat(:,end); 

% Meijs' (2006) measure
mei=mean(rol_rat,2);

% Collecting the values
val=[sho,sch,car,kos,go,mei];

endfunction
