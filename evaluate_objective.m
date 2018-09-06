function f = evaluate_objective(x, M,V,AtA1,AtA2,AtA3,YtY1,YtY2,YtY3,c_f,c_b,c_l,AtY1,AtY2,AtY3)

%% function f = evaluate_objective(x, M, V)
% Function to evaluate the objective functions for the given input vector
% x. x is an array of decision variables and f(1), f(2), etc are the
% objective functions. The algorithm always minimizes the objective
% function hence if you would like to maximize the function then multiply
% the function by negative one. M is the numebr of objective functions and
% V is the number of decision variables. 
%
% This functions is basically written by the user who defines his/her own
% objective function. Make sure that the M and V matches your initial user
% input. Make sure that the 
%
% An example objective function is given below. It has two six decision
% variables are two objective functions.

% f = [];
% %% Objective function one
% % Decision variables are used to form the objective function.
% f(1) = 1 - exp(-4*x(1))*(sin(6*pi*x(1)))^6;
% sum = 0;
% for i = 2 : 6
%     sum = sum + x(i)/4;
% end
% %% Intermediate function
% g_x = 1 + 9*(sum)^(0.25);
% 
% %% Objective function two
% f(2) = g_x*(1 - ((f(1))/(g_x))^2);

%% Kursawe proposed by Frank Kursawe.
% Take a look at the following reference
% A variant of evolution strategies for vector optimization.
% In H. P. Schwefel and R. Männer, editors, Parallel Problem Solving from
% Nature. 1st Workshop, PPSN I, volume 496 of Lecture Notes in Computer 
% Science, pages 193-197, Berlin, Germany, oct 1991. Springer-Verlag. 
%
% Number of objective is two, while it can have arbirtarly many decision
% variables within the range -5 and 5. Common number of variables is 3.
f = [];
% Objective function one
% sum = 0;
% for i = 1 : V - 1
%     sum = sum - 10*exp(-0.2*sqrt((x(i))^2 + (x(i + 1))^2));
% end
% Decision variables are used to form the objective function.

%f(1) =-(YtY1-2.*x(1).*c_b'*AtY2+x(1)^2.*c_b'*AtA*c_b+YtY2-2.*x(2).*c_f'*AtY1+x(2)^2.*c_f'*AtA*c_f);
f(1) = norm(x(1).*(YtY1-2.*c_f'*AtY1+c_f'*AtA1*c_f),2)+norm(x(2).*(YtY2-2.*c_b'*AtY2+c_b'*AtA2*c_b),2)+ norm(x(3).*(YtY3-2.*c_l'*AtY3+c_l'*AtA3*c_l),2);
% Objective function two
% sum = 0;
% for i = 1 : V
%     sum = sum + (abs(x(i))^0.8 + 5*(sin(x(i)))^3);
% end
% Decision variables are used to form the objective function.

%f(2) =-(YtY1-2.*x(2).*c_b'*AtY2+x(2)^2.*c_b'*AtA*c_b+YtY2-2.*x(1).*c_f'*AtY1+x(1)^2.*c_f'*AtA*c_f);
f(2) = -norm(x(1).*(YtY1-2.*c_b'*AtY1+c_b'*AtA2*c_b+YtY1-2.*c_l'*AtY1+c_l'*AtA3*c_l),2)-norm(x(2).*(YtY2-2.*c_f'*AtY2+c_f'*AtA1*c_f+YtY2-2.*c_l'*AtY2+c_l'*AtA3*c_l),2)-norm(x(3).*(YtY3-2.*c_f'*AtY3+c_f'*AtA1*c_f+YtY3-2.*c_b'*AtY3+c_b'*AtA2*c_b),2);

%% Check for error
if length(f) ~= M
    error('The number of decision variables does not match you previous input. Kindly check your objective function');
end