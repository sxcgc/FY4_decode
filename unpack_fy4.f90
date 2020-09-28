subroutine unpack_fy4(filename,tb1,tb2,tb3,tb4,tb5,tb6,tb7,tb8,tb9,tb10,&
    tb11,tb12,tb13,tb14,SunZen,SateZen,SunAzi)
    implicit none
    character*500 filename
    real*4  tb1(2748,1092),tb2(2748,1092)
    real*4  tb3(2748,1092),tb4(2748,1092)
    real*4  tb5(2748,1092),tb6(2748,1092)
    real*4  tb7(2748,1092),tb8(2748,1092)
    real*4  tb9(2748,1092),tb10(2748,1092)
    real*4  tb11(2748,1092),tb12(2748,1092)
    real*4  tb13(2748,1092),tb14(2748,1092)
    real*4  SunZen(2748,1092),SateZen(2748,1092),SunAzi(2748,1092)
!f2py intent(in) filename
!f2py intent(out) tb1,tb2,tb3,tb4,tb5,tb6,tb7,tb8,tb9,tb10,tb11,tb12,tb13,tb14,SunZen,SateZen,SunAzi
    open(12,file = trim(filename),form = "unformatted",&
    access = "direct",recl = 4*2748*1092)
    read(12,rec = 1)  tb1
    read(12,rec = 2)  tb2
    read(12,rec = 3)  tb3
    read(12,rec = 4)  tb4
    read(12,rec = 5)  tb5
    read(12,rec = 6)  tb6
    read(12,rec = 7)  tb7
    read(12,rec = 8)  tb8
    read(12,rec = 9)  tb9
    read(12,rec = 10) tb10
    read(12,rec = 11) tb11
    read(12,rec = 12) tb12
    read(12,rec = 13) tb13
    read(12,rec = 14) tb14
    read(12,rec = 15) SunZen
    read(12,rec = 16) SateZen
    read(12,rec = 17) SunAzi
    close(12)
end subroutine

subroutine unpack_fy4_latlon(filename,lat,lon)
    implicit none
    character*500 filename
    real*4  lat(2748,1092),lon(2748,1092)
!f2py intent(in) filename
!f2py intent(out) lat,lon
    open(12,file = trim(filename),form = "unformatted",&
    access = "direct",recl = 4*2748*1092)
    read(12,rec = 1) lat
    read(12,rec = 2) lon
    close(12)
end subroutine unpack_fy4_latlon

subroutine unpack_fy4_retau(filename,re,tau)
    implicit none
    character*500 filename
    real*4 re(2748,1092),tau(2748,1092)
!f2py intent(in) filename
!f2py intent(out) tau,re
    open(12,file = trim(filename),form = "unformatted",&
    access = "direct",recl = 4*2748*1092)
    read(12,rec = 2)  tau
    read(12,rec = 3)  re

    close(12)
end subroutine unpack_fy4_retau

subroutine pack_fy4_marker(filename,marker)
    implicit none
    character*500 filename
    real*4 marker(2748,1092)
    open(12,file = trim(filename),form = "unformatted",&
    access = "direct",recl = 4*2748*1092)
    write(12,rec = 1) marker
    
    close(12)
end subroutine pack_fy4_marker
