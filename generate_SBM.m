 function generate_SBM(Groups,P_adj)
% generate_SBM��[10 20 30],[0.5 0.01 0.01,0.02 0.5 0.01,0.01 0.01 0.5]��
% ��ݿ����Ӹ������������ڽӾ���,ֻ����������;
% ���룺
% Groups��һ����ڵ�������飬Ԫ����ĿΪ����Ŀ���ÿ��Ԫ�ص�ֵΪ��Ӧ��Ľڵ�����;
% P_adj�ǿ����Ӹ��ʾ���ָ��������������Ӹ���
% �����
% Adj�����������ڽӾ���
% Z�ڵ�Ŀ�ָʾ����
%%%%%%%%%%%%%%%%%%%%%%%
type = 1; % �����нṹ���ͣ�1������ 2����� 3�����
K = 5; %c�������п���
k1 = round(K/2);
%k2 = c-k1;%���ڻ�Ͻṹ
s = 60000/K; %s�ǿ��нڵ���
%��ɿ����Ӹ��ʾ���
Groups = ones(K,1)*s;
N = sum(Groups);
p1 = 56/s; %p1��p2��ʾ���������Ӹ���
p2 = 8/(s*(K-1)); 
%���ÿ�����Ӿ���
P_adj = zeros(K,K);
if type == 1
    for i=1:K
        for j=1:K
            if i==j
                P_adj(i,j)=p1;
            else
                P_adj(i,j)=p2;
            end
        end
    end
end

if type==2
    for i=1:K
        for j=1:K
            if i==j
                P_adj(i,j)=p2;
            else
                P_adj(i,j)=p1;
            end
        end
    end
end

if type==3
    for i=1:k1
        for j=1:k1
            if i==j
                P_adj(i,j)=p1;
            else
                P_adj(i,j)=p2;
            end
        end
        for j = k1+1:K
            P_adj(i,j)=p2;
        end
    end
    for i = k1+1:K
        for j = 1:k1
            P_adj(i,j)=p2;
        end
        for j = k1+1:K
            if i==j
                P_adj(i,j)=p2;
            else
                P_adj(i,j)=p1;
            end
        end
    end
end


for M=2:2
    halfedgefile=strcat('../data/20180506/rate/T=',num2str(type),'_N=',num2str(N),'_K=',num2str(K),'_M=',num2str(M),'_halfedge.dat');%����ļ�strcat('data/test_',num2str(h),'.dat');
    fulledgefile=strcat('../data/20180506/rate/T=',num2str(type),'_N=',num2str(N),'_K=',num2str(K),'_M=',num2str(M),'_fulledge.dat');%����ļ�
    labelfile=strcat('../data/20180506/rate/T=',num2str(type),'_N=',num2str(N),'_K=',num2str(K),'_M=',num2str(M),'_Label.dat');%����ļ�

%     A=rand(num,num);%�����Ӧ��С����������
%     A=speye(num,num);
    A=[];
    for i=1:K
        i
        for j=i:K
            A1=rand(s,s);
            A1(A1<=P_adj(i,j))=1;
            A1(A1>P_adj(i,j)&A1<1)=0;
            if i==j
            A1=A1-diag(diag(A1));
            A1=triu(A1);
            end
            [row,col,val]=find(A1==1);
            A11=[row+(i-1)*s,col+(j-1)*s,val];
            A=[A;A11]; % ֻ����һ��ı�
        end
    end
    A12=[A(:,2),A(:,1),A(:,3)];
    A_full=[A;A12];
    Z=zeros(N,1);
    pos=0;
    for k1=1:K
        if k1==1
            pos=1;
        else
            pos=pos+Groups(k1-1);
        end        
        for i=pos:pos+Groups(k1)-1
            Z(i,:)=k1;        
        end
    end
     dlmwrite(halfedgefile,A,'delimiter',' ');%���һ��ߣ�������������ĳ���
     dlmwrite(fulledgefile,A_full,'delimiter',' ');%������бߣ�������������ĳ���
     dlmwrite(labelfile,Z,'delimiter',' ');%����ڵ������Ŀ�   
     
end




