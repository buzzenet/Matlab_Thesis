function [point_pred vel_pred] = KalmanFilter_Track(point, vel, diff_eq, err_mat, meas_mat, proc_err, meas_err, ite)
%%  Init Values
    point_pred = zeros(2, size(ite));
    vel_pred = point_pred;
    
    point_pred(:,2) = point(:,2);
    vel_pred(:,2) = vel(:,2);

%%  Kalman Equation    
    for i=3:ite
        
%   Measured
        Z = [point(:,i); vel(:,i)];
%   Prediction
        pr_err_mat = diff_eq * err_mat * diff_eq.' + proc_err;
%   Correction        
        kalman_gain = pr_err_mat * meas_mat.' / (meas_mat * pr_err_mat * meas_mat.' + meas_err);
        err_mat = pr_err_mat - meas_mat * kalman_gain * pr_err_mat;
        temp_mat = diff_eq * [point_pred(:,i-1); vel_pred(:,i-1)] + kalman_gain * (Z - meas_mat * diff_eq * [point_pred(:,i-1); vel_pred(:,i-1)]);
        
        point_pred(:,i) = temp_mat(1:2, 1);
        vel_pred(:,i) = temp_mat(3:4, 1);
    end
end