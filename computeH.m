function H = computeH(t1, t2)
    [~, n] = size(t1);
    x1 = t1(1,:);
    y1 = t1(2,:);
    x2 = t2(1,:);
    y2 = t2(2,:);
    
    A = [];
    for i = 1:n
       A_i = [...
           x1(i), y1(i), 1, 0, 0, 0, -x2(i)*x1(i), -x2(i)*y1(i), -x2(i); ...
           0, 0, 0, x1(i), y1(i), 1, -y2(i)*x1(i), -y2(i)*y1(i), -y2(i)];
       A = [A; A_i];
    end
    
    ATA = transpose(A)*A;
    [V, D] = eig(ATA);
    
    D = diag(D);
    [~, i] = min(D);
    
    H = V(:,i);
    H = [H(1:3) H(4:6) H(7:9)]';
end