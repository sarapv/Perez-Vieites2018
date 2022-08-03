function Znew = fLZ(x,z,F,C,B,H,nosc,fps)
% fLZ integrates the fast state using both x and z variables
%   
% Inputs
%   x   : previous slow state vector
%   z   : previous fast state vector
%   F   : model parameter
%   C   : model parameter
%   B   : model parameter
%   H   : model parameter
%   nosc    : dimension of the slow state
%   fps     : number of fast states per slow state
%
% Outputs
%   Znew    : new state vector


% initialisation
nosc_fast = nosc*fps;
Znew = zeros(nosc_fast,1);

% 3 problematic cases: 1,2,N
id_x = 1;
Znew(1)=C*B*z(2)*(z(nosc_fast) - z(3)) - C*z(1) + (C*H/B)*x(id_x)+ F*C/B;
id_x = nosc;
Znew(nosc_fast-1)=  C*B*z(nosc_fast)*(z(nosc_fast-2) - C*z(1)) - z(nosc_fast-1) + (C*H/B)*x(id_x) + F*C/B;
Znew(nosc_fast)= C*B*z(1)*(z(nosc_fast-1) - z(2)) - C*z(nosc_fast) + (C*H/B)*x(id_x) + F*C/B;

%  general case
for j=2:nosc_fast-2
    id_x = 1 + floor(j/fps);
    Znew(j)= C*B*z(j+1)*(z(j-1) - z(j+2)) - C*z(j)  + (C*H/B)*x(id_x) + F*C/B;
end


end