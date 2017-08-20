function plotTestForNormality( resultsStruct )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

colors = get(groot,'DefaultAxesColorOrder');

metricMembrane = resultsStruct.yelMembrane ./ resultsStruct.redEntire;

fig = figure;
ax = axes(fig);
hist = histogram(ax,metricMembrane,0:0.025:2.5);
	box on
	set(gca,'fontsize',20)
	xlim([0 2.5])
	ylim([0 400])
	xLab = xlabel('F_{YFP,membrane} / F_{mCh,cell}');
	set(xLab,'fontsize',24)
	yLab = ylabel('Frequency');
	set(yLab,'fontsize',24)
	annotation('textbox',[0.65 0.7 0.1 0.1]...
		,'string',sprintf('N = %d',resultsStruct.localCellN)...
		,'fitboxtotext','on','fontsize',22)
	switch resultsStruct.mutation
		case 'WT'
			hist.FaceColor = colors(2,:);
		case 'F508del/R1070W'
			hist.FaceColor = colors(4,:);
		case 'F508del'
			hist.FaceColor = colors(6,:);
	end

figure
qq = qqplot(metricMembrane);
	box on
	switch resultsStruct.mutation
		case 'WT'
			set(qq(1),'MarkerEdgeColor', colors(2,:));
		case 'F508del/R1070W'
			set(qq(1),'MarkerEdgeColor', colors(4,:));
		case 'F508del'
			set(qq(1),'MarkerEdgeColor', colors(6,:));
	end
	set(qq(3),'color', 'k')
	set(gca,'fontsize',20)
	title('')
	yLab = ylabel(sprintf('F_{YFP,membrane} / F_{mCh,cell}\nQuantiles'));
	set(yLab,'fontsize',24)


end

