C     NCLFORTSTART
      subroutine fy4r(foname,CALChannel01, CALChannel02,CALChannel03,
     &     CALChannel04, CALChannel05, CALChannel06, CALChannel07,
     &      CALChannel08, CALChannel09, CALChannel10, CALChannel11, 
     &      CALChannel12, CALChannel13, CALChannel14, 
     &      NOMChannel01, NOMChannel02, NOMChannel03, 
     &      NOMChannel04, NOMChannel05, NOMChannel06, NOMChannel07, 
     &      NOMChannel08, NOMChannel09, NOMChannel10, NOMChannel11, 
     &      NOMChannel12, NOMChannel13, NOMChannel14,
     &      SateAzi,SateZen,SunAzi,SunZen) 
      
      implicit none
      character*(*) foname
      real*4 CALChannel01(4096),CALChannel02(4096),CALChannel03(4096),
     &        CALChannel04(4096),CALChannel05(4096),CALChannel06(4096),
     &       CALChannel07(65536),CALChannel08(4096),CALChannel09(4096),
     &        CALChannel10(4096),CALChannel11(4096),CALChannel12(4096),
     &        CALChannel13(4096),CALChannel14(4096)
      integer*4 NOMChannel01(2748,1092),NOMChannel02(2748,1092),
     &           NOMChannel03(2748,1092),NOMChannel04(2748,1092),
     &           NOMChannel05(2748,1092),NOMChannel06(2748,1092),
     &           NOMChannel07(2748,1092),NOMChannel08(2748,1092),
     &           NOMChannel09(2748,1092),NOMChannel10(2748,1092),
     &           NOMChannel11(2748,1092),NOMChannel12(2748,1092),
     &           NOMChannel13(2748,1092),NOMChannel14(2748,1092)
      real*4 SateAzi(2748,1092),SateZen(2748,1092)
      real*4 SunAzi(2748,1092),SunZen(2748,1092)
      real*4 tb(17,2748,1092),phi
      integer*4 i,j
C     NCLEND 
      do i = 1,2748
       do j = 1,1092
        if(NOMChannel01(i,j).le.5000.and.
     &      NOMChannel01(i,j).ge.0) then
          tb(1,i,j) = CALChannel01(NOMChannel01(i,j)+1)
        else
          tb(1,i,j) = -999.9
        end if
        if(NOMChannel02(i,j).le.5000.and.
     &      NOMChannel02(i,j).ge.0) then
          tb(2,i,j) = CALChannel02(NOMChannel02(i,j)+1)
        else
          tb(2,i,j) = -999.9
        end if
        if(NOMChannel03(i,j).le.5000.and.
     &      NOMChannel03(i,j).ge.0) then
          tb(3,i,j) = CALChannel03(NOMChannel03(i,j)+1)
        else
          tb(3,i,j) = -999.9
        end if
        if(NOMChannel04(i,j).le.5000.and.
     &      NOMChannel04(i,j).ge.0) then
          tb(4,i,j) = CALChannel04(NOMChannel04(i,j)+1)
        else
          tb(4,i,j) = -999.9
        end if
        if(NOMChannel05(i,j).le.5000.and.
     &      NOMChannel05(i,j).ge.0) then
          tb(5,i,j) = CALChannel05(NOMChannel05(i,j)+1)
        else
          tb(5,i,j) = -999.9
        end if
        if(NOMChannel06(i,j).le.5000.and.
     &      NOMChannel06(i,j).ge.0) then
          tb(6,i,j) = CALChannel06(NOMChannel06(i,j)+1)
        else
          tb(6,i,j) = -999.9
        end if
        if(NOMChannel07(i,j).le.65534.and.
     &      NOMChannel07(i,j).ge.0) then
          tb(7,i,j) = CALChannel07(NOMChannel07(i,j)+1)
        else
          tb(7,i,j) = -999.9
        end if
        if(NOMChannel08(i,j).le.5000.and.
     &      NOMChannel08(i,j).ge.0) then
          tb(8,i,j) = CALChannel08(NOMChannel08(i,j)+1)
        else
          tb(8,i,j) = -999.9
        end if
        if(NOMChannel09(i,j).le.5000.and.
     &      NOMChannel09(i,j).ge.0) then
          tb(9,i,j) = CALChannel09(NOMChannel09(i,j)+1)
        else
          tb(9,i,j) = -999.9
        end if
        if(NOMChannel10(i,j).le.5000.and.
     &      NOMChannel10(i,j).ge.0) then
          tb(10,i,j) = CALChannel10(NOMChannel10(i,j)+1)
        else
          tb(10,i,j) = -999.9
        end if
        if(NOMChannel11(i,j).le.5000.and.
     &      NOMChannel11(i,j).ge.0) then
          tb(11,i,j) = CALChannel11(NOMChannel11(i,j)+1)
        else
          tb(11,i,j) = -999.9
        end if
        if(NOMChannel12(i,j).le.5000.and.
     &      NOMChannel12(i,j).ge.0) then
          tb(12,i,j) = CALChannel12(NOMChannel12(i,j)+1)
        else
          tb(12,i,j) = -999.9
        end if
        if(NOMChannel13(i,j).le.5000.and.
     &      NOMChannel13(i,j).ge.0) then
          tb(13,i,j) = CALChannel13(NOMChannel13(i,j)+1)
        else
          tb(13,i,j) = -999.9
        end if
        if(NOMChannel14(i,j).le.5000.and.
     &      NOMChannel14(i,j).ge.0) then
          tb(14,i,j) = CALChannel14(NOMChannel14(i,j)+1)
        else
          tb(14,i,j) = -999.9
        end if
        if(SunZen(i,j).le.90.and.SunZen(i,j).ge.0) then
          tb(15,i,j) = SunZen(i,j)
        else
          tb(15,i,j) = -999.9
        end if
        if(SateZen(i,j).le.90.and.SateZen(i,j).ge.0) then
          tb(16,i,j) = SateZen(i,j)
        else
          tb(16,i,j) = -999.9
        end if
        if(SunAzi(i,j).le.360.and.SunAzi(i,j).ge.0.and.
     &      SateAzi(i,j).le.360.and.SateAzi(i,j).ge.0) then
          phi = SunAzi(i,j)-SateAzi(i,j)
          if(phi.le.360.and.phi.gt.180)then
           phi = 360 - phi
          elseif(phi.gt.0.and.phi.le.180)then
           phi = phi
          elseif(phi.gt.-180.and.phi.le.0)then
           phi = -phi
          elseif(phi.ge.-360.and.phi.le.-180)then
           phi = 360+phi
          endif
          tb(17,i,j) = 180 - phi
        else
          tb(17,i,j) = -999.9
        end if
      end do
      end do
      open(41, file=foname, access="direct",
     &   action="write", form="unformatted", recl=2748*1092*4)
      do i = 1,17
      write(41,rec = i)tb(i,:,:)
      enddo
      close(41)
      
      end
