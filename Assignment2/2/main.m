w1 = 50 + randn(100,1)*5;
w2 = 250 + randn(100,1)*25;

i_0 = 10^-12;
w_e = 500;
tao = 15*10^-3;
tao_s = tao/4;

fr = 1; % Hz
dt = 1/10000; % s
nBins = 5000; % 10 ms spike train
spiketrain1 = rand(100, nBins) < fr*dt;
spiketrain2 = rand(100, nBins) < fr*dt;

sum_current1 = zeros(1,5000);
sum_current2 = zeros(1,5000);

for j = 1:100

	time1 = [];
    time2 = [];
	for i = 1:5000
		if spiketrain1(j,i) == 1
			time1 = [time1; i*0.1];
        end
        if spiketrain2(j,i) == 1
			time2 = [time2; i*0.1];
		end
	end	
	sum_current1 = sum_current1 + current(time1, i_0, w1(j), tao, tao_s);
    sum_current2 = sum_current2 + current(time2, i_0, w2(j), tao, tao_s);
end

t = linspace(1,5000,5000);
figure,plot(t, sum_current1);
xlabel("Time*10");
ylabel("Spike for Poisson Stimulus");
title("Total Current due to various stimulus (w1)");
%savefig("Current_due_to_various_stimulus_w1");
v_output = aef(1,1,sum_current1);
figure,plot(v_output(1,:));
xlabel("Time*10");
ylabel("Spike for Poisson Stimulus");
title("Neuron Response for Poisson Stimulus (Strength Gaussian Distributed)");
%savefig("Neron_response_for_total_current_w1");

figure,plot(t, sum_current2);
xlabel("Time*10");
ylabel("Spike for Poisson Stimulus");
title("Total Current due to various stimulus (w2)");
%savefig("Current_due_to_various_stimulus_w2");
v_output2 = aef(1,1,sum_current2);
figure,plot(v_output2(1,:));
xlabel("Time*10");
ylabel("Spike for Poisson Stimulus");
title("Neuron Response for Poisson Stimulus (Strength Gaussian Distributed) (w2)");
%savefig("Neron_response_for_total_current_w2");


