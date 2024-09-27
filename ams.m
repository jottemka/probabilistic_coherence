% This function calculates the degree of average mutual confirmation of a set of binary random variables x under some joint probability distribution y. It depends on the sup.m funciton. Notice that y has to have a canonical structure, for instance, for three valiables, the probabilities in y correspond to the Boolean combinations 000,001,010,011,100,101,110,111. Also notice that if y has multiple rows, the function output is ordered accordingy. Example: let y=[1/8,1/8,1/8,1/8,1/8,1/8,1/8,1/8], then coh([1,2],y) calculates the degree of coherence of variables number 1 and 2 relative to y.

function val=ams(x,y)

% Binary matrices
b=(dec2bin(0:(size(y,2)-1),log2(size(y,2)))=="1")(:,[x]);
t=unique(b(1:end-1,:)(sum(b(1:end-1,:),2)>=1,:),"rows");

% Preparing the columns
col=zeros(size(y,1),size(sup(1,2,y(1,:))));

% Going through each pair of non-empty, non-overlapping subsets of x
for i=1:size(t,1)
	u=t(not(any(t(:,t(i,:)),2)),:);
	for j=1:size(u,1)
		col=col.+sup(x(t(i,:)),x(u(j,:)),y);
	endfor
endfor

% Averaging
val=col./(3^size(x,2)-2^(size(x,2)+1)+1);
endfunction
