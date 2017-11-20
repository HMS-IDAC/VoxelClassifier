function v = platonicSolidVertices(n,r)

% n=1 -> Tetrahedron
% n=2 -> Cube
% n=3 -> Octahedron
% n=4 -> Icosahedron
% n=5 -> Dodecahedron
%
% r = radius
%
% 
% Example:
% v = platonicSolidVertices(3,2);
% plot3(v(:,1),v(:,2),v(:,3),'*','MarkerSize',10), hold on
% [x,y,z] = sphere(10);
% surf(x,y,z), alpha(0.1), hold off
% axis equal, axis off
% rotate3d on
% 
% Adapted from ...
% https://www.mathworks.com/matlabcentral/fileexchange/28213-platonic-solid
% Kevin Mattheus Moerman
% kevinmoerman@hotmail.com
% 13/11/2009
% ... by ...
% Marcelo Cicconet, Nov 2017
% ------------------------------------------------------------------------

phi=(1+sqrt(5))/2;

switch n
    case 1 % Tetrahedron (4 vertices)
        V1=[-0.5;0.5;0;0;];
        V2=[-sqrt(3)/6;  -sqrt(3)/6; sqrt(3)/3; 0];
        V3=[-0.25.*sqrt(2/3); -0.25.*sqrt(2/3); -0.25.*sqrt(2/3);  0.75.*sqrt(2/3)];

    case 2 % Octahedron (6 vertices)
        V1=[-1;  1; 1; -1;  0;   0;];
        V2=[-1; -1; 1;  1;  0;   0;];
        V3=[ 0;   0; 0;  0; -1;  1;];
        
    case 3 % Cube (8 vertices)
        V1=[-1;  1; 1; -1; -1;  1; 1; -1;];
        V2=[-1; -1; 1;  1; -1; -1; 1;  1;];
        V3=[-1; -1;-1; -1;  1;  1; 1;  1;];

    case 4 % Icosahedron (12 vertices)
        V1=[0;0;0;0;-1;-1;1;1;-phi;phi;phi;-phi;];
        V2=[-1;-1;1;1;-phi;phi;phi;-phi;0;0;0;0;];
        V3=[-phi;phi;phi;-phi;0;0;0;0;-1;-1;1;1;];

    case 5 % Dodecahedron (20 vertices)
        V1=[1;(1/phi);-phi;phi;-1;0;-phi;1;-1;-1;1;(1/phi);-1;0;0;-(1/phi);phi;-(1/phi);1;0;];
        V2=[1;0;-(1/phi);(1/phi);1;-phi;(1/phi);-1;1;-1;-1;0;-1;-phi;phi;0;-(1/phi);0;1;phi;];
        V3=[1;phi;0;0;-1;-(1/phi);0;1;1;1;-1;-phi;-1;(1/phi);-(1/phi);phi;0;-phi;-1;(1/phi);];

    otherwise
        error('n should be in {1,2,...,5}')
end

[THETA,PHI]=cart2sph(V1,V2,V3);
R=r.*ones(size(V1(:,1)));
[V1,V2,V3]=sph2cart(THETA,PHI,R);
v=[V1 V2 V3];

end