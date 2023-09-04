function P = LGP_gen_Patchsum_n(im_row,im_col,patchsize)
% patchsize: odd input only & 3 min
row_seq = [];
col_seq = [];
value_seq = [];
r = (patchsize + 1) / 2;

for j=1:im_col
    for i=1:im_row
        ind = (i+(j-1)*im_row);

%         if i==1 || j==1 || i==im_row || j==im_col

        index_col = [];
        for patch_j = (j-r+1):(j+r-1)
            for patch_i = (i-r+1):(i+r-1)
                if patch_i < 1 || patch_i > im_row || patch_j < 1 || patch_j > im_col
                    continue;
                else
                    pos = patch_i + (patch_j-1) * im_row;
                    index_col = [index_col, pos];
                end
            end
        end
        col_seq = [col_seq, index_col];
        n = length(index_col);
        row_seq = [row_seq, repmat(ind,1,n)];
        value_seq = [value_seq, repmat(1/n,1,n)]; 
                
    end
end

P = sparse(row_seq,col_seq,value_seq);

end