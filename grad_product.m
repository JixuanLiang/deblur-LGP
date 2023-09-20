function map_product = grad_product(gx, gy)
[M, N] = size(gx);
map_product = zeros(size(gx));

for i=1:M
    for j=1:N
        if i==1 || j==1 || i==M || j==N
            map_product(i,j)= 0;
        else
            g0 = [gx(i,j),gy(i,j)]; % g5
            g1 = [gx(i-1,j-1),gy(i-1,j-1)];
            g2 = [gx(i-1,j),gy(i-1,j)];
            g3 = [gx(i-1,j+1),gy(i-1,j+1)];
            g4 = [gx(i,j-1),gy(i,j-1)];
            g6 = [gx(i,j+1),gy(i,j+1)];
            g7 = [gx(i+1,j-1),gy(i+1,j-1)];
            g8 = [gx(i+1,j),gy(i+1,j)];
            g9 = [gx(i+1,j+1),gy(i+1,j+1)];
            map_product(i,j) = dot(g0,g1) + dot(g0,g2) + ...
                dot(g0,g3) + dot(g0,g4) + dot(g0,g6) + dot(g0,g7) + ...
                dot(g0,g8) + dot(g0,g9); % dot(g0,g0) + 
        end
    end
end