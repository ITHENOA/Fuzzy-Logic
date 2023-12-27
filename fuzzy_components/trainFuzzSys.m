% Example 1:
%       >> baseFS = trainFuzzSys(o.X_train,o.y_train)
%       >> optimalFS = baseFS.optimal('gauss',2)
%       >> y_estimate = optimalFS.test(x_test)
classdef trainFuzzSys
    properties
        X_train
        y_train
        n_data
        n_dim
        sysType
        % RuleMF
        % ybars
        Results %{A},{B},{clusCenter},{clusLabel},{n_clus},{dataCluster}
    end

    methods

        %% Construct function
        function o = trainFuzzSys(X_train, y_train)
            o.n_data = numel(y_train);
            o.X_train = reshape(X_train,o.n_data,[]);
            o.n_dim = size(o.X_train,2);
            o.y_train = reshape(y_train,[],1);
        end

        %% OPTIMAL
        function  o = optimal(o,mf_type,distance)
            % WANG book ; Section 15.1

            % mf_type (string)
            % distance vector(1,dim) or scaler(1,1) : distanse for each dim. see @get_systematic_par function

            o.sysType = 'Optimal';
            par = get_systematic_par(mf_type,[o.X_train o.y_train],distance);
            MFs = get_mf_bigmtx(mf_type,par);
            rule = (1:o.n_data)' .* ones(o.n_data,size(o.X_train,2)+1);
            o.Results.RuleMF = get_mfRule_bigmtx(rule,MFs);
            o.Results.ybars = o.y_train;
        end

        %% TABLE LOOK-UP SCHEME
        function o = tableLookUpScheme(o,mf_type,par)
            % WANG book ; Chapter 12

            % mf_type (string)
            % par {dim}(n_mf,n_par) : can create by @get_mf_par

            o.sysType = 'TableLookUpScheme';
            MFs = get_mf_bigmtx(mf_type,par);
            [rules, star_value] = get_rule(MFs,[o.X_train o.y_train]);
            rules = ruleReduction(rules,star_value);
            o.Results.RuleMF = get_mfRule_bigmtx(rules,MFs);
            switch lower(mf_type)
                case {'tri','triangular'}
                    o.Results.ybars = par{end}(:,2);
                case {'gauss','gaussian'}
                    o.Results.ybars = par{end}(:,1);
            end
        end

        %% CLUSTERING
        function o = Clustering(o,r,taw)
            % WANG book ; Chapter 15

            % r : radius
            % taw : forgetting factor

            o.sysType = 'Cluster';
            if nargin < 3; taw = 1; end

            % construct variables
            clusCenter = zeros(o.n_data, o.n_dim);
            clusLabel = zeros(o.n_data, 1);
            A = zeros(1,o.n_data);
            B = A;
            dataCluster = zeros(o.n_data, 1);

            % Step 1
            clusCenter(1,:) = o.X_train(1,:);  % First Claster Center
            clusLabel(1) = o.y_train(1);
            dataCluster(1) = 1;                 % cluster name of first data
            M = 1;
            A(1) = o.y_train(1);    % A (#point,#cluster)
            B(1) = 1;               % B (#point,#cluster)

            % Step 2
            for k = 2:o.n_data
                [minVal,winClus] = min(Distance.Euclidian(o.X_train(k,:),clusCenter(1:M,:)));

                if minVal > r
                    M = M + 1;                  % Add new Cluster
                    clusCenter(M,:) = o.X_train(k,:);  % Add new Center
                    clusLabel(M) = o.y_train(k);
                    A(M) = o.y_train(k);
                    B(M) = 1;
                else
                    A(winClus) = A(winClus) + o.y_train(k);
                    B(winClus) = B(winClus) + 1;

                    % with Forgetting Factor                               ??
                    % A(1:M) = ((taw-1)/taw) * A(1:M);
                    % B(1:M) = ((taw-1)/taw) * B(1:M);
                    % A(winClus) = ((taw-1)/taw) * A(winClus) + (1/taw) * o.y_train(k);
                    % B(winClus) = ((taw-1)/taw) * B(winClus) + (1/taw) * 1;
                end
                dataCluster(k) = M;     % cluster name of k-th data
            end
            % save variables
            o.Results.clusCenter = clusCenter(1:M,:);
            o.Results.clusLabel = clusLabel(1:M);
            o.Results.A = A(1:M);
            o.Results.B = B(1:M);
            o.Results.n_clus = M;
            o.Results.dataCluster = dataCluster;
        end

        %% Clustering rule
        function o = Clustering2(o,r,mf_type,varargin)
            % construct variables
            clusCenter = zeros(o.n_data, o.n_dim);
            clusLabel = zeros(o.n_data, 1);

            % Step 1
            clusCenter(1,:) = o.X_train(1,:);  % First Claster Center
            clusLabel(1) = o.y_train(1);
            M = 1;

            % Step 2
            for k = 2:o.n_data
                minVal = min(Distance.Euclidian(o.X_train(k,:),clusCenter(1:M,:)));

                if minVal > r
                    M = M + 1;                  % Add new Cluster
                    clusCenter(M,:) = o.X_train(k,:);  % Add new Center
                    clusLabel(M) = o.y_train(k);
                end
            end
            o.Results.clusRadius = r;
            o.Results.clusCenter = clusCenter(1:M,:);
            o.Results.clusLabel = clusLabel(1:M);
            o.Results.n_clus = M;
            o = setMFtoCluster(o,mf_type,varargin);
        end

        function o = setMFtoCluster(o,mf_type,varargin)

            switch lower(mf_type)
                case {'gauss','gaussian'}
                     
                    var = cell2mat(varargin{1});
                    if numel(varargin{1})==1
                        varargin{1} = ones(1,o.n_dim) * var;
                    else
                        if numel(varargin{1}) ~= o.n_dim
                            error('Enter one or as many dimensions.')
                        end
                    end

                    par = cell(1,o.n_dim);
                    for d = 1:o.n_dim
                        par{d}(:,1) = o.Results.clusCenter(:,d);
                        par{d}(:,2) = deal(varargin{1}(d));
                    end

                    rule = (1:o.Results.n_clus)' .* ones(o.Results.n_clus,o.n_dim+1);
                    MFs = get_mf_bigmtx(mf_type,par);
                    o.Results.RuleMF = get_mfRule_bigmtx(rule,MFs);
                    o.Results.ybars = o.Results.clusLabel;
                    o.sysType = 'Cluster2';
            end
        end

        %% TEST function
        function output = test(o,X_test,clusterPar)
            %   INPUT
            % X_test (#data, #dim)
            % clusterPar (scaler) : sigma for gaussian mf
            %
            %   OUTPUT
            % output.regression (#Xtest,1) : estimated f(x)
            % output.clustering (#Xtest,1)  : estimated cluster name
            % output.classification (#Xtest,1) : label of clusters's center

            if nargin < 3 && strcmpi(o.sysType,'Cluster')
                error("Cluster method need 'sigma' parameter.")
            end

            X_test = reshape(X_test, [], o.n_dim);
            n_x = size(X_test, 1);  % Number of test data


            switch o.sysType
                case 'Cluster'
                    n_clus = o.Results.n_clus;  % Number of clusters
                    c = o.Results.clusCenter;   % value of cluster centers
                    A = o.Results.A;
                    B = o.Results.B;
                    Mu = zeros(n_x, n_clus); % (#point, #cluster)
                    xDist = Mu; % for cluster output
                    sigma = clusterPar;
                    for j = 1:n_x
                        Mu(j,:) = exp(-(Distance.Euclidian(X_test(j,:),c)).^2/sigma); % (#point, #cluster)
                        xDist(j,:) = Distance.Euclidian(X_test(j,:),c);
                    end
                    p = sum(A .* Mu,2);
                    q = sum(B .* Mu,2);
                    % for j = 1:n_x
                    %     Mu(:,:,j) = MF('gauss',o.c,2).membership(X_test(j,:));
                    %     p(j,:) = sum(o.A(end,:)' .* Mu(:,:,j));
                    %     q(j,:) = sum(o.B(end,:)' .* Mu(:,:,j));
                    % end
                    output.regression = p./q;

                    [~,idx] = min(xDist,[],2);
                    output.clustering = idx;
                    % output.classification = o.Results.clusLabel(idx);

                case {'Optimal', 'TableLookUpScheme','Cluster2'}
                    % by centroid system
                    output = FS.COAdefuzz(X_test, o.Results.RuleMF, o.Results.ybars);

                otherwise
                    error("Invalid 'sysType' name.")
            end
        end

    end
end