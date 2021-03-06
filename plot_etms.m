function plot_etms(st_series, etm, folder, start_at)

    % station counter
    if nargin == 4
        if size(start_at,1) == 1
            j = (structfind(st_series,'stnm',start_at):length(st_series))';
        else
            j = sort(start_at);
        end
    else
        j = (1:length(st_series))';
    end

    for i = j'

        % to plot the ETM, there must be something to plot (etm params not
        % empty). Else, skip this station. Maybe we should plot it without
        % an adjusted ETM.
        if ~isempty(etm{i,1})
            % station name
            stnm = st_series(i).stnm;
            index = st_series(i).index;

            % get the epochs for the current station
            t = (st_series(i).epochs)';
            % get the latitude of current station
            lat = st_series(i).lat;
            lon = st_series(i).lon;

            Lx = (st_series(i).x);
            Ly = (st_series(i).y);
            Lz = (st_series(i).z);

            sx = st_series(i).px;
            sy = st_series(i).py;
            sz = st_series(i).pz;

            % ETM parameters
            Ha = etm{i,2};
            C = etm{i,1};
            Cx = C(1,:);
            Cy = C(2,:);
            Cz = C(3,:);

            [Cn,Ce,Cu] = ct2lg(Cx',Cy',Cz',lat*pi/180,lon*pi/180);
            [Ln,Le,Lu] = ct2lg(Lx',Ly',Lz',lat*pi/180,lon*pi/180);

            plot_station(stnm, i, index, lat, lon, t, Ha, Cn, Ce, Cu, Ln, Le, Lu, sx, sy, sz, folder)
        end
    end

end

