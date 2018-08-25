function plotYelOverTimeCollated( resultsStruct )
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here

colors          = get(groot,'DefaultAxesColorOrder');

timeline = [12 13 33];

yelTest					= (resultsStruct.yelInsideOverTTest)';
yelControl			= resultsStruct.yelInsideOverTControl';

meanYelTest         = mean((yelTest),2);
meanYelTest					= meanYelTest(timeline(1):timeline(end));
meanYelControl      = mean((yelControl),2);
meanYelControl			= meanYelControl(timeline(1):timeline(end));
errYelTest          = std((yelTest),0,2);
errYelTest					= errYelTest(timeline(1):timeline(end));
errYelControl       = std((yelControl),0,2);
errYelControl				= errYelControl(timeline(1):timeline(end));

x = horzcat([0,0.5,1],3:2:39);
shadedErrorBar(x,meanYelControl,errYelControl...
	,'lineprops',{'.','color',colors(5,:),'linewidth',0.8});
hold on;
shadedErrorBar(x,meanYelTest(),errYelTest()...
	,'lineprops',{'.','color',colors(4,:),'linewidth',0.8});
p1 = plot(nan,nan,'-','color',colors(5,:),'linewidth',3);
p2 = plot(nan,nan,'-','color',colors(4,:), 'linewidth',3);
% plot([0 0],[0 1.3],':k','markersize',1)
% plot([40 40],[0 1.3],':k','markersize',1)
% a1=annotation('textbox',[0.165 0.22 0.05 0.05],'string',sprintf('Iodide\naddition'),'fitboxtotext','on');
% a2=annotation('textbox',[0.38 0.22 0.05 0.05],'string',sprintf('Forskolin\naddition'),'fitboxtotext','on');
ylim([0 1.3])
xlim([-2 40])

title(resultsStruct.condition)
ax = gca;
ax.FontSize = 14;
xlhand = get(gca,'xlabel');
set(xlhand,'string','Time (s)','fontsize',18)
ylhand = get(gca,'ylabel');
set(ylhand,'string','F/F_{max}','fontsize',18)

% legend([p1 p2],sprintf('DMSO +\nForskolin 100nM'),sprintf('DMSO +\nForskolin 100nM +\nNPPB 10uM'),'location','northeast')
% set(gca,'fontsize',20)
% a1.FontSize = 20;
% a2.FontSize = 20;

end

