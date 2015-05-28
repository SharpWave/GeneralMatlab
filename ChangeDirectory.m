function [] = ChangeDirectory(sess_date,sess_num)

if(~exist('sess_num'))
    sess_num = 1;
end

CurrDir = pwd;

MasterDirectory = 'E:\MasterData';
cd(MasterDirectory);

load MD.mat;

cd(CurrDir);

NumEntries = length(MD);

for i = 1:NumEntries
    if (strcmp(MD(i).Date,'sess_date') & MD(i).Session == sess_num)
        cd(MD(i).Location);
        return;
    end
end

display('Directory not found');