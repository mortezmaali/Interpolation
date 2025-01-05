load('Ref_Macbeth24.mat')
load('Ref_new2.mat')
load('Ref_training.mat')

lightSource;
E=D65(:,1:2:61);

XYZ=(100/(E*COL(:,2)))*COL'*(diag(E))*Ref(3:33,:);
sRGB130 = xyztosrgb(XYZ);

XYZ=(100/(E*COL(:,2)))*COL'*(diag(E))*RefTrain(3:33,:);
sRGB140 = xyztosrgb(XYZ);

XYZ=(100/(E*COL(:,2)))*COL'*(diag(E))*RefT(3:33,:);
sRGB24 = xyztosrgb(XYZ);

% Plotting in a 3D sRGB space
figure;
hold on;

% Scatter plot for each color chart in different colors
scatter3(sRGB130(1,:), sRGB130(2,:), sRGB130(3,:), 36, 'r', 'filled'); % Red for sRGB130
scatter3(sRGB140(1,:), sRGB140(2,:), sRGB140(3,:), 36, 'g', 'filled'); % Green for sRGB140
scatter3(sRGB24(1,:), sRGB24(2,:), sRGB24(3,:), 36, 'b', 'filled');    % Blue for sRGB24

% Labeling axes
xlabel('sRGB Red');
ylabel('sRGB Green');
zlabel('sRGB Blue');

% Set limits to match sRGB range (0 to 1)
xlim([0 1]);
ylim([0 1]);
zlim([0 1]);

% Add grid, title, and legend for context
grid on;
title('3D Plot of sRGB Color Charts');
legend('sRGB130', 'sRGB140', 'sRGB24');

% Set view angle for 3D effect
view(3); % Default 3D view
axis vis3d; % Locks the aspect ratio for rotation

% Enable rotation for a better 3D view
rotate3d on;

hold off;