
;load NCL scripts
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/skewt_func.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/wind_rose.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRF_contributed.ncl"
;********************************************************
external FOO  "./sub.FY-4_write.so"
;external FO "./sub.FY-4_GEO.so"
begin
          
     inpath = "/d2/cgc/FY4A/"+datetime
     inpath2= "/d2/cgc/FY4A/"+datetime
     outpath = "/d2/cgc/FY4A_OUTPUT"
     keywords = "Z_SATE_C_BAWX_*_P_FY4A-_AGRI--_N_REGC*FDI*.HDF";
;     Lon = fbindirread("NOM_ITG_2288_2288(0E0N)_LE.dat",0,(/2288,2288/),"float")
;     Lat = fbindirread("NOM_ITG_2288_2288(0E0N)_LE.dat",1,(/2288,2288/),"float")
;     Lon1 = where(Lon.ne.300,Lon + 105.,-999.9)
;     Lat1 = where(Lat.ne.300,Lat,-999.9)
      ;REGC = 

     finames = systemfunc("cd " + inpath + " ; ls " + keywords)
     do i = 0,dimsizes(finames)-1
        finame = finames(i)
        suffix = get_file_suffix(finame, 0)
        fiBaseN = suffix@fBase
        print(i +"    "+ fiBaseN)
        print(inpath +"/" +finame)
        fi = addfile(inpath +"/" +finame , "r")
;        print(fi)
        
        varnames = (/"CALChannel01", "CALChannel02","CALChannel03", \
            "CALChannel04", "CALChannel05","CALChannel06","CALChannel07",\
            "CALChannel08", "CALChannel09","CALChannel10","CALChannel11",\
            "CALChannel12", "CALChannel13","CALChannel14",\
            "NOMChannel01", "NOMChannel02","NOMChannel03", \
            "NOMChannel04", "NOMChannel05","NOMChannel06","NOMChannel07",\
            "NOMChannel08", "NOMChannel09","NOMChannel10","NOMChannel11",\
            "NOMChannel12", "NOMChannel13","NOMChannel14"/)
            
        if ( .not. all(isfilevar(fi, varnames)) ) then
           print("***** " + finame + " not read *****")
           continue
        end if
        foname = outpath +"/"+ fiBaseN + ".bin"
;        print(foname)
        NOMChannel01 = toint(fi->NOMChannel01)
        a=dimsizes(NOMChannel01)
        if (a(0).ne.1092 ) then
           print("***** " + finame + " not read *****")
           delete(NOMChannel01)    
           continue
        end if
        CALChannel01 = fi->CALChannel01
        CALChannel02 = fi->CALChannel02
        NOMChannel02 = toint(fi->NOMChannel02)
        CALChannel03 = fi->CALChannel03
        NOMChannel03 = toint(fi->NOMChannel03)
        CALChannel04 = fi->CALChannel04
        NOMChannel04 = toint(fi->NOMChannel04)
        CALChannel05 = fi->CALChannel05
        NOMChannel05 = toint(fi->NOMChannel05)
        CALChannel06 = fi->CALChannel06
        NOMChannel06 = toint(fi->NOMChannel06)
        CALChannel07 = fi->CALChannel07
        NOMChannel07 = toint(fi->NOMChannel07)
        CALChannel08 = fi->CALChannel08
        NOMChannel08 = toint(fi->NOMChannel08)
        CALChannel09 = fi->CALChannel09
        NOMChannel09 = toint(fi->NOMChannel09)
        CALChannel10 = fi->CALChannel10
        NOMChannel10 = toint(fi->NOMChannel10)
        CALChannel11 = fi->CALChannel11
        NOMChannel11 = toint(fi->NOMChannel11)
        CALChannel12 = fi->CALChannel12
        NOMChannel12 = toint(fi->NOMChannel12)
        CALChannel13 = fi->CALChannel13
        NOMChannel13 = toint(fi->NOMChannel13)
        CALChannel14 = fi->CALChannel14
        NOMChannel14 = toint(fi->NOMChannel14)
        fff = tochar(fiBaseN)
        print(tostring(fff(75:104))+"*")
        finame2 = systemfunc("cd " + inpath2 + " ; ls *GEO*" + tostring(fff(75:104))+"*")
        fgeoname = inpath2+"/"+finame2

        fi = addfile(fgeoname , "r")
;        print(fi)

        varnames1 = (/"NOMSatelliteAzimuth", "NOMSatelliteZenith", \
            "NOMSunAzimuth", "NOMSunZenith"/)
        if ( .not. all(isfilevar(fi, varnames1)) ) then
           print("***** " + finame2 + " not read *****")
           continue
        end if
        
        Column  = fi->ColumnNumber
        Line    = fi->LineNumber
        SateAzi = fi->NOMSatelliteAzimuth
        SateZen = fi->NOMSatelliteZenith
        SunAzi  = fi->NOMSunAzimuth
        SunZen  = fi->NOMSunZenith
        
;       FO::fy4r-geo("./FullMask_Grid_4000.raw","./FY4_AGRI_4KM_latlon.bin",Column,Line)

       FOO::fy4r(foname,CALChannel01, CALChannel02, CALChannel03,\
            CALChannel04, CALChannel05, CALChannel06, CALChannel07,\
            CALChannel08, CALChannel09, CALChannel10, CALChannel11,\
            CALChannel12, CALChannel13, CALChannel14, \
            NOMChannel01, NOMChannel02, NOMChannel03, \
            NOMChannel04, NOMChannel05, NOMChannel06, NOMChannel07,\
            NOMChannel08, NOMChannel09, NOMChannel10, NOMChannel11,\
            NOMChannel12, NOMChannel13, NOMChannel14,\
            SateAzi,SateZen,SunAzi,SunZen)
        delete([/CALChannel01, CALChannel02, CALChannel03, \
            CALChannel04, CALChannel05, CALChannel06, CALChannel07,\
            CALChannel08, CALChannel09, CALChannel10, CALChannel11,\
            CALChannel12, CALChannel13, CALChannel14, \
            NOMChannel01, NOMChannel02, NOMChannel03, \
            NOMChannel04, NOMChannel05, NOMChannel06, NOMChannel07,\
            NOMChannel08, NOMChannel09, NOMChannel10, NOMChannel11,\
            NOMChannel12, NOMChannel13, NOMChannel14,\
            SateAzi,SateZen,SunAzi,SunZen/])
     end do
end
