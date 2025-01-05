% Combine all data into a single matrix
all_sRGB = [sRGB130, sRGB140, sRGB24];
Reflec = [Ref(3:33,:),RefTrain(3:33,:),RefT(3:33,:)];
% Create a Delaunay triangulation object for 3D convex hull
dt = delaunayTriangulation(all_sRGB(1, :)', all_sRGB(2, :)', all_sRGB(3, :)');
[k, ~] = convexHull(dt);

% Initialize test set (sRGB_te) and training set (sRGB_tr)
sRGB_te = [];
sRGB_tr = [];
Ref_te = [];
Ref_tr = [];


% Check each point to determine if it's strictly inside the convex hull
for i = 1:size(all_sRGB, 2)
    % Use pointLocation to test if each point is inside the convex hull
    tetrahedronIndex = dt.pointLocation(all_sRGB(:, i)');
    
    % If tetrahedronIndex is not NaN, the point is inside
    if ~isnan(tetrahedronIndex) && size(sRGB_te, 2) < 30
        sRGB_te = [sRGB_te, all_sRGB(:, i)]; % Add to sRGB_te if within limit
        Ref_te = [Ref_te, Reflec(:, i)]; % Add to sRGB_te if within limit

    else
        sRGB_tr = [sRGB_tr, all_sRGB(:, i)]; % Otherwise, add to sRGB_tr
        Ref_tr = [Ref_tr, Reflec(:, i)]; % Otherwise, add to sRGB_tr

    end
end

% Plot sRGB_te and sRGB_tr in a new figure
figure;
hold on;

% Plot sRGB_te in one color (e.g., magenta)
scatter3(sRGB_te(1, :), sRGB_te(2, :), sRGB_te(3, :), 36, 'm', 'filled');

% Plot sRGB_tr in another color (e.g., cyan)
scatter3(sRGB_tr(1, :), sRGB_tr(2, :), sRGB_tr(3, :), 36, 'c', 'filled');

% Label axes
xlabel('sRGB Red');
ylabel('sRGB Green');
zlabel('sRGB Blue');

% Set axis limits to sRGB range
xlim([0 1]);
ylim([0 1]);
zlim([0 1]);

% Additional plot settings
grid on;
title('3D Plot of sRGB_te (inside gamut) and sRGB_tr (outside gamut)');
legend('sRGB_te', 'sRGB_tr');

% Set view angle for 3D effect
view(3);
axis vis3d;
rotate3d on;

hold off;
