function plotYelOverTimeCollated( conditionStruct )
%UNTITLED20 Summary of this function goes here
%   Detailed explanation goes here

colors          = get(groot,'DefaultAxesColorOrder');
yelN            = 70;
testN			= conditionStruct.quenchImageTestN;
controlN        = conditionStruct.quenchImageControlN;
yelTest			= zeros(yelN,testN);
yelControl		= zeros(yelN,testN);
countTest		= 1;
countControl    = 1;


for i = 1:(testN+controlN)
	if      strcmp(conditionStruct.imageQuench(i).test_control,'test')
            yelTest(:,countTest)        = conditionStruct.imageQuench(i).yelInsideOverT;
            countTest                   = countTest + 1;
         
    elseif  strcmp(conditionStruct.imageQuench(i).test_control,'control')
            yelControl(:,countControl)  = conditionStruct.imageQuench(i).yelInsideOverT;
            countControl                = countControl + 1;
    end
end
	
yelControl( :, all(~yelControl,1) )     = []; %remove all columns with only zeros
yelTest( :, all(~yelControl,1) )        = [];

meanYelTest         = mean((yelTest),2);
meanYelControl      = mean((yelControl),2);
errYelTest          = std((yelTest),0,2);
errYelControl       = std((yelControl),0,2);

x = 0:2:130;

shadedErrorBar(x,meanYelControl(5:70),errYelControl(5:70)...
	,'lineprops',{'.','color',colors(5,:),'linewidth',0.8});
hold on;
shadedErrorBar(x,meanYelTest(5:70),errYelTest(5:70)...
	,'lineprops',{'.','linewidth',0.8});
p1 = plot(nan,nan,'-','color',colors(5,:),'linewidth',1);
p2 = plot(nan,nan,'-', 'linewidth',1);
plot([0 0],[0 1.3],':k','markersize',1)
plot([40 40],[0 1.3],':k','markersize',1)
% a1=annotation('textbox',[0.165 0.22 0.05 0.05],'string',sprintf('Iodide\naddition'),'fitboxtotext','on');
% a2=annotation('textbox',[0.38 0.22 0.05 0.05],'string',sprintf('Forskolin\naddition'),'fitboxtotext','on');
ylim([0 1.3])
xlim([-5 140])
title(conditionStruct.mutation)
xlhand = get(gca,'xlabel');
set(xlhand,'string','Time (s)','fontsize',10)
ylhand = get(gca,'ylabel');
set(ylhand,'string','F/F_{max}','fontsize',10)

% legend([p1 p2],'DMSO','DMSO + Forskolin','location','northeast')
% set(gca,'fontsize',10)
% a1.FontSize = 10;
% a2.FontSize = 10;

end

