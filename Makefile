# Makefile for draft paper

DOCNAME=report

include $(HOME)/lib/latex.mk

tabs1:
	listfilts.py --object ProximaCenb --latex >tables/totprox.tex
	listfilts.py --object BarnardStar --latex >tables/totbs.tex
	listfilts.py --object Ross154 --latex >tables/totross154.tex
	listobjects.py --targ --lat --dith -1 --noundef >tables/totalobs.tex
	#listobjects.py --cut 4 --lat --noundef >tables/totalvis.tex
	#listfilts.py --lat --obj ProximaCenb BarnardStar Ross154 >tables/totalfilt.tex
	#list_iforb_by_filter.py --type f --gain 1 --lat >tables/totalflat.tex
	#list_iforb_by_filter.py --type b --gain 1 --lat >tables/totalbias.tex
	#listlllllmake_cutofftables.py  --mean 6000:61000 --std :10000 --minv 200: --maxv :65000 --prec=3 --outf tables/selectedflats.tex

pngimages1:
	show_filter_areas.py --ticksize 10 --out images/showusedccd.png
	listobjects_pie.py --targ --dith -1 --exp=.1 --col 'skyblue,yellow,limegreen,pink' --title='' --out images/allobspie.png --ticks=13
	#disp_obj_dates.py --targ P --height 8 --bins 50 --out images/proxhist.png
	#disp_obj_dates.py --targ B --height 8 --bins 50 --out images/bshist.png
	#disp_obj_dates.py --targ R --height 8 --bins 50 --out images/rosshist.png
	disp_obj_dates_together.py --height 10 --out images/rdwarfhist.png
	disp_pms.py --out images/pmprox.png --rarange 0.015 --decrange 0.002 --yrot 45 GJ551
	disp_pms.py --out images/pmbstar.png --rarange 0.002 --decrange 0.02 --yrot 45 GJ699
	disp_pms.py --out images/pmross.png --rarange 0.015 --decrange 0.002 --yrot 45 GJ729
	
pngimages2:
	scripts/make-initexample
	scripts/make-initexample2020
	scripts/make-initexample4
	scripts/gen_demo_lcurve

pngimages3:
	#listobjects_pie.py --cut 4 --dith -1 --exp=.2 --col 'skyblue,yellow,limegreen,pink' --title='Distribution of objects (visible only)' --out images/visobspie.png
	#datedisp.py --width 12 --height 10 --marker=. --outfig images/visobstot.png

	scripts/make-flatbiaseg
	# FIXME image2_display.py --out images/complats1820.png --grey flatdisp g.f.2018.09.fits.gz g.f.2020.03.fits.gz
	show_filter_areas.py --out images/gfiltareas1820.png --sk 1 --filt g
	mastforb_ms_disp.py --stderr=1.3 --out images/mastmean.png
	disp_daily_flat_ms.py --clips 10 --out images/dailyflatall.png
	disp_daily_flat_ms_comm.py --limits 5000:50000 --cutlimit calclimits --limal=.8 --out images/dailyflatcomm.png
	disp_daily_flat_ms_comm.py --limits 5000:50000 --cutlimit calclimits --limal=.8 --trim=50 --out images/dailyflattrim.png
	lreg_comp_4way.py --min 10000 --max 45000:1000:65000 --out images/lregmaxes.png
	lreg_comp_4way.py --min 1000:500:10000 --max 50000 --out images/lregmins.png
	disp_flat_stats.py --logsk --logku --out images/flatdispall.png
	disp_flat_stats.py  --mean 6000:61000 --out images/flatdisplims.png
	disp_flat_stats.py  --std :10000 --mean 6000:61000 --out images/flatdisplimssd10000.png
#	dispdflatms.py --labsize 18 --ticksize 14 --clip 2 --limits 3000:50000 --filter g --cut calclimits --out images/glreg.png
#	dispdflatms.py --labsize 18 --ticksize 14 --clip 2 --limits 3000:50000 --filter i --cut calclimits --out images/ilreg.png#
#	dispdflatms.py --labsize 18 --ticksize 14 --clip 2 --limits 3000:50000 --filter r --cut calclimits --out images/rlreg.png
#	dispdflatms.py --labsize 18 --ticksize 14 --clip 2 --limits 3000:50000 --filter z --cut calclimits --out images/zlreg.pngs
#	montage images/?lreg.png -geometry 1300x1200 -tile 2x2 images/corr.png
#	rm images/?lreg.png

pngimages4:
	scripts/build_negtab allnegpix
	scripts/build_negtab min200negpix 0 "--minv 200: --maxv :61000"
	mastforb_ms_disp.py --bias --stderr=1.3 --out images/mastmeanbias.png
	bias_histdiffs.py --date 17/10/2018 --norm k --repls 6 --bins 50 --out images/biasdiffs.png
	listiforb.py --typ b --date 1/7/2019:30/9/2019 --gain 1|iforb_ms_disp.py --stderrmult 1.2 --out images/ibiasnolim.png
	listiforb.py --typ b --date 1/7/2019:30/9/2019 --gain 1 --nstd_std :3 |iforb_ms_disp.py --stderrmult 1.2 --out images/ibiaslim3std.png
	show_meanorstd.py --me M --ns 10 --out images/mean_allbiaslim250_5000 allbias_min200_max5000
	show_meanorstd.py --me S --ns 10 --out images/std_allbiaslim250_5000 allbias_min200_max5000
	
