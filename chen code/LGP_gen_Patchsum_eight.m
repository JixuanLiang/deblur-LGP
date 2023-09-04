function P = LGP_gen_Patchsum_eight(im_row,im_col)

row_seq = [];
col_seq = [];
value_seq = [];

for j=1:im_col
    for i=1:im_row
        ind = (i+(j-1)*im_row);

        if i==1 || j==1 || i==im_row || j==im_col
            continue;
        else
            n = 8;
            row_seq = [row_seq,repmat(ind,1,n)];
            col_seq = [col_seq,ind-im_row-1,ind-im_row,ind-im_row+1,...
                ind-1,ind+1,ind+im_row-1,ind+im_row,ind+im_row+1];
            value_seq = [value_seq,repmat(1/n,1,n)];
        end
                
    end
end

P = sparse(row_seq,col_seq,value_seq, im_row*im_col, im_row*im_col);

end