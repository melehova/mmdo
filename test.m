c = '@(x) (10 - x)^2 + 3';
fh = str2func(c)

fh(10)
fileID = fopen('temp.txt', 'a+');
content = fscanf(fileID,"%s");

f = fopen('temp.txt');
file_data = textscan(f, '%s', 'Delimiter', '')
file_data(1)
fclose(f);