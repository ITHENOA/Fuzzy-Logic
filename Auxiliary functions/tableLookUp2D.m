function tableLookUp2D(U,par,rule,mf_type,X_train,X_test)
%   INPUT
% par {n_dim}(n_mf(dim),params) : mf parameters like a,b,c,...
% rule (n_rule,dim)
% mf_type (string) : type of membership functions
% Optional :: X_train (n_data,dim)
% Optional :: X_test (n_data,dim)
%
%   OUTPUT
% plot table look-up

tr = 0;
ts = 0;
if nargin > 4, tr = 1; end
if nargin > 5, ts = 1; end


switch lower(mf_type)
    case {'tri','triangular'}
        figure
        xlim([U(1,1),U(1,2)])
        ylim([U(2,1),U(2,2)])
        grid on
        hold on
        M = size(rule,1);
        for r = 1:M
            x = [par{1}(rule(r,1),1) par{1}(rule(r,1),1) par{1}(rule(r,1),3) par{1}(rule(r,1),3) par{1}(rule(r,1),1)];
            y = [par{2}(rule(r,2),1) par{2}(rule(r,2),3) par{2}(rule(r,2),3) par{2}(rule(r,2),1) par{2}(rule(r,2),1)];
            rul = fill(x,y,[0 0.4470 0.7410],'FaceAlpha',0.2,DisplayName='Rules');
            center_x = mean([par{1}(rule(r,1),1),par{1}(rule(r,1),3)]);
            center_y = mean([par{2}(rule(r,2),1),par{2}(rule(r,2),3)]);
            text_str = "R"+r;
            text(center_x, center_y, text_str, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Color', 'k');
        end
        legend(rul,'Location','Best')
        if tr
            scatter(X_train(:,1),X_train(:,2),'r','filled','DisplayName','Xtrain');
        end
        if ts
            scatter(X_test(:,1),X_test(:,2),'b','filled',DisplayName='Xtest');
        end
        title("Table Look-up 2D, #Rule="+M)
        xlabel('X1')
        ylabel('X2')
        hold off
    otherwise
        error('Enter Valid mf_type.')
end