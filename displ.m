function [] = displ(X)
    fileID = fopen('temp.txt','a+');
    fprintf(fileID, '%s\n', X);
    fclose(fileID);
    disp(X)
end