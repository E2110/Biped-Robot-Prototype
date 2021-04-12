function print_estimation_data(estimation_data)
    for i = 1:length(estimation_data)
        parameters = estimation_data(i).parameters;
        verification = estimation_data(i).verification ;

        fprintf(['Method ' num2str(i) ':\n']); 
        fprintf('**************\n');
        fprintf('Parameters:\n');
        fprintf([' mgl: ' num2str(parameters.mgl) ' -> ml: ' num2str(parameters.mgl/9.81) '\n']);
        fprintf([' J: ' num2str(parameters.J) '\n']);
        fprintf([' Km: ' num2str(parameters.Km) '\n']);

        fprintf('Verification:\n');
        fprintf('n_weights -> (w0_avg - w0_est) = w0_error -> w0_error_percent\n')
        for j = 1:length(verification)
            fprintf([' (' strrep(num2str(verification(j).n_weights),'  ',',') ') -> (' num2str(verification(j).w0_avg) ' - '  num2str(verification(j).w0_est) ') = ' num2str(verification(j).w0_error) ' -> '  num2str(verification(j).w0_error_percent) ' %%\n']);
        end
        
        error_sum = sum([estimation_data(i).verification.w0_error].^2);
        fprintf(['Error sum of squares: ' num2str(error_sum) '\n'])
        fprintf('**************\n');
    end
end

